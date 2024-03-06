module regressiveCounter2bit_tb();

	reg [1:0] in, out;
	logic decrement, reset;
	
	regressiveCounter #(2) modulo(in, decrement, reset, out);
	
	initial begin
		in = 2'b11;
		decrement = 0;
		reset = 0;
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
		decrement = 1;
		#100
		reset = 1;
	end

		
endmodule

	