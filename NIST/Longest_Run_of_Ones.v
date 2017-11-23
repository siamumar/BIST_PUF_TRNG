`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:05:44 03/13/2014 
// Design Name: 
// Module Name:    Longest_Run_of_Ones 
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
// m-files: longest_run_of_ones.m, longest_run_of_ones_limits.m
//
//////////////////////////////////////////////////////////////////////////////////
module Longest_Run_of_Ones(
    input wire clk,
	 input wire rst,
    input wire rand,
    output wire pass
    );
	 
parameter n = 16, M = 8, k = 3, U = 448018; // U is multiplied by 1024

reg [7:0] count_bits0, count_bits1, count_bits2;
reg [4:0] count_blocks, v0, v1, v2, v3;
reg [2:0] count_run, count_run_max;

wire [20:0] chi_sqr;	
							/*maximum possibel value of chi_sqr calculated as ((16^2)/0.1875)
							16 is the maximum possible value of Vi, where all other Vjs are 0. (x+y)^2 > x^2 + y^2, for x, y > 0
							0.1875 is the minimum value from the pi table.
							10 more bits are added as we multiply chi_sqr by 1024 to increase precision*/
wire en0;
reg en1, en2;
assign en0 = (count_blocks == 0);
calculate_chi_sqr calculate_chi_sqr1(
	.v0(v0), .v1(v1), .v2(v2), .v3(v3),
	.en(en2 & en0),
	.chi_sqr(chi_sqr)
	);
	
	
assign pass = (chi_sqr < U);

always @(posedge clk)
	if (rst) begin // initialize 
		count_bits0 <= 8'HFF;
		count_bits1 <= 8'H00;
		count_bits2 <= 8'H00;
		count_blocks <= 0;
		count_run <= 0;
		count_run_max <= 0;
		v0 <= 0;
		v1 <= 0;
		v2 <= 0;
		v3 <= 0;
		en1 <= 0;
		en2 <= 0;
	end
	else begin 		
		en1 <= en0;
		en2 <= en1;
		
		count_bits0 <= count_bits0 + 1; 
		if (count_bits0 == (M-1)) begin
			count_bits0 <= 0;
			count_blocks <= count_blocks + 1;
			if (count_blocks == (n-1)) begin
				count_blocks <= 0; 
			end
		end
		count_bits1 <= count_bits0;
		count_bits2 <= count_bits1;
		
		if (rand) begin
			if (count_bits0) count_run <= count_run + 1; 
			else count_run <= 1;
		end
		else begin
			count_run <= 0; 
			if (count_run > count_run_max) count_run_max <= count_run; 
		end		
		if (count_bits1 == (M-1)) 
			if (count_run > count_run_max) count_run_max <= count_run; 
			
		if (count_bits2 == (M-1)) begin
			count_run_max <= 0; 
			
			case(count_run_max)
				0: v0 <= v0 + 1;
				1: v0 <= v0 + 1;
				2: v1 <= v1 + 1;
				3: v2 <= v2 + 1;
				4: v3 <= v3 + 1;
				5: v3 <= v3 + 1;
				6: v3 <= v3 + 1;
				7: v3 <= v3 + 1;
				8: v3 <= v3 + 1;
			endcase
		end
		
		if ((en1) & (~en0)) begin
			v0 <= 0;
			v1 <= 0;
			v2 <= 0;
			v3 <= 0;
		end
		
	end

endmodule


module calculate_chi_sqr(
	input wire [4:0]  v0, v1, v2, v3,
	input wire en,
	output wire [20:0] chi_sqr
	);
	
reg [9:0] v0_sqr, v1_sqr, v2_sqr, v3_sqr;
/*
(1024/pi) =	
12	11	10	9	8	7	6	5	4	3	2	1	0	
1	0	0	1	0	1	0	0	1	1	1	1	1	
0	1	0	1	0	1	1	1	0	0	1	0	0	
1	0	0	0	1	0	1	0	1	1	0	1	0	
1	0	1	0	1	0	1	0	1	0	1	0	1	
*/
assign chi_sqr =	  (v0_sqr<<0) + (v0_sqr<<1) + (v0_sqr<<2) + (v0_sqr<<3) + (v0_sqr<<4) + (v0_sqr<<7) + (v0_sqr<<9) + (v0_sqr<<12) 
						+ (v1_sqr<<2) + (v1_sqr<<5) + (v1_sqr<<6) + (v1_sqr<<7) + (v1_sqr<<9) + (v1_sqr<<11)
						+ (v2_sqr<<1) + (v2_sqr<<3) + (v2_sqr<<4) + (v2_sqr<<6) + (v2_sqr<<8) + (v2_sqr<<12) 
						+ (v3_sqr<<0) + (v3_sqr<<2) + (v3_sqr<<4) + (v3_sqr<<6) + (v3_sqr<<8) + (v3_sqr<<10) + (v3_sqr<<12);
always @(*)
	if (en) begin
		v0_sqr <= v0 * v0;
		v1_sqr <= v1 * v1;
		v2_sqr <= v2 * v2;
		v3_sqr <= v3 * v3;
	end		
		
endmodule
 