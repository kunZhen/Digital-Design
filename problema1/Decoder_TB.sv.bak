module Decoder_TB();

	logic [3:0] bcd_input;
	logic [6:0] seven_segments; 
	
	Decoder deco(
	.bcd_input(bcd_input),
	.seven_segments(seven_segments)
	);
	
	initial begin
	
		bcd_input = 4'b0000; #20; //0
		bcd_input = 4'b0001; #20; //1
		bcd_input = 4'b0010; #20; //2
		bcd_input = 4'b0011; #20; //3
		bcd_input = 4'b0100; #20; //4
		bcd_input = 4'b0101; #20; //5
		bcd_input = 4'b0110; #20; //6 
		bcd_input = 4'b0111; #20; //7
		bcd_input = 4'b1000; #20; //8
		bcd_input = 4'b1001; #20; //9
		bcd_input = 4'b1010; #20; //10
		bcd_input = 4'b1011; #20; //11
		bcd_input = 4'b1100; #20; //12
		bcd_input = 4'b1101; #20; //13
		bcd_input = 4'b1110; #20; //14
		bcd_input = 4'b1111; #20; //15
	
	end
endmodule
