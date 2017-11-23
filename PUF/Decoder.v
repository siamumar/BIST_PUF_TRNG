`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:20:50 03/09/2014 
// Design Name: 
// Module Name:    Decoder 
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
module Decoder #(parameter N = 16, k = 5)( // k = log2(2N)
    input wire [k-1:0] tune_level,
    (*S = "YES"*)output reg [N-1:0] top,
    (*S = "YES"*)output reg [N-1:0] bottom
    );
	 
always @(tune_level)
case (tune_level)
31: begin
	 top		=	16'b1111111111111111;
	 bottom	=	16'b0000000000000000;
	 end
30: begin
	 top		=	16'b0111111111111111;
	 bottom	=	16'b0000000000000000;
	 end
29: begin
	 top		=	16'b0011111111111111;
	 bottom	=	16'b0000000000000000;
	 end
28: begin
	 top		=	16'b0001111111111111;
	 bottom	=	16'b0000000000000000;
	 end
27: begin
	 top		=	16'b0000111111111111;
	 bottom	=	16'b0000000000000000;
	 end
26: begin
	 top		=	16'b0000011111111111;
	 bottom	=	16'b0000000000000000;
	 end
25: begin
	 top		=	16'b0000001111111111;
	 bottom	=	16'b0000000000000000;
	 end
24: begin
	 top		=	16'b0000000111111111;
	 bottom	=	16'b0000000000000000;
	 end
23: begin
	 top		=	16'b0000000011111111;
	 bottom	=	16'b0000000000000000;
	 end
22: begin
	 top		=	16'b0000000001111111;
	 bottom	=	16'b0000000000000000;
	 end
21: begin
	 top		=	16'b0000000000111111;
	 bottom	=	16'b0000000000000000;
	 end
20: begin
	 top		=	16'b0000000000011111;
	 bottom	=	16'b0000000000000000;
	 end
19: begin
	 top		=	16'b0000000000001111;
	 bottom	=	16'b0000000000000000;
	 end
18: begin
	 top		=	16'b0000000000000111;
	 bottom	=	16'b0000000000000000;
	 end
17: begin
	 top		=	16'b0000000000000011;
	 bottom	=	16'b0000000000000000;
	 end
16: begin
	 top		=	16'b0000000000000001;
	 bottom	=	16'b0000000000000000;
	 end
15: begin
	 top		=	16'b0000000000000000;
	 bottom	=	16'b0000000000000001;
	 end
14: begin
	 top		=	16'b0000000000000000;
	 bottom	=	16'b0000000000000011;
	 end
13: begin
	 top		=	16'b0000000000000000;
	 bottom	=	16'b0000000000000111;
	 end
12: begin
	 top		=	16'b0000000000000000;
	 bottom	=	16'b0000000000001111;
	 end
11: begin
	 top		=	16'b0000000000000000;
	 bottom	=	16'b0000000000011111;
	 end
10: begin
	 top		=	16'b0000000000000000;
	 bottom	=	16'b0000000000111111;
	 end
 9: begin
	 top		=	16'b0000000000000000;
	 bottom	=	16'b0000000001111111;
	 end
 8: begin
	 top		=	16'b0000000000000000;
	 bottom	=	16'b0000000011111111;
	 end
 7: begin
	 top		=	16'b0000000000000000;
	 bottom	=	16'b0000000111111111;
	 end
 6: begin
	 top		=	16'b0000000000000000;
	 bottom	=	16'b0000001111111111;
	 end
 5: begin
	 top		=	16'b0000000000000000;
	 bottom	=	16'b0000011111111111;
	 end
 4: begin
	 top		=	16'b0000000000000000;
	 bottom	=	16'b0000111111111111;
	 end
 3: begin
	 top		=	16'b0000000000000000;
	 bottom	=	16'b0001111111111111;
	 end
 2: begin
	 top		=	16'b0000000000000000;
	 bottom	=	16'b0011111111111111;
	 end
 1: begin
	 top		=	16'b0000000000000000;
	 bottom	=	16'b0111111111111111;
	 end
 0: begin
	 top		=	16'b0000000000000000;
	 bottom	=	16'b1111111111111111;
	 end

endcase


endmodule
