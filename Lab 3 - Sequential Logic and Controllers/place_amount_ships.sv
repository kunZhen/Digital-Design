module place_amount_ships (
    
    input wire decision,     // placing ships state
    input logic clk, rst,
	 
	 //Because in the Battleship module the shipsizelimit is already resolved, so it only receives the amount
	 //of ships I want to put
	 
	 input logic [2:0] player_amount_ships,
	 
	 input logic [2:0] amount_ships_limit,
	 
    input wire player_confirm_ship, // switch input
	 
	 output logic finished_placing,
	 
	 output logic [2:0] final_player_ships
);

	 reg [2:0] player_amount_ships_reg;

	 always @* begin
		 player_amount_ships_reg = player_amount_ships;
	 end
    reg player_confirm_ship_prev; // Previous value of player_confirm_ship
    reg placed_once; // Flag to indicate if a ship has been placed in the current cycle
    reg [2:0] current_ship_amount ; // Amount of the current ship being placed

    always @(negedge clk or negedge rst) begin
        if (!rst) begin
            
            //placed_once <= 0; // Reset placed_once flag
            player_confirm_ship_prev <= 1'b0; // Initialize to 0
            current_ship_amount <= 3'b000; // Initialize ship amount to zero
        end else begin
            // Detect rising edge of player_confirm_ship
            if (!player_confirm_ship && !player_confirm_ship_prev && decision /*&& !placed_once && (current_ship_amount <= amount_of_ships_limit) */) begin
                current_ship_amount <= current_ship_amount + 1; // Increment ship size
               player_amount_ships_reg <= player_amount_ships_reg - 1;
                //placed_once <= 1; // Set flag to indicate ship placed
            end else if (!player_confirm_ship) begin
                placed_once <= 0; // Reset placed_once flag when player releases the switch
            end

            player_confirm_ship_prev <= !player_confirm_ship;
        end
    end
    
    assign finished_placing = (current_ship_amount == amount_ships_limit);
	 
	 //final_player_ships = current_ship_amount

endmodule
