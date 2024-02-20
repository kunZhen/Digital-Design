module regressiveCounter7Segments_tb();

	reg [5:0] in;
	reg [6:0] display1, display2;
	logic decrement, reset;
	
	regressiveCounter #(6) modulo(in, decrement, reset, display1, display2);
	initial begin
		in = 6'b111110;
		decrement = 1;
		reset = 1;
		#200
		decrement = 0;
		#200
		decrement = 1;
		#200
		decrement = 0;
		#200
		decrement = 1;
		#200
		decrement = 0;
		#200
		decrement = 1;
		#200
		decrement = 0;
		#200
		reset = 0;
	end
	
endmodule