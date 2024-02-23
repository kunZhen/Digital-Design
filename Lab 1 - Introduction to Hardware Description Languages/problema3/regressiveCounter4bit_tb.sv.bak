module regressiveCounter4bit_tb();

	reg [3:0] in, out;
	logic decrement, reset;
	
	regressiveCounter #(4) modulo(in, decrement, reset, out);
	
	initial begin
		in = 4'b1011;
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

	