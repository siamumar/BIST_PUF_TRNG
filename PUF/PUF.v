`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:04:20 08/17/2014 
// Design Name: 
// Module Name:    PUF 
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

module PUF #(parameter N_CB = 64, N = 16, k = 5)(// k = log2(2N)
	input wire clk,
	input wire [N_CB-1:0] challenge_d,
   input wire [k-1:0] tune_level,
	output wire response
   );
	
	wire [N-1:0] tune_top, tune_bottom;
	
	(* KEEP_HIERARCHY = "TRUE" *)
	Decoder #(N, k) Decoder( 
    .tune_level(tune_level),
    .top(tune_top),
    .bottom(tune_bottom)
    );
	
	wire [N_CB-1:0] challenge;
	
	(* KEEP_HIERARCHY = "TRUE" *)
	input_network #(N_CB) input_network (
		.d(challenge_d),
		.c(challenge)
	);
	
	wire topw, bottomw;
	
	PUF_unit #(N_CB, N) top(
    .in(clk),
	 .challenge(challenge),
	 .tune(tune_top),
    .out(topw)
    ); 
	 
	PUF_unit #(N_CB, N) bottom(
    .in(clk),
	 .challenge(challenge),
	 .tune(tune_bottom),
    .out(bottomw)
    );
	 
	 
	FD arbiter(
		.Q(response),
		.C(topw),
		.D(bottomw)
    );
	 
	 
endmodule
