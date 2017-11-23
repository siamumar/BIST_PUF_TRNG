`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:09:01 09/03/2014 
// Design Name: 
// Module Name:    XOR_resp 
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
module XOR_resp # (parameter N_PUF = 16)(
    input wire [N_PUF-1:0] R,
	 output wire [3:0] R1,
	 output wire [1:0] R2,
    output wire response
    );
	 
	
	LUT6 #(.INIT(64'h6996966996696996)) XOR00 (
		.O(R1[0]), 
		.I0(R[0]), 
		.I1(R[1]), 
		.I2(R[2]), 
		.I3(R[3]), 
		.I4(1'b0), 
		.I5(1'b0) 
		);
	LUT6 #(.INIT(64'h6996966996696996) ) XOR01 (
		.O(R1[1]), 
		.I0(R[4]), 
		.I1(R[5]), 
		.I2(R[6]), 
		.I3(R[7]), 
		.I4(1'b0), 
		.I5(1'b0) 
		);
	LUT6 #(.INIT(64'h6996966996696996) ) XOR10 (
		.O(R1[2]), 
		.I0(R[8]), 
		.I1(R[9]), 
		.I2(R[10]), 
		.I3(R[11]), 
		.I4(1'b0), 
		.I5(1'b0) 
		);
	LUT6 #(.INIT(64'h6996966996696996) ) XOR11 (
		.O(R1[3]), 
		.I0(R[12]), 
		.I1(R[13]), 
		.I2(R[14]), 
		.I3(R[15]), 
		.I4(1'b0), 
		.I5(1'b0) 
		);
	
	
	LUT6 #(.INIT(64'h6996966996696996) ) XOR0 (
		.O(R2[0]), 
		.I0(R1[0]), 
		.I1(R1[1]), 
		.I2(1'b0), 
		.I3(1'b0), 
		.I4(1'b0), 
		.I5(1'b0) 
		);
	LUT6 #(.INIT(64'h6996966996696996) ) XOR1 (
		.O(R2[1]), 
		.I0(R1[2]), 
		.I1(R1[3]), 
		.I2(1'b0), 
		.I3(1'b0), 
		.I4(1'b0), 
		.I5(1'b0) 
		);
		
		
	LUT6 #(.INIT(64'h6996966996696996) ) XORf (
		.O(response), 
		.I0(R2[0]), 
		.I1(R2[1]), 
		.I2(1'b0), 
		.I3(1'b0), 
		.I4(1'b0), 
		.I5(1'b0) 
		);

endmodule
