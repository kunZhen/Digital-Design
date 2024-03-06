module alu #(parameter N = 4)
				(
				input logic[N-1:0] a, b, 
				input logic [2:0] op,
				input logic op_sum, op_subt,
				output logic[6:0] units_7segments, tens_7segments,
				output logic[N-1:0] 	result, sumResult, 
											subResult, diviResult, 
											moduResult, andResult,
											orResult, xorResult,
											shift_left_result, shift_right_result,
				output logic [(N*2)-1:0] multiResult,
				output logic carryingSum, carryingSubt,
				output logic flagNeg, flagZero, flagCarry, flagOver
				);
	
	
	logic sumSubt;
	
	assign sumSubt = op_sum ^ op_subt; // check to see if addition or substraction is at high level 
	
	//instantiating arithmetic operations
	sum #(N) adder(a, b, 0, sumResult, carryingSum);
	subt #(N) subtract(a, b, 1, subResult, carryingSubt, flagNeg);
	divid #(N) divi(a, b, diviResult);
	modu #(N) mod(a, b, moduResult);
	BitwiseMultiplier #(N) multiplier(a, b, multiResult);
	
	
	
	// instantiating logic operations
	and_N_bits #(N) and_N(a, b, andResult);
	or_N_bits #(N) or_N(a, b, orResult);
	xor_N_bits #(N) xor_N(a, b, xorResult);
	shift_left #(N) left_shift(a, shift_left_result);
	shift_right #(N) right_shift(a, shift_right_result);
	
	// multiplexer
	assign result = sumSubt ? (op_sum ? sumResult : subResult)
									: ( op[2] 	? ( op[1] 	? ( op[0] 	? (shift_left_result)   		// 000
																					: (shift_right_result) )		// 001
																	: ( op[0] 	? (4'b1100) 		// 010
																					: (4'b0011) ) )   // 011
													: ( op[1] 	? ( op[0] 	? (4'b1100) 		// 100
																					: (xorResult) )		// 101
																	: ( op[0] 	? (orResult) 		// 110
																					: (andResult) ) ) );// 111
	always_comb
		if (result === '0)
			flagZero = 1;
		else 
			flagZero = 0;
	
	// turns the binary result into hexadecimal to show in 7 segments
	decoder decod(result, units_7segments);
				

endmodule