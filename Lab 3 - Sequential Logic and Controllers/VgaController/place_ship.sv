module place_ship (
    input wire player_place_ship, // switch input
    input wire placing_ships,     // placing ships state
    input logic clk, rst,
    input logic [2:0] ship_size_limit, // Maximum size of the ship
    input reg [2:0] amount_of_ships_limit, // Maximum number of ships
    output reg [2:0] ships_placed,
    output logic finished_placing
);

    reg player_place_ship_prev; // Previous value of player_place_ship
    reg placed_once; // Flag to indicate if a ship has been placed in the current cycle
    reg [2:0] current_ship_amount; // Size of the current ship being placed

    always @(negedge clk or negedge rst) begin
        if (!rst) begin
            ships_placed <= 0;
            placed_once <= 0; // Reset placed_once flag
            player_place_ship_prev <= 1'b0; // Initialize to 0
            current_ship_amount <= 3'b000; // Initialize ship size to zero
        end else begin
            // Detect rising edge of player_place_ship
            if (!player_place_ship && !player_place_ship_prev && placing_ships && !placed_once && (current_ship_amount <= amount_of_ships_limit)) begin
                current_ship_amount <= current_ship_amount + 1; // Increment ship size
                ships_placed <= ships_placed + 1;
                placed_once <= 1; // Set flag to indicate ship placed
            end else if (!player_place_ship) begin
                placed_once <= 0; // Reset placed_once flag when player releases the switch
            end

            player_place_ship_prev <= !player_place_ship;
        end
    end
    
    assign finished_placing = (ships_placed == amount_of_ships_limit);

endmodule

