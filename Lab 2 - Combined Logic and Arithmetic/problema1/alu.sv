module alu #(parameter N = 4)
				(
				input logic[N-1:0] a, b, 
				input logic [2:0] op,
				input logic op_sum, op_subt,
				output logic[N-1:0] result, sumResult, subResult,
				output logic carryingSum, carryingSubt
				);
	
	
	logic sumSubt;
	
	assign sumSubt = op_sum ^ op_subt; // check to see if addition or substraction is at high level 
	
	sum #(N) adder(a, b, 0, sumResult, carryingSum);
	subt #(N) subtract(a, b, 1, subResult, carryingSubt);
	
	// multiplexer
	assign result = sumSubt ? (op_sum ? sumResult : subResult)
									: ( op[2] 	? ( op[1] 	? ( op[0] 	? (4'b1110)   		// 000
																					: (4'b0111) )		// 001
																	: ( op[0] 	? (4'b1100) 		// 010
																					: (4'b0011) ) )   // 011
													: ( op[1] 	? ( op[0] 	? (4'b1100) 		// 100
																					: (4'b0011) )		// 101
																	: ( op[0] 	? (4'b1100) 		// 110
																					: (4'b0011) ) ) );// 111
	
	// instantiate
	
	//sum #(N) adder(a, b, 0, result, carrying);
				

endmodule