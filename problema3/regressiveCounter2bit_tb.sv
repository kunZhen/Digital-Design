module regressiveCounter2bit_tb();

	reg [1:0] in, out;
	logic decrement, reset;
	
	regressiveCounterLogic #(2) modulo(in, decrement, reset, out);
	
	initial begin
		in = 2'b11;
		decrement = 1;
		reset = 1;
		#100
		decrement = 0;
		#100
		decrement = 1;
		#100
		decrement = 0;
		#100
		decrement = 1;
		#100
		decrement = 0;
		#100
		decrement = 1;
		#100
		decrement = 0;
		#100
		reset = 0;
	end

		
endmodule

	