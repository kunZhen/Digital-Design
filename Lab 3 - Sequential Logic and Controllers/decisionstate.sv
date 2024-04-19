module decisionstate(
    input logic [2:0] player_amount_ships,  // Number of ships to place
    input logic decision,                   // Signal to indicate decision state
    input logic clk,                        // System clock
    input logic rst,                        // Reset
    input logic player_confirm_amount,      // Input switch to confirm number of ships
    output logic ships_decided              // Output to indicate ships have been located
);

    // Process to update the ship location status based on input conditions
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            ships_decided <= 1'b0;  // Reset state of ships_decided
        end else begin
            if (player_amount_ships > 0 && player_confirm_amount && decision) begin
                ships_decided <= 1'b1;  // Set located if conditions are met
            end else begin
                ships_decided <= 1'b0;  // Reset located if conditions are not met
            end
        end
    end

endmodule
