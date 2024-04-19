module controls(
    input logic [2:0] i_actual, j_actual,  // Current coordinates of the player
    input logic move_up, move_down, move_left, move_right,  // Movement controls
    input logic clk, rst,  // Clock and reset signals
    input logic enable, // Enable signal to allow movement
    output reg [2:0] i_next, j_next  // Next coordinates of the player
);
    parameter MAX_INDEX = 4;  // Maximum board index, for a 5x5 grid

    // Use only always_ff block to handle both reset and state updates
    always_ff @(posedge clk or negedge rst) begin
        if (!rst) begin
            i_next <= 0;  // Reset to top-left corner
            j_next <= 0;
        end else if (enable) begin
            // Default to current positions if not moving
            i_next <= i_actual;
            j_next <= j_actual;

            // Handle vertical movements
            if (move_up && i_actual > 0) begin
                i_next <= i_actual - 1;
            end else if (move_down && i_actual < MAX_INDEX) begin
                i_next <= i_actual + 1;
            end

            // Handle horizontal movements
            if (move_left && j_actual > 0) begin
                j_next <= j_actual - 1;
            end else if (move_right && j_actual < MAX_INDEX) begin
                j_next <= j_actual + 1;
            end
        end else begin
            // Maintain current positions if not enabled
            i_next <= i_actual;
            j_next <= j_actual;
        end
    end
endmodule
