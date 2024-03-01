module alu #(parameter N = 4)
				(
				input logic[N-1:0] a, b, 
				input logic [2:0] op,
				input logic op_sum, op_subt,
				output logic[N-1:0] result,
				output logic carrying
				);
	
	
	logic sumSubt;
	
	assign sumSubt = op_sum | op_subt; // check to see if addition or substraction is at high level 
	
	assign result = sumSubt ? (4'b1111)
									: (4'b0000);
	
	// instantiate
	
	//sum #(N) adder(a, b, 0, result, carrying);
				

endmodule