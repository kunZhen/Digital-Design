module and_N_bits #(parameter N = 2) (
	input logic [N-1:0] a,
	input logic [N-1:0] b,
	output logic [N-1:0] andResult
);

	assign andResult = a & b;
	
	
endmodule