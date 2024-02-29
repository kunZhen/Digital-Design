module alu #(parameter N = 4)
				(
				input logic[N-1:0] a, b, 
				output logic[N-1:0] result,
				output logic carrying
				);
	
	// instantiate
	
	sum #(N) adder(a, b, 0, result, carrying);
				

endmodule