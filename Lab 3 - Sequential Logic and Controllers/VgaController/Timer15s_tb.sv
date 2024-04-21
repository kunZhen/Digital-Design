`timescale 1ns / 1ps

module Timer15s_tb;

// Inputs
reg clk;
reg rst;

// Outputs
wire timeout;

// Instantiate the Unit Under Test (UUT)
Timer15s uut (
    .clk(clk),
    .rst(rst),
    .timeout(timeout)
);

// Clock generation
initial begin
    clk = 0;
    forever #5 clk = ~clk;  // Generate a 100 MHz clock (10 ns period)
end

// Test sequences
initial begin
    // Initialize Inputs
    rst = 0;
    #100;  // Hold reset low for some time

    rst = 1;  // Release reset
    #(64'd15000000000);  // Simulate for slightly more than 15 seconds (15000000000 ns = 15 seconds)
    
    // Wait for timeout to trigger
    @(posedge timeout);
    $display("Timeout reached at %t", $time);

    // Additional check: the timeout should fire at exactly 15 seconds
    if ($time > 64'd15000000000 + 10) begin
        $display("Test failed: Timeout too late!");
    end else if ($time < 64'd15000000000) begin
        $display("Test failed: Timeout too early!");
    end else begin
        $display("Test passed: Timing is correct.");
    end

    // Finish the simulation
    $finish;
end

endmodule
