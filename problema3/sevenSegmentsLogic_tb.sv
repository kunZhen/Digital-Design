module sevenSegmentsLogic_tb();

	reg[5:0] counter_out;
	reg[7:0] bcd_out;
	reg[6:0] display1_out, display2_out;
	
	binaryToBCD bcd_converter (
        .bin(counter_out),
        .bcd(bcd_out)
    );

    sevenSegmentsDeco segment_display1 (
        .bcd(bcd_out[3:0]),
        .display(display1_out)
    );
	 
	 sevenSegmentsDeco segment_display2 (
        .bcd(bcd_out[7:4]),
        .display(display2_out)
    );	
	initial begin
		counter_out = 6'b111111;
		#200;
		counter_out = 6'b001010;		
		#200;
		counter_out = 6'b000111;
	end
endmodule