`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:00:11 08/31/2014 
// Design Name: 
// Module Name:    interconnect_network 
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
module interconnect_network #(parameter N_CB = 64, N_PUF = 16)(
	input wire [N_CB-1:0] challenge_i,
	output reg [N_CB*N_PUF-1:0]challenge_d
    );
	 
	 parameter SHIFT = N_CB/N_PUF-1;
	 integer m, i;
	 
	 always@(*) begin
		challenge_d[N_CB*N_PUF-1:N_CB*(N_PUF-1)] = challenge_i;
		for(m = N_PUF-2; m >= 0 ; m = m-1)
			for(i = 0; i < N_CB; i = i+1)
				challenge_d[m*N_CB+i] = challenge_d[(m+1)*N_CB+((i+N_CB-SHIFT/*1*/)%N_CB)];
		//for(m = N_PUF-1; m >= 0 ; m = m-1)
			//challenge_d[m*N_CB-1:(m-1)*N_CB] = {challenge_d[m*N_CB],challenge_d[(m+1)*N_CB-1:m*N_CB+1]};
	 end


endmodule
