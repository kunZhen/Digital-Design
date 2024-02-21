module regressiveCounter6bit_tb();

	reg [5:0] in, out;
	logic decrement, reset;
	
	regressiveCounterLogic #(6) modulo(in, decrement, reset, out);
	
	initial begin
		in = 6'b101011;
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

	