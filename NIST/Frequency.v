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
module Frequency(
    input wire clk,
	 input wire rst,
    input wire rand,
    output reg pass
    );
	 
parameter N = 20000, U = 10182, L = 9818;

reg [14:0] count_bits0, count_bits1, count_ones;

always @(posedge clk)
	if (rst) begin
		count_bits0 <= 15'H7FFF;
		count_bits1 <= 0;
		count_ones <= 0;
		pass <= 0;
	end
	else begin 
		count_bits0 <= count_bits0 + 1;
		count_bits1 <= count_bits0;
		if (count_bits0 == (N-1)) begin
			count_bits0 <= 0;
		end
		
		if (rand) count_ones <= count_ones + 1;				
		
		if (count_bits1 == (N-1)) begin
			count_ones <= rand;
			if ((count_ones <= U) && (count_ones >= L)) pass <= 1;
			else pass <= 0;
		end
	end

endmodule
