`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:24:16 04/12/2014 
// Design Name: 
// Module Name:    XOR_tree 
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
module XOR_tree #( parameter N_RO = 32, logN = 5)(
    input wire [N_RO-1:0] in,
    output wire out
    );

wire [N_RO-1:0] X [logN:0] ;

genvar k, m;
generate
for (k = logN; k >= 1; k = k - 1)
begin: XOR_col
//	generate
	for (m = (1<<k)-1; m >= 1; m = m - 2)
	begin: XOR_row
		LUT2 #(
		.INIT(4'b0110) 
		) XOR (
		.O(X[k-1][(m+1)/2-1]), 
		.I0(X[k][m]), 
		.I1(X[k][m-1]) 
		);
	end
	//endgenerate	
end
endgenerate

assign X[logN] = in;
assign out = X[0][0];

endmodule
