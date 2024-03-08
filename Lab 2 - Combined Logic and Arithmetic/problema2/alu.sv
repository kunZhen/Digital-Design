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
	logic [N-1:0] unitsMultiplier;
	logic [N-1:0] tensMultiplier;
	logic [6:0] tens_7seg;
	logic flagNega;
	
	assign sumSubt = op_sum ^ op_subt; // check to see if addition or substraction is at high level 
	
	//instantiating arithmetic operations
	sum #(N) adder(a, b, 0, sumResult, carryingSum);
	subt #(N) subtract(a, b, 1, subResult, carryingSubt, flagNega);
	divid #(N) divi(a, b, diviResult);
	modu #(N) mod(a, b, moduResult);
	BitwiseMultiplier #(N) multiplier1(a, b, multiResult);
	
	always_comb
    for (int i = 0; i < N; i = i + 1) begin
        unitsMultiplier[i] = multiResult[i];
        tensMultiplier[i] = multiResult[N+i];
    end

	
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
																	: ( op[0] 	? (unitsMultiplier) 		// 010
																					: (diviResult) ) )   // 011
													: ( op[1] 	? ( op[0] 	? (moduResult) 		// 100
																					: (xorResult) )		// 101
																	: ( op[0] 	? (orResult) 		// 110
																					: (andResult) ) ) );// 111
	
	
	always_comb
		if ( (op_subt) )
			flagNeg = flagNega;
		else 
			flagNeg = 0;
				
	always_comb
		if ( (op == 3'b101) | (op == 3'b100) | (op == 3'b011) | (op_sum) )
			flagCarry = 1;
		else 
			flagCarry = 0;
			
	
	// turns the binary result into hexadecimal to show in 7 segments
	decoder decodUnits(result, units_7segments);
	decoder decodTens(tensMultiplier, tens_7seg);
	
	
	always @(*) begin
		 if ( (op == 3'b101) & (tensMultiplier === '0) ) begin
				tens_7segments = tens_7seg;
				flagOver = 0;
		 end
		 else if (op == 3'b101) begin 
				tens_7segments = tens_7seg;
				flagOver = 1;
		 end
		 else if ( (op_sum) & (carryingSum) ) begin 
				tens_7segments = 7'b1111001;
				flagOver = 1;
		 end
		 else begin
				tens_7segments = 7'b1111111;
				flagOver = 0;
		 end
	end
	
		
	always @(*) begin
		 if ((result === '0) & (tensMultiplier === '0))
			  flagZero = 1;
		 else if ((result === '0) & (tensMultiplier !== '0))
			  flagZero = 0;
		 else if (result === '0)
			  flagZero = 1;
		 else begin
			  flagZero = 0;
			  //flagCarry = 0; // Asignación de flagCarry dentro del else
		 end
	end


				

endmodule