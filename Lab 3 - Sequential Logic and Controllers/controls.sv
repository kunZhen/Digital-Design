module controls(
    input [2:0] i_actual, j_actual,  // Current coordinates of the player
    input logic move_up, move_down, move_left, move_right,  // Movement controls
    input clk, rst,  // Clock and reset signals
    output reg [2:0] i_next, j_next  // Next coordinates of the player
);

    parameter MAX_INDEX = 4;  // Maximum board index, for a 5x5 grid

    always @(negedge clk or negedge rst) begin
        if (!rst) begin
            // Reset condition, reset only the next position outputs
            i_next <= 0;
            j_next <= 0;
        end else begin
            // Default the next positions to the current positions
            i_next <= i_actual;
            j_next <= j_actual;

            // Vertical movements
            if (move_up && j_actual > 0) begin
                j_next <= j_actual - 1;
            end else if (move_down && j_actual < MAX_INDEX) begin
                j_next <= j_actual + 1;
            end

            // Horizontal movements
            if (move_right && i_actual < MAX_INDEX) begin
                i_next <= i_actual + 1;
            end else if (move_left && i_actual > 0) begin
                i_next <= i_actual - 1;
            end
        end
    end

endmodule
