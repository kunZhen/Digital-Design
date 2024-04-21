module Timer15s(
    input clk,  // Clock signal
    input rst,  // Asynchronous reset
    output reg timeout  // Output signal that indicates when 15 seconds have passed
);

	// Constants
	localparam CLOCK_FREQ = 100_000_000;  // 100 MHz clock
	localparam DURATION_SECONDS = 15;
	localparam MAX_COUNT = CLOCK_FREQ * DURATION_SECONDS;

	// 32-bit counter should be sufficient for counting up to 1.5 billion
	reg [31:0] counter;

	always @(negedge clk or negedge rst) begin
		 if (!rst) begin
			  counter <= 0;
			  timeout <= 0;
		 end else if (counter >= MAX_COUNT) begin
			  timeout <= 1;
		 end else begin
			  counter <= counter + 1;
			  timeout <= 0;
		 end
	end

endmodule
