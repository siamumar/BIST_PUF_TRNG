`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:38:42 03/10/2014 
// Design Name: 
// Module Name:    Runs 
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
// m - files: runs_limits.m
//
//////////////////////////////////////////////////////////////////////////////////
module Runs(
    input wire clk,
    input wire rst,
    input wire rand,
    output wire pass
    );
	 
parameter N = 20000;

reg [14:0] count_bits0, count_bits1, count_ones, count_runs;
reg rand1;
wire en;
wire p_1, p_2;
assign en = (count_bits1 == (N-1));
assign pass = p_1 & p_2;

decision decision(
	.clk(clk),
	.rst(rst),
	.en(en),
	.count_ones(count_ones),
	.count_runs(count_runs),
	.p_1(p_1),
	.p_2(p_2)
	);

always @(posedge clk)
	if (rst) begin
		count_bits0 <= 15'H7FFF;
		count_bits1 <= 0;
		count_ones <= 0;
		count_runs <= 1;
		rand1 <= 0;
	end
	else begin 
		rand1 <= rand;
		
		count_bits0 <= count_bits0 + 1;
		count_bits1 <= count_bits0;
		if (count_bits0 == (N-1)) begin
			count_bits0 <= 0;
		end
		
		if (rand) count_ones <= count_ones + 1;	
		if (rand1^rand) count_runs <= count_runs + 1;		
		
		if (count_bits1 == (N-1)) begin
			count_ones <= rand;
			count_runs <= rand1^rand + 1;
/*			if ((count_ones <= U) && (count_ones >= L)) pass <= 1;
			else pass <= 0;*/
		end
	end

/*parameter N = 8;

reg [14:0] count_bits, count_ones, count_runs;
reg rand1, p_1, p_2;

assign pass = p_1&p_2;

always @(posedge clk) begin
	rand1 <= rand;
	if (rst) begin
		count_bits <= 0;
		count_ones <= 0;
		count_runs <= 0;
		p_1 <= 1;
		p_2 <= 1;
	end
	else begin 
		count_bits <= count_bits + 1;
		if (rand) count_ones <= count_ones + 1;
		if (rand1^rand) count_runs <= count_runs + 1;
		
		if (count_bits == (N-1)) begin
		
			count_bits <= 0;
			count_ones <= 0;
			count_runs <= 0;
			
				
		end
	end
end*/

endmodule

module decision (
	input wire clk,
	input wire rst,
	input wire en,
	input wire [14:0] count_ones,
	input wire [14:0] count_runs,
	output reg p_1, p_2
	);
	
always @(posedge clk)
	if (rst) begin
		p_1 <= 0;
		p_2 <= 0;
	end
	else begin
		if(en)begin
				// check upper limit
	/*
	count_ones				9818		9840		9874		9921		10080		10127		10161		10182
	count_runs:max						10179		10180		10181		10182		10181		10180		10179
	*/
				if (count_ones < 9818) 
					p_1 <= 0;
				else if (count_ones < 9840) begin
					if (count_runs > 10179) p_1 <= 0;
					else p_1 <= 1;
				end
				else if (count_ones < 9874) begin
					if (count_runs > 10180) p_1 <= 0;
					else p_1 <= 1;
				end
				else if (count_ones < 9921) begin
					if (count_runs > 10181) p_1 <= 0;
					else p_1 <= 1;
				end
				else if (count_ones < 10080) begin
					if (count_runs > 10182) p_1 <= 0;
					else p_1 <= 1;
				end
				else if (count_ones < 10127) begin
					if (count_runs > 10181) p_1 <= 0;
					else p_1 <= 1;
				end
				else if (count_ones <10161) begin
					if (count_runs > 10180) p_1 <= 0;
					else p_1 <= 1;
				end
				else if (count_ones <10182) begin
					if (count_runs > 10179) p_1 <= 0;
					else p_1 <= 1;
				end
				else
					p_1 <= 0;
				
				// check lower limit
	/*
	count_ones				9818		9845		 9883		 9940		10061		10118		10156		10182
	count_runs:min						9815		 9816		 9817		 9818		 9817		 9816		 9815
	*/
				if (count_ones < 9818) 
					p_2 <= 0;
				else if (count_ones < 9845) begin
					if (count_runs < 9815) p_2 <= 0;
					else p_2 <= 1;
				end
				else if (count_ones < 9883) begin
					if (count_runs < 9816) p_2 <= 0;
					else p_2 <= 1;
				end
				else if (count_ones < 9940) begin
					if (count_runs < 9817) p_2 <= 0;
					else p_2 <= 1;
				end
				else if (count_ones < 10061) begin
					if (count_runs < 9818) p_2 <= 0;
					else p_2 <= 1;
				end
				else if (count_ones < 10118) begin
					if (count_runs < 9817) p_2 <= 0;
					else p_2 <= 1;
				end
				else if (count_ones < 10156) begin
					if (count_runs < 9816) p_2 <= 0;
					else p_2 <= 1;
				end
				else if (count_ones <10182) begin
					if (count_runs < 9815) p_2 <= 0;
					else p_2 <= 1;
				end
				else
					p_2 <= 0;
			
			end

	end


endmodule
