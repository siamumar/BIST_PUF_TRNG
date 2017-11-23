module input_network #(parameter N_CB = 32)(
	input wire [N_CB-1:0] d,
	output reg [N_CB-1:0] c
	);
	
	integer k, m;
	
	always @(*) begin
		c[(N_CB+2)/2-1] = d[0];
		for (k = 1;k <= N_CB-1; k = k+2)
			c[(k+1)/2-1] = d[k-1] ^ d[k];
		for (m = 2; m <= N_CB-2; m = m+2)
			c[(N_CB+m+2)/2-1] = d[m-1] ^ d[m];
	end
	
	/*assign c[(N_CB+2)/2-1] = d[0];
	
	genvar gv;
	generate
	for (gv = 1; gv <= N_CB-1; gv = gv+2)
	begin: XOR00
		xor  XOR0(c[(gv+1)/2-1], d[gv-1], d[gv]);
	end
	endgenerate
	
	generate
	for (gv = 2; gv <= N_CB-2; gv = gv+2)
	begin: XOR01
		xor  XOR1(c[(N_CB+gv+2)/2-1], d[gv-1], d[gv]);
	end
	endgenerate*/
	
endmodule 