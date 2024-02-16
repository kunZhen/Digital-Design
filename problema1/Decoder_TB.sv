module Decoder_TB(
    output logic [6:0] seg_output
    );

  reg [3:0] bcd_input;
  reg [3:0] seg_input_tens;
  reg [3:0] seg_input_units;
  
  wire [4:0] bcd_output;
  wire [6:0] seg_output_units;
  wire [6:0] seg_output_tens;

  Decoder decoder(
    .bcd_input(bcd_input),
    .bcd_output(bcd_output)
  );

  
  Sevenseg seg_tens(
	 .seg_input(seg_input_tens),
	 .seg_output(seg_output_tens)
  );
  
   Sevenseg seg_units(
	 .seg_input(seg_input_units),
	 .seg_output(seg_output_units)
  );
  
  
  initial begin
    // Prueba 1
	 
    bcd_input = 4'b1100;
    #40;
    seg_input_tens = {3'b000, bcd_output[4]};
    seg_input_units = bcd_output[3:0];
    #40;
	 
    $display("Test 1: BCD Input = %b, BCD Output = %b", bcd_input, bcd_output);
    $display("Test 1: Seven Segment Input Tens = %b, Seven Segment Output Tens  = %b", seg_input_tens, seg_output_tens);
    $display("Test 1: Seven Segment Input Units = %b, Seven Segment Output Units = %b", seg_input_units, seg_output_units);
    
    $stop;
	 
  end

endmodule
