module alu #(parameter N = 4)
				(
				input logic[N-1:0] a, b, 
				input logic [2:0] op,
				input logic op_sum, op_subt,
				output logic[N-1:0] result,
				output logic carrying
				);
	
	// instantiate
	
	sum #(N) adder(a, b, 0, result, carrying);
				

endmodule