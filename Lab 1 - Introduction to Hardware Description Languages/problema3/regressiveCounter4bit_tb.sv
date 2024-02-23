module regressiveCounter4bit_tb();

	reg [3:0] in, out;
	logic decrement, reset;
	
	regressiveCounterLogic #(4) modulo(in, decrement, reset, out);
	
	initial begin
		in = 4'b1011;
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

	