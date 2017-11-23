`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:57:49 04/12/2014 
// Design Name: 
// Module Name:    Test_module 
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
module NIST(
    input wire clk,
    input wire rst,
    input wire rand,
    output wire [7:0] test_result
    );
	 
assign test_result[7] = 0;

Frequency test1(
    .clk(clk),
	 .rst(rst),
    .rand(rand),
    .pass(test_result[0]) 
    );

Frequency_Block test2(
    .clk(clk),
	 .rst(rst),
    .rand(rand),
    .pass(test_result[1]) 
    );

Runs test3(
    .clk(clk),
	 .rst(rst),
    .rand(rand),
    .pass(test_result[2])
    );

Longest_Run_of_Ones test4(
    .clk(clk),
	 .rst(rst),
    .rand(rand),
    .pass(test_result[3]) 
    );
	
Nonoverlapping_template test7(
    .clk(clk),
	 .rst(rst),
    .rand(rand),
    .pass(test_result[4]) 
    );
	
Overlapping_template test8(
    .clk(clk),
	 .rst(rst),
    .rand(rand),
    .pass(test_result[5]) 
    );
	
Cumulative_Sums test13(
    .clk(clk),
	 .rst(rst),
    .rand(rand),
    .pass(test_result[6]) 
    );


endmodule
