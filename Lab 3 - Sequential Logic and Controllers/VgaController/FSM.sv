module FSM (
  input wire clk, // reloj
  input wire rst, // reset
  input wire start, // game begin
  //input wire time_expired, // Indicates if time limit expired
  input wire boats_placed, // Indicates if the full boat is in the board
  input wire player_ships, //how many ships the player has
  input wire pc_ships, // how many ships the pc has
  input wire player_move,
  output wire player_turn, // Indicates whether the game is in the "PLAYER_TURHN" state.
  output wire pc_turn, // Indicates whether the game is in the "PC_TURN" state.
  output wire is_victory, //  Indicates whether the game is in the "VICTORY" state.
  output wire is_defeat //  Indicates whether the game is in the "DEFEAT" state.
);

  // Define estados
  typedef enum logic [2:0] {
    START,
    PLAYER_TURN,
    PC_TURN,
    VICTORY,
    DEFEAT
  } fsm_states;

  
  // Variablesde los estados actuales y siguientes
  fsm_states current_state, next_state;

  
  // Registros para guardar los estados actuales y siguientes
  fsm_states state_reg, next_state_reg;

  
  // Actualiza el state_reg de acuerdo con clock y reset
  always @(negedge clk or negedge rst) begin
  
    if (!rst) begin
      state_reg <= START;
		
    end else begin
	 
      state_reg <= next_state_reg;
    end
	 
  end
  

  // Lógica de próximo estado
  always @(*) begin
  
    case (state_reg)
	 
      START: begin // Game is in PLAY state once the full boat is placed on the board
        next_state_reg = boats_placed ? PLAYER_TURN : START;
      end
		
      PLAYER_TURN: begin
			//next_state_reg = (time_expired || player_move) ? PC_TURN : PLAYER_TURN; // Remains in "PLAY" state unless the time limit expires or player moves
			next_state_reg = (player_move) ? PC_TURN : PLAYER_TURN; // Remains in "PLAY" state unless the time limit expires or player moves

      end
		
      PC_TURN: begin
			next_state_reg = (pc_ships == 3'b0) ? VICTORY :
								  (player_ships == 3'b0) ? DEFEAT :
								  PLAYER_TURN; // If no victory and no defeat, player turn is next
      end
		
      VICTORY, DEFEAT: begin
        next_state_reg = state_reg;
      end
		
      default: next_state_reg = START;
		
    endcase
	 
  end

  // Lógica de salida
  assign current_state = state_reg;
  assign next_state = next_state_reg;
  assign is_victory = (current_state == VICTORY);
  assign is_defeat = (current_state == DEFEAT);
  assign player_turn = (current_state == PLAYER_TURN);
  assign pc_turn = (current_state == PC_TURN);

endmodule