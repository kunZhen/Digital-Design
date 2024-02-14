module Decoder_TB;

  reg [3:0] test_input;
  wire [4:0] test_output;

  Decoder uut (
    .binary_input(test_input),
    .bcd_output(test_output)
  );

  initial begin
    // Prueba 1
    test_input = 4'b0000;
    #10;
    $display("Test 1: Input = %b, Output = %b", test_input, test_output);
    
    // Prueba 2
    test_input = 4'b0001;
    #10;
    $display("Test 2: Input = %b, Output = %b", test_input, test_output);
    
    // Prueba 3
    test_input = 4'b0010;
    #10;
    $display("Test 3: Input = %b, Output = %b", test_input, test_output);
    
    // Prueba 4
    test_input = 4'b0111;
    #10;
    $display("Test 4: Input = %b, Output = %b", test_input, test_output);
    
    // Prueba 5
    test_input = 4'b1001;
    #10;
    $display("Test 5: Input = %b, Output = %b", test_input, test_output);

    // Prueba 6
    test_input = 4'b0100;
    #10;
    $display("Test 6: Input = %b, Output = %b", test_input, test_output);

    // Prueba 7
    test_input = 4'b1100;
    #10;
    $display("Test 7: Input = %b, Output = %b", test_input, test_output);

    // Prueba 8
    test_input = 4'b1011;
    #10;
    $display("Test 8: Input = %b, Output = %b", test_input, test_output);

    $stop;
  end

endmodule
