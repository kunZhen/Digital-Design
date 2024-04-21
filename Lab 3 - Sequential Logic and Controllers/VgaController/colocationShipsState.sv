module colocationShipsState(
    input logic clk, rst,
    input reg [2:0] i_actual, j_actual,
    input logic colocation_ships_State,
    input logic confirm_colocation_button,
    input reg [2:0] player_ships_input_internal, 
    input reg [2:0] player_ships_placed, // Cantidad de barcos ya colocados
    output reg [2:0] player_actual_ship // Identificador del barco a colocar
);

    
    always @(negedge clk or negedge rst) begin
        if (!rst) begin
            //player_ships_placed = 0;
				player_actual_ship = 0;
        end else if (colocation_ships_State && !confirm_colocation_button) begin
            player_actual_ship = player_ships_input_internal - player_ships_placed;
				//player_ships_placed <= 2;
        end else if (colocation_ships_State && player_ships_placed == 0) begin 
				//player_actual_ship = 3; //player_ships_input_internal - player_ships_placed;
		  end
    end

endmodule
