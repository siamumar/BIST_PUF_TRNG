`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:55:30 03/10/2014 
// Design Name: 
// Module Name:    Frequency 
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
module Overlapping_template(
    input wire clk,
	 input wire rst,
    input wire rand,
    output reg pass
    );
	 
parameter n = 1000, M = 1032, K = 5, m = 9, B = 9'b111111111, r = 10, U = 1039448343;

reg [10:0] count_bits0, count_bits1, count_match;
reg [9:0] count_blocks;
reg [10:0] V [0:K];
wire [32:0] chi_sqr; 
reg [m-1:0] cap; 

always @(posedge clk)
	if (rst) begin
		count_bits0 <= 11'H7FF;
		count_bits1 <= 0;
		count_blocks <= 0;
		count_match <= 0;
		V[0] <= 0;
		V[1] <= 0;
		V[2] <= 0;
		V[3] <= 0;
		V[4] <= 0;
		V[5] <= 0;
		cap <= 0;
		pass <= 0;
	end
	else begin
		count_bits0 <= count_bits0 + 1; 
		if (count_bits0 == (M-1)) begin
			count_bits0 <= 0;
			count_blocks <= count_blocks + 1;
			if (count_blocks == (n-1)) begin
				count_blocks <= 0; 
			end
		end
		count_bits1 <= count_bits0;
		
		cap <= {cap[m-2:0],rand};
		if (~(|(cap^B))) count_match <= count_match + 1;			
		if (count_bits1 == (M-1)) begin
			cap <= 0;
			count_match <= 0;
			if (count_match < K) 
				V[count_match] <= V[count_match] + 1;
			else
				V[K] <= V[K] + 1;			
		end
		
		if (count_blocks == 0)
			if (count_bits1 == 0)			
			begin
				//chi_sqr <= 0;
				V[0] <= 0;
				V[1] <= 0;
				V[2] <= 0;
				V[3] <= 0;
				V[4] <= 0;
				V[5] <= 0;
				if (chi_sqr <= U) pass <= 1;
				else pass <= 0;
			end
	end
	
wire en;
assign en = ((count_bits1 == 0)&&(count_blocks == 0));
calculate_chi_sqr_8 #(K)calculate_chi_sqr_88(
	.V0(V[0]),.V1(V[1]),.V2(V[2]),.V3(V[3]),.V4(V[4]),.V5(V[5]),
	.en(en),
	.chi_sqr(chi_sqr)
	);
	
endmodule

module calculate_chi_sqr_8 #(parameter K = 5)(
	input wire [10:0] V0, V1, V2, V3, V4, V5,
	input wire en,
	output wire [32:0] chi_sqr
	);
	
reg [21:0] V_sqr [0:K];
/*
(1024/pi) =	
13	12	11	10	9	8	7	6	5	4	3	2	1	0	
0	0	1	0	1	0	1	1	1	1	1	1	0	0	
0	1	0	1	0	1	1	0	0	0	1	0	1	1	
0	1	1	1	0	0	1	0	1	1	0	0	1	0	
1	0	0	1	1	1	1	1	0	0	0	1	0	1	
1	1	1	0	0	0	1	1	0	0	1	0	1	0	
0	1	1	1	0	0	1	0	0	1	1	0	0	1		
*/
assign chi_sqr =	  (V_sqr[0]<<11) + (V_sqr[0]<<9) + (V_sqr[0]<<7) + (V_sqr[0]<<6) + (V_sqr[0]<<5) + (V_sqr[0]<<4) + (V_sqr[0]<<3) + (V_sqr[0]<<2) 
						+ (V_sqr[1]<<12) + (V_sqr[1]<<10) + (V_sqr[1]<<8) + (V_sqr[1]<<7) + (V_sqr[1]<<3) + (V_sqr[1]<<1) + (V_sqr[1]<<0)
						+ (V_sqr[2]<<12) + (V_sqr[2]<<11) + (V_sqr[2]<<10) + (V_sqr[2]<<7) + (V_sqr[2]<<5) + (V_sqr[2]<<4)  + (V_sqr[2]<<1) 
						+ (V_sqr[3]<<13) + (V_sqr[3]<10) + (V_sqr[3]<<9) + (V_sqr[3]<<8) + (V_sqr[3]<<7) + (V_sqr[3]<<6) + (V_sqr[3]<<2) + (V_sqr[3]<<0)
						+ (V_sqr[4]<<13) + (V_sqr[4]<<12) + (V_sqr[4]<<11) + (V_sqr[4]<<7) + (V_sqr[4]<<6) + (V_sqr[4]<<3) + (V_sqr[4]<<1) 
						+ (V_sqr[5]<<12) + (V_sqr[5]<<11) + (V_sqr[5]<<10) + (V_sqr[5]<<7) + (V_sqr[5]<<4) + (V_sqr[5]<<3) + (V_sqr[5]<<0) ;

//assign chi_sqr =	 25'h0555555 ;

always @(*)
	if (en) begin
		V_sqr[0] <= V0 * V0;
		V_sqr[1] <= V1 * V1;
		V_sqr[2] <= V2 * V2;
		V_sqr[3] <= V3 * V3;
		V_sqr[4] <= V4 * V4;
		V_sqr[5] <= V5 * V5;
	end		
		
endmodule
 