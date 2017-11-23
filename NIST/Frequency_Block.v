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
module Frequency_Block(
    input wire clk,
	 input wire rst,
    input wire rand,
    output reg pass
    );
	 
parameter n = 100, M = 200, U = 6790;

reg [7:0] count_bits0, count_bits1, count_ones;
reg [6:0] count_blocks;
reg [19:0] chi_sqr; //log2((M^2)/4*n)

always @(posedge clk)
	if (rst) begin
		count_bits0 <= 8'HFF;
		count_bits1 <= 0;
		count_blocks <= 0;
		count_ones <= 0;
		chi_sqr <= 0;
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
		//count_bits2 <= count_bits1;
		
		if (rand) count_ones <= count_ones + 1;			
		if (count_bits1 == (M-1)) begin
			count_ones <= rand;
			chi_sqr <= chi_sqr + (count_ones - M/2)*(count_ones - M/2);
		end
		
		if (count_blocks == 0)
			if (count_bits1 == 0)			
			begin
				chi_sqr <= 0;
				if (chi_sqr <= U) pass <= 1;
				else pass <= 0;
			end
		
	end
	
endmodule
 