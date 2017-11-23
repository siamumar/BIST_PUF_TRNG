`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:39:42 08/17/2014 
// Design Name: 
// Module Name:    PUF6 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module PUF6 #(parameter N_CB = 64, N_PUF = 16, N = 16, k = 5)( // k = log2(2N)
	input wire clk,
	input wire rst,
	input wire calib_start,
	input wire [N_CB-1:0] challenge_i,
	output reg calib_done,
	output wire response,
	output reg [N_PUF*8*3-1:0] tune_level_all
   );
	
	wire [N_CB-1:0] challenge_i1;
	
	(* KEEP_HIERARCHY = "TRUE" *)
	diffussion2 #(N_CB) diffussion2(
	.B(challenge_i),
	.C(challenge_i1)
    );
		
	wire [N_CB*N_PUF-1:0]challenge_d;
	
	(* KEEP_HIERARCHY = "TRUE" *)
	interconnect_network #(N_CB, N_PUF) interconnect_network(
		.challenge_i(challenge_i1),
		.challenge_d(challenge_d)
	);
	
	reg [k-1:0] tune_level [N_PUF-1:0];
	wire [N_PUF-1:0] R;
	
	genvar gv;
	generate
	for (gv = N_PUF-1; gv >= 0; gv = gv - 1)
	begin: PUF
		(* KEEP_HIERARCHY = "TRUE" *)
		PUF #(N_CB, N, k) PUF(
		.clk(clk),
		.challenge_d(challenge_d[(gv+1)*N_CB-1:gv*N_CB]),
		.tune_level(tune_level[gv]),
		.response(R[gv])
   );
	end
	endgenerate
	
	wire [3:0] R1;
	wire [1:0] R2;
	XOR_resp # (N_PUF) XOR_resp(
    .R(R),
	 .R1(R1),
	 .R2(R2),
    .response(response)
    );	
	 
	 ///////// Calibration /////////

	reg [k-1:0] tune_level_L [N_PUF-1:0];
	reg [k-1:0] tune_level_U [N_PUF-1:0];		
	reg [k-1:0] tune_level_G;	
	reg [k-1:0] tune_level_0 [N_PUF-1:0];
	
	parameter CALIB_ITER = 64000, LOG_CI = 16, U = 32326, L= 31674; // alpha = 0.010000
	reg [LOG_CI-1:0] sum_resp [N_PUF-1:0];
	reg [LOG_CI-1:0] sum_resp_0 [N_PUF-1:0];
	reg signed [LOG_CI-1:0] diff0 [N_PUF-1:0];
	reg signed [LOG_CI-1:0] diff1 [N_PUF-1:0];
	reg [LOG_CI-1:0] count_resp;
	reg [N_PUF-1:0] t ;
	
	reg [2:0]state;
	integer i;	
	
	always @ (negedge clk)
	if (rst) state <= 0;
	else begin
		case(state) 
		0:	begin
				calib_done <= 1'b0;
				if (calib_start) state <= 1;
				else state <= 0;
			end
			
		1: begin
				calib_done <= 1'b0;
				count_resp <= 0;
				tune_level_G <= 0;
				for (i = 0; i < N_PUF; i= i+1) begin
					sum_resp[i] <= 0;
					sum_resp_0[i] <= 0;
					diff0[i] <= CALIB_ITER/2;
					tune_level[i] <= 0;
					tune_level_L[i] <= 4;
					tune_level_U[i] <= 28;//{k{1'b1}};
					tune_level_0[i] <= {(k-1){1'b1}};
          t[i] <= 1'b0;
				end
				state <= 2;
			end
			
		2: begin
				count_resp <= count_resp + 1;
				
        for (i = 0; i < N_PUF/4; i = i+1)
					sum_resp[i] <= sum_resp[i] + R2[0]; //R[i];
				for (i = N_PUF/4; i < N_PUF/2; i = i+1)
					sum_resp[i] <= sum_resp[i] + R2[0]; //R[i];
				for (i = N_PUF/2; i < 3*N_PUF/4; i = i+1)
					sum_resp[i] <= sum_resp[i] + R2[1]; //R[i];
				for (i = 3*N_PUF/4; i < N_PUF; i = i+1)
					sum_resp[i] <= sum_resp[i] + R2[1]; //R[i];

				for (i = 0; i < N_PUF; i = i+1)
					sum_resp_0[i] <= sum_resp_0[i] + R[i];//R2[0];
									
				if (count_resp == CALIB_ITER) state <= 3;
				else state <= 2;
			end
			
		3: begin
				tune_level_G <= tune_level_G + 1;
				for (i = 0; i < N_PUF; i= i+1) begin
					if (sum_resp_0[i] > CALIB_ITER/2) diff1[i] <= sum_resp_0[i] - CALIB_ITER/2;
					else diff1[i] <= CALIB_ITER/2 - sum_resp_0[i];
				end
				state <= 4;
			end
			
		4: begin
				count_resp <= 0;
				for (i = 0; i < N_PUF; i= i+1) begin
        	sum_resp[i] <= 0;
					if ((sum_resp[i] < U) && (sum_resp[i] > L)) begin
						if (~t[i]) begin
							tune_level_L[i] <= tune_level[i];
							tune_level_U[i] <= tune_level[i];
							t[i] <= 1'b1;
						end
						else tune_level_U[i] <= tune_level[i];
					end
					sum_resp_0[i] <= 0;
					tune_level[i] <= tune_level_G;
					if (diff1[i] < diff0[i]) begin						
						tune_level_0[i] <= tune_level_G;
						diff0[i] <= diff1[i];
					end					
				end				
				if (tune_level_G == 0) state <= 5;
				else state <= 2;
			end
			
		5: begin
				for (i = 0; i < N_PUF; i = i+1)
					tune_level[i] <= tune_level_0[i];
				state <= 6;
			end
			
		6: begin
				calib_done <= 1'b1;
				state <= 6;
			end
			
		default: begin
				state <= 6;
			end
			
		endcase
	end
	
	integer m,n;
	always @(*) begin
	
		for (m = 0; m < N_PUF; m = m+1) begin
			for (n = 0; n < k; n = n+1)
				tune_level_all[8*m+n] = tune_level_L[m][n];
			for (n = k; n < 8; n = n+1)
				tune_level_all[8*m+n] = 1'b0;
		end
				
		for (m = 0; m < N_PUF; m = m+1) begin
			for (n = 0; n < k; n = n+1)
				tune_level_all[8*(N_PUF+m)+n] = tune_level_U[m][n];
			for (n = k; n < 8; n = n+1)
				tune_level_all[8*(N_PUF+m)+n] = 1'b0;
		end
				
		for (m = 0; m < N_PUF; m = m+1) begin
			for (n = 0; n < k; n = n+1)
				tune_level_all[8*(2*N_PUF+m)+n] = tune_level_0[m][n];
			for (n = k; n < 8; n = n+1)
				tune_level_all[8*(2*N_PUF+m)+n] = 1'b0;
		end
		
	end
	

endmodule
