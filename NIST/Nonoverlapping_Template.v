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
module Nonoverlapping_template(
    input wire clk,
	 input wire rst,
    input wire rand,
    output reg pass
    );
	 
parameter n = 8, M = 256, m = 4, B = 4'b1011, mu = 253, r = 4, U = 46288; //B = 4'b1100

reg [7:0] count_bits0, count_bits1;
reg [5:0] count_match;
reg [2:0] count_blocks;
reg [21:0] chi_sqr; 
reg [m-1:0] cap; 

always @(posedge clk)
	if (rst) begin
		count_bits0 <= 8'HFF;
		count_bits1 <= 0;
		count_blocks <= 8'HFF;
		count_match <= 0;
		cap <= 0;
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
		
		cap <= {cap[m-2:0],rand};
		if (~(|(cap^B))) count_match <= count_match + 1;		
		if (count_bits1 == (M-1)) begin
			cap <= 0;
			count_match <= 0;
			chi_sqr <= chi_sqr + ((count_match << r) - mu)*((count_match << r) - mu);
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
 