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
		
		/*
		This state does the following instructions
	   using switch[5] it takes the position of the square and then goes validates 
 		using the buttons it moves around the table and chooses which square he wants to attack the pc's board
		and then it validates whether it hit some part of the boat(yellow) or didnt(green), meaning it updates
		the graphics
		
		
	   So then it validates if pc_ships are equal to 0, if yes it goes to Victory state, if not it goes
		directly into PC_STATE.
		So first validate if numofboatsPC is 0, if not validate if switch[5] its confirmed, 
		
		There is another condition in which there will be a temporizer in which if the player hasn't confirmed
		any position in which he wants to attack, then it will go inmediately to PC 
	
	*/
			next_state_reg = (pc_ships_zero) ? VICTORY :
								  (player_has_move) ? PC_TURN ://cambiar a una función después de que se confirme la casilla que
								  //se quiere atacar
								  PLAYER_TURN;
								  //(If timer is more than 15 seconds):PC_TURN  
      end
		
		
		PC_TURN: begin
		  /*
		  This state does the following instructions
		  first it verifies if ships player equals 0, if it does so enter to DEFEAT state
		  
		  if not, it does all the PC functionality by itself
										% selects a random square and confirms it
										% goes to the player_matrix and sees if the square was a part of a boat or 
										not
										% update the graphics
										
					and then pass it back to the PLAYER TURN
		  */
			next_state_reg = (player_ships_zero) ? DEFEAT :
									(pc_has_move) ? PLAYER_TURN: //cambiar a una variable
									PC_TURN ;
									
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