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
module Cumulative_Sums(
    input wire clk,
	 input wire rst,
    input wire rand,
    output reg pass
    );
	 
parameter N = 20000, U = 397, L = -397;

reg [14:0] count_bits0, count_bits1, count_bits2;
reg signed [15:0] cum_sum;
wire [14:0] abs_cum_sum;
reg [14:0] max_abs_cum_sum;

assign abs_cum_sum = cum_sum[15]? (-cum_sum) : cum_sum;

always @(posedge clk)
	if (rst) begin
		count_bits0 <= 15'H7FFF;
		count_bits1 <= 0;
		count_bits2 <= 1;
		cum_sum <= 0;
		max_abs_cum_sum <= 0;
		pass <= 0;
	end
	else begin 
		count_bits0 <= count_bits0 + 1;
		count_bits1 <= count_bits0;
		count_bits2 <= count_bits1;
		if (count_bits0 == (N-1)) begin
			count_bits0 <= 0;
		end
		
		if (rand) cum_sum <= cum_sum + 1;	
		else cum_sum <= cum_sum - 1;
		if (count_bits1 == (N-1)) begin
			cum_sum <= rand ? 1 : -1;
		end
		
		if (abs_cum_sum > max_abs_cum_sum) max_abs_cum_sum <= abs_cum_sum;
		if (count_bits2 == (N-1)) begin
			max_abs_cum_sum <= 1;
			if (max_abs_cum_sum <= U) pass <= 1;
			else pass <= 0;
		end 
		
	end

endmodule
