`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:25:47 04/12/2014 
// Design Name: 
// Module Name:    TRNG_RO 
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
(*KEEP_HIERARCHY = "TRUE"*)
module TRNG_RO #(parameter n = 3, N_RO = 32, logN = 5)( // n- no of inverters in one ring, N_RO- no of rings
    input wire clk,
    input wire rst,
    output wire rand
    );
	 
(* OPTIMIZE = "OFF" *)

wire [N_RO-1:0] R;	 

genvar k;
generate
for (k = N_RO-1; k >= 0; k = k - 1)
begin: Ring
	Osc_Ring #(n) Ring( 
    .clk(clk),
	 .rst(rst),
    .out(R[k])
    );
end
endgenerate

wire randD;
XOR_tree #(N_RO, logN ) XOR_tree1(
    .in(R),
    .out(randD)
    );
	 
FD Capture (
	.Q (rand),
	.C (clk),
	.D (randD));


endmodule
