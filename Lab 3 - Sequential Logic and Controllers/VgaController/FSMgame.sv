module FSMgame (
  input wire clk, // reloj
  input wire rst, // reset

  
  input wire ships_decided,
  input wire finished_placing,
  input wire finished_setUp,
  
  input wire player_has_move,
  input wire pc_ships_zero,
  
  input wire pc_has_move,
  input wire player_ships_zero,
  
  
  
  output wire setup_State,
  output wire decision_State, // Indicates whether the game is in the "DECISION" state.
  output wire colocation_ships_State, // Indicates whether the game is in the "COLOCATION" state.
  output wire player_turn_State, // Indicates whether the game is in the "PLAYER_TURN" state.
  output wire pc_turn_State, // Indicates whether the game is in the "PC_TURN" state.
  output wire is_victory_State, //  Indicates whether the game is in the "VICTORY" state.
  output wire is_defeat_State //  Indicates whether the game is in the "DEFEAT" state.
  
  
);

  // Define estados
  typedef enum logic [2:0] {
    DECISION, // 000
	 COLOCATION, // 001
    SETUP, // 010
    PLAYER_TURN, // 011
    PC_TURN, // 100
    VICTORY, // 101
	 DEFEAT //110
  } fsm_states;

  
  // Variables de los estados actuales y siguientes
  fsm_states current_state, next_state;

  
  // Registros para guardar los estados actuales y siguientes
  fsm_states state_reg, next_state_reg;

  
  // Actualiza el state_reg de acuerdo con clock y reset
  always @(negedge clk or negedge rst) begin
  
    if (!rst) begin
      state_reg <= DECISION;
		
    end else begin
      state_reg <= next_state_reg;
    end
	 
  end
  

  // Lógica de próximo estado
  always @(*) begin
  
    case (state_reg)
	 
      DECISION: begin // Game is in DECISION state, in  which using three switches it will choose how many boats the player 
							//wants to put
        next_state_reg = (ships_decided) ? COLOCATION : DECISION;
      end
		
		COLOCATION: begin 
		/* Game is in COLOCATION state,
			graphics are initiated
			move right,left,up and down to determine whereto put
			placement of the n ships, and then sent to coords(0,0) choosing where the ship color white and boat already put color black
			using switch[4] to confirm the decrease the number of ships that i decided to put
		*/
        next_state_reg = (finished_placing) ? SETUP : COLOCATION;
      end
		
		
      SETUP: begin
		
		/*
		This state do the following functions
		receives from place_ship module number of boats that needs to be put,
		uses a randomnizer module to put all the vertical boats
		define all positions and visualizes board
		
		*/
			//next_state_reg = (time_expired || player_move) ? PC_TURN : PLAYER_TURN; // Remains in "PLAY" state unless the time limit expires or player moves
			next_state_reg = (finished_setUp) ? PLAYER_TURN : SETUP; // Remain in SETUP state until all boats are placed
															//player amount of ships
      end
		
      PLAYER_TURN: begin
            if (pc_ships_zero)
                next_state_reg = VICTORY;
            else if (player_has_move)
                next_state_reg = PC_TURN;
            /*else if (timer_expired)
                next_state_reg = PC_TURN;*/
            else
                next_state_reg = PLAYER_TURN;
      end
		
		
		PC_TURN: begin
            if (player_ships_zero) begin
                next_state_reg = DEFEAT;
            end else if (pc_has_move) begin
                next_state_reg = PLAYER_TURN;
            end else begin
                next_state_reg = PC_TURN; // Stay in PC_TURN if no move has been confirmed
            end
      end
		
		
		
      VICTORY, DEFEAT: begin
        next_state_reg = state_reg;
      end
		
      default: next_state_reg = DECISION;
		
    endcase
	 
  end

  // Lógica de salida
  assign current_state = state_reg;
  assign next_state = next_state_reg;
  
  
  
  assign decision_State = (current_state == DECISION);
  assign colocation_ships_State = (current_state == COLOCATION);
  assign setup_State = (current_state == SETUP);
  assign player_turn_State = (current_state == PLAYER_TURN);
  assign pc_turn_State = (current_state == PC_TURN);
  assign is_victory_State = (current_state == VICTORY);
  assign is_defeat_State = (current_state == DEFEAT);
  

endmodule