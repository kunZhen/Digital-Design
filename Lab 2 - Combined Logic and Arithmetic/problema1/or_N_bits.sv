module or_N_bits #(parameter N = 4) (
	input logic[N-1:0] a,
	input logic[N-1:0] b,
	output logic[N-1:0] orResult
);

	assign orResult = a | b;

endmodule 