module controls(
	input [2:0] i_actual, j_actual,   // Removed 'reg' from input types
	input logic colocation_ships_State,
	input logic player_turn_State,
	input logic [2:0] player_ships_input_internal,
	input logic move_up, move_down, move_left, move_right, clk, rst,
	output reg [2:0] i_next, j_next
);

	parameter MAX_INDEX = 4;
	
	always @(negedge clk or negedge rst) begin
    if (!rst) begin
        i_next = 0;
        j_next = 0;
    end else begin
        if (colocation_ships_State) begin
            // Position is not allowed to move outside the boundary
            // Assuming MAX_INDEX defines the upper boundary of the grid.
            // Assuming player_ships_input_internal is defined elsewhere.

            if (i_actual == MAX_INDEX && move_down == 0) i_next = i_actual;
            else if (i_actual == 3'b000 && move_up == 0) i_next = i_actual;
            else if (j_actual == MAX_INDEX && move_right == 0) j_next = j_actual;
            else if (j_actual == 3'b000 && move_left == 0) j_next = j_actual;
            else begin
                if (!move_up && (i_actual >= 0)) i_next = i_actual - 1; // Update only if not moving off the board
                if (!move_down && (i_actual <= MAX_INDEX)) i_next = i_actual + 1; // Update only if not moving off the board
                if (!move_right && (j_actual + player_ships_input_internal <= MAX_INDEX )) j_next = j_actual + 1; // Adjust for ship size and prevent off-board move
                if (!move_left && (((j_actual + player_ships_input_internal - 1) - player_ships_input_internal)  < -1)) j_next = j_actual - 1; // Adjust for ship size and prevent off-board move
            end
			end else if (player_turn_State) begin 
				if (i_actual == MAX_INDEX && move_down == 0) i_next = i_actual;
				else if(i_actual == 0 && move_up == 0) i_next = i_actual;
				else if(j_actual == MAX_INDEX && move_right == 0) j_next = j_actual;
				else if(j_actual == 0 && move_left == 0) j_next = j_actual;
				else begin
				
					if(!move_up) i_next = i_actual - 1;
					if(!move_down) i_next = i_actual + 1;
					if(!move_right) j_next = j_actual + 1;
					if(!move_left) j_next = j_actual - 1;
				end
			end else begin
            // Assuming you wanted to retain the current value if none of the conditions are true
            i_next = 0;
            j_next = 0;
        end
    end
end


	// The 'can_move' logic is commented out, but looks correct for general direction flags.
	//assign can_move = (!move_up || !move_right || !move_left || !move_down);
endmodule
