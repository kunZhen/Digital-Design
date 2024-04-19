module updateIndex(
    input reg [2:0] i_next, j_next,  // Proposed new coordinates
    input logic clk, rst,  // Clock and reset signals
    input logic enable,  // Enable updating indices only during COLOCATION
    output reg [2:0] i_actual, j_actual  // Actual coordinates on the board
);
    always_ff @(negedge clk or negedge rst) begin
        if (!rst) begin
            i_actual <= 0;  // Reset to top-left corner
            j_actual <= 0;
        end else if (enable) begin
            i_actual <= i_next;
            j_actual <= j_next;
        end
    end
endmodule
