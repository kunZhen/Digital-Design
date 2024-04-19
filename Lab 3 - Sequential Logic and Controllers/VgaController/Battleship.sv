module Battleship (
	input logic start, // 
	input logic move_up, move_down, move_left, move_right, clk, rst,
	input logic player_move, player_place_ship,
	input reg [2:0] amount_of_ships,
	output logic vgaclk,
	output logic hsync, vsync,
	output logic sync_b, blank_b,
	output logic [7:0] r, g, b,
	output logic[6:0] ships_placed_seg,
	output logic[6:0] amount_of_ships_seg
	);
	
	
	reg clk_ms;
	
	reg [2:0] i_actual, j_actual;
	reg [2:0] i_next, j_next;
	
	reg [2:0] pc_ships = 3'b001;
	
	reg [2:0] player_ships = 3'b001; // hacer input en switches
	
	
	logic player_turn, pc_turn, placing_ships, is_victory, is_defeat, finished_placing;
							  
							  
	reg[2:0] ships_placed;
	
	// Definición de los tableros como matrices 5x5 de dos bits
   reg [1:0] tablero_jugador[5][5];
   reg [1:0] tablero_pc[5][5];
							  
							  
	vga_clock clkdiv (
		clk, clk_ms
	);
	

	place_ship place_ship(
		.player_place_ship(player_place_ship), // switch player selected cell
		.placing_ships(placing_ships), // state
		.clk(clk_ms), .rst(rst),
		.amount_of_ships(amount_of_ships),
		.ships_placed(ships_placed),
		.finished_placing(finished_placing) // how many ships have been placed
	);
	
	FSM fsm(
	  .clk(clk),
	  .rst(rst),
	  .start(start),
	  //.time_expired(time_expired),
	  .player_ships(player_ships),
	  .pc_ships(pc_ships),
	  .player_move(player_move),
	  
	  .finished_placing(finished_placing),
	  
	  .placing_ships(placing_ships),
	  .player_turn(player_turn),
	  .pc_turn(pc_turn),
	  .is_victory(is_victory),
	  .is_defeat(is_defeat)
	);
	
	// Instancia del módulo tablero
    tablero game_board (
        .clk(clk_ms),
        .rst(rst),
		  .decision(1),
        .tablero_jugador(tablero_jugador),
        .tablero_pc(tablero_pc)
    );
	
	
	controls movement_controls(
		.i_actual(i_actual), .j_actual(j_actual), .ships_placed(ships_placed), .amount_of_ships(amount_of_ships),
		.move_up(move_up), .move_down(move_down), .move_left(move_left), .move_right(move_right),
		.clk(clk_ms), .rst(rst),
		.i_next(i_next), .j_next(j_next)
	);
	
	updateIndex updateIJ(
		i_next, j_next, clk_ms, rst, player_turn, placing_ships,
		i_actual, j_actual
	);
	
	
	vga vga(
		clk, i_actual, j_actual,
		vgaclk, hsync, vsync, sync_b, blank_b, tablero_jugador,
		tablero_pc, r, g, b
	);
	
	
	decoder ships_placed_deco(ships_placed, ships_placed_seg);
	
	decoder amount_of_ships_deco(amount_of_ships, amount_of_ships_seg);
	
	
	
endmodule
	