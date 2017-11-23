`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:57:57 07/08/2014 
// Design Name: 
// Module Name:    challenge_gen 
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
module challenge_gen #(parameter N_CB = 64)(
    input wire clk,
	 input wire rst,
    output reg [N_CB-1:0] C
    );
	 
	parameter n = 3, N_RO = 32, logN = 5, N_RNG = 4;
	wire [N_RNG-1:0]RAND;
	
	genvar k;
	generate
	for (k = 0; k < N_RNG; k = k + 1)
	begin: TRNG
	TRNG_RO #(n, N_RO, logN) TRNG_RO1( 
    .clk(clk),
    .rst(rst),
    .rand(RAND[k])
    );
	end
	endgenerate
	
	 
	always @(posedge clk)
	begin
		C <= {RAND, C[N_CB-1:N_RNG]}; // {RAND, C[63:4]}
	end
	
	 
	 


endmodule
