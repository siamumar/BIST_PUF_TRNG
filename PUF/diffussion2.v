`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:56:59 09/07/2014 
// Design Name: 
// Module Name:    diffussion 
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

module diffussion2 #(parameter N_CB = 64)(
	input wire [N_CB-1:0] B,
	output wire [N_CB-1:0] C
    );
	 
	 wire [N_CB-1:0] BC, C0;
	 
	 diffussion #(N_CB) diffussion0(
		.B(B),
		.C(BC)
    );
	 
	 diffussion #(N_CB) diffussion1(
		.B(BC),
		.C(C0)
    );
	 
	 integer i;
	 
	 /*always @(*) begin
		for(i = 0; i < N_CB; i = i+2) begin
			C[i] = C0[i/2];
			C[i+1] = C0[i/2+N_CB/2];	
		end
	end*/
	 
	 input_network #(N_CB) input_network (
		.d(C0),
		.c(C)
	);
	 
endmodule


module diffussion #(parameter N_CB = 64)(
	input wire [N_CB-1:0] B,
	output reg [N_CB-1:0] C
    );
	 
	 parameter G = N_CB/16;

	reg [G-1:0] B1 [15:0];
	reg [G-1:0] B2 [15:0];
	reg [G-1:0] C1 [15:0];
	//reg [G-1:0] C2 [15:0];
	
	integer i, j, k;
	
	always @(*) begin
		for (i = 0; i < 16; i = i+1)
			for (j = 0; j < G; j = j+1)
				B1[i][j] = B[i*G+j];
			
		for (i = 0; i < 16; i = i+1)
			for (j = 0; j < G; j = j+1)
				C[i*G+j] = C1[i][j];
				
		for (i = 0; i < N_CB/G; i = i+1)
			B2[i] = B1[(i+(i%4)*4)%(N_CB/G)];
			
		C1[0] 	 = 	 2*B2[0]	+	2*B2[5]	+	3*B2[10]	+	2*B2[15]	;
		C1[1] 	 = 	 2*B2[0]	+	1*B2[5]	+	3*B2[10]	+	1*B2[15]	;
		C1[2] 	 = 	 1*B2[0]	+	1*B2[5]	+	2*B2[10]	+	3*B2[15]	;
		C1[3] 	 = 	 1*B2[0]	+	3*B2[5]	+	1*B2[10]	+	1*B2[15]	;
		C1[4] 	 = 	 2*B2[4]	+	2*B2[9]	+	3*B2[14]	+	2*B2[3]	;
		C1[5] 	 = 	 2*B2[4]	+	1*B2[9]	+	3*B2[14]	+	1*B2[3]	;
		C1[6] 	 = 	 1*B2[4]	+	1*B2[9]	+	2*B2[14]	+	3*B2[3]	;
		C1[7] 	 = 	 1*B2[4]	+	3*B2[9]	+	1*B2[14]	+	1*B2[3]	;
		C1[8] 	 = 	 2*B2[8]	+	2*B2[13]	+	3*B2[2]	+	2*B2[7]	;
		C1[9] 	 = 	 2*B2[8]	+	1*B2[13]	+	3*B2[2]	+	1*B2[7]	;
		C1[10] 	 = 	 1*B2[8]	+	1*B2[13]	+	2*B2[2]	+	3*B2[7]	;
		C1[11] 	 = 	 1*B2[8]	+	3*B2[13]	+	1*B2[2]	+	1*B2[7]	;
		C1[12] 	 = 	 2*B2[12]	+	2*B2[1]	+	3*B2[6]	+	2*B2[11]	;
		C1[13] 	 = 	 2*B2[12]	+	1*B2[1]	+	3*B2[6]	+	1*B2[11]	;
		C1[14] 	 = 	 1*B2[12]	+	1*B2[1]	+	2*B2[6]	+	3*B2[11]	;
		C1[15] 	 = 	 1*B2[12]	+	3*B2[1]	+	1*B2[6]	+	1*B2[11]	;
		
		/*for (k = 0; k < 4; k = k+1)
			for (m = 0; m < 4; m = m+1)
				for (n = 0; n < 4; n = n+1)
					C2[k*4+m] = C2[k*4+m] + M[m*4+n]*B2[(BI[n]+k*4)%16];*/

	end

endmodule
