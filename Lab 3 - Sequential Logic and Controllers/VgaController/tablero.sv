module tablero(
    input logic clk, rst,
    input reg [2:0] i_actual, j_actual,
	 input reg [2:0] i_random,
    input reg [2:0] j_random,
    input logic colocation_ships_State,
    input logic decision_State,  // Señal de decisión para controlar el llenado del tablero
	 input logic setup_State,
    input logic confirm_colocation_button,
    input reg [2:0] player_ships_input_internal,
    output reg [2:0] player_actual_ship_amount,
	 input reg [2:0] player_ship_amount_define,
	 output logic finished_placing,
	 output reg [2:0] pc_actual_ship_amount,
	 output logic finished_setUp,
	 input logic player_turn_State,
	 input logic confirm_attack_player_to_pc,
	 output logic pc_ships_zero,
	 output logic player_has_move,
	 input logic pc_turn_State,
	 output logic pc_has_move,
	 output logic player_ships_zero,
    output reg [1:0] tablero_jugador[5][5],
    output reg [1:0] tablero_pc[5][5]
);

    localparam AGUA = 2'b00;
    localparam BARCO = 2'b01;
    localparam ATACA_BARCO = 2'b10;
    localparam ATACA_AGUA = 2'b11;

    reg confirm_colocation_button_prev;
	 reg confirm_attack_player_to_pc_prev;
	 
	 reg [2:0] i_random_interna;
	 reg [2:0] j_random_interna;
	 
    always_ff @(negedge clk or negedge rst) begin
		 if (!rst) begin
			  fill_with_water();
			  player_actual_ship_amount <= 0;
			  pc_actual_ship_amount <= 0;
			  finished_placing <= 0;
			  confirm_colocation_button_prev <= 1'b0;
			  finished_setUp <= 0;
			  confirm_attack_player_to_pc_prev <= 0;
			  pc_ships_zero <= 0;
			  player_has_move <= 0;
		 end else begin
			  confirm_colocation_button_prev <= confirm_colocation_button; // Update on every cycle for consistent behavior
			  confirm_attack_player_to_pc_prev <= confirm_attack_player_to_pc;
			  if (colocation_ships_State && (player_actual_ship_amount == player_ship_amount_define) ) begin
					finished_placing <= 1;
			  end else if (colocation_ships_State && !confirm_colocation_button && confirm_colocation_button_prev && (player_actual_ship_amount < player_ship_amount_define)) begin
					place_ship();
					player_actual_ship_amount <= player_actual_ship_amount + 1;
			  end else if (setup_State && (pc_actual_ship_amount < player_ship_amount_define) && (tablero_pc[i_random][j_random] != BARCO) ) begin
					i_random_interna = i_random;
					j_random_interna = j_random;
					setUp_pc_ships();
					//pc_actual_ship_amount <= pc_actual_ship_amount + 1;
			  end else if (setup_State && (pc_actual_ship_amount == player_ship_amount_define) ) begin 
					finished_setUp <= 1;
					player_has_move <= 0;
			  end else if (player_turn_State && !confirm_attack_player_to_pc && confirm_attack_player_to_pc_prev) begin 
			  		player_has_move = 1;
					pc_has_move = 0;
					
					if (tablero_pc[i_actual][j_actual] == BARCO) begin
						tablero_pc[i_actual][j_actual] = ATACA_BARCO;
						pc_actual_ship_amount <= pc_actual_ship_amount - 1;
						
						if (pc_actual_ship_amount == 1) begin // change from 0 to 1 because after decrement it will be 0
							pc_ships_zero = 1;
						end
					
					end else begin 
						tablero_pc[i_actual][j_actual] = ATACA_AGUA;
					end
					
			  end else if (pc_turn_State) begin 
					player_has_move = 0;
					pc_has_move = 1;
					
					if (tablero_jugador[i_actual][j_actual] == BARCO) begin
						tablero_jugador[i_actual][j_actual] = ATACA_BARCO;
						player_actual_ship_amount <= player_actual_ship_amount - 1;
						
						if ( player_actual_ship_amount == 1) begin // change from 0 to 1 because after decrement it will be 0
							pc_ships_zero = 1;
						end
					
					end else begin 
						tablero_jugador[i_actual][j_actual] = ATACA_AGUA;
					end
					
			  end 
		 end
	end
	
	 
    // Tarea para llenar los tableros con agua
    task fill_with_water;
        for (int i = 0; i < 5; i++) begin
            for (int j = 0; j < 5; j++) begin
                tablero_jugador[i][j] <= AGUA;
                tablero_pc[i][j] <= AGUA;
            end
        end
    endtask
	 
	 task setUp_pc_ships;
        tablero_pc[i_random_interna][j_random_interna] <= BARCO;
		  /*for (int j = 0; j < j_random; j++) begin
            tablero_pc[i_random][j_random + j] <= BARCO;
        end*/
		  pc_actual_ship_amount <= pc_actual_ship_amount + 1;
    endtask

    task place_ship;
        for (int j = 0; j < player_ships_input_internal; j++) begin
            tablero_jugador[i_actual][j_actual + j] <= BARCO;
        end
    endtask

endmodule
