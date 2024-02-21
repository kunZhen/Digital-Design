module regressiveCounter #(parameter N = 6) (
    input reg [N-1:0] in,
    input logic decrement,
    input logic reset,
    output reg[6:0] display1, output reg[6:0] display2
);

	reg [N-1:0] counter_out; 
	reg [7:0] bcd_out;
	reg [6:0] display1_out, display2_out;

    regressiveCounterLogic #(.N(N)) counter_logic (
        .in(in),
        .decrement(decrement),
        .reset(reset),
        .out(counter_out)
    );

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

    assign display1 = display1_out;
    assign display2 = display2_out;


endmodule


module regressiveCounterLogic #(parameter N = 10) (
    input reg [N-1:0] in,
    input logic decrement,
    input logic reset,
    output reg[N-1:0] out = in
);

	reg [N-1:0] count = 0;
	always_ff @(negedge decrement or negedge reset) begin
		if (~reset)	begin
			out <= in;
			count <= 0;
		end
      else begin
			out <= in - count;
			count <= count + 1;
		end
	end

endmodule


module binaryToBCD(
	input [5:0] bin,
   output reg [7:0] bcd
);
   
	integer i;
	
	always @(bin) begin
		bcd=0;		 	
		for (i=0;i<6;i=i+1) begin
			if (bcd[3:0] >= 5) bcd[3:0] = bcd[3:0] + 3;
			if (bcd[7:4] >= 5) bcd[7:4] = bcd[7:4] + 3;
			bcd = {bcd[6:0],bin[5-i]};
		end
	end
	
endmodule


module sevenSegmentsDeco(
	input reg [3:0] bcd,
	output reg [6:0] display
);
	
	always @ (bcd) begin
		case(bcd)
			0: display = 7'b1000000;
			1: display = 7'b1111001;
			2: display = 7'b0100100;
			3: display = 7'b0110000;
			4: display = 7'b0011001;
			5: display = 7'b0010010;
			6: display = 7'b0000010;
			7: display = 7'b1111000;
			8: display = 7'b0000000;
			9: display = 7'b0010000;
		endcase
	end
	
endmodule

