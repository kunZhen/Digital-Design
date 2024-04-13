module Battleship (
	input logic start, move_up, move_down, move_left, move_right, clk, rst, player_move,
	output logic vgaclk,
	output logic hsync, vsync,
	output logic sync_b, blank_b,
	output logic [7:0] r, g, b
	);
	
	
	reg clk_ms;
	reg [2:0] i_actual, j_actual;
	reg [2:0] i_next, j_next;
	reg [2:0] pc_ships = 3'b001;
	reg [2:0] player_ships = 3'b001;
	logic boats_placed = 1;
							  
	vga_clock clkdiv (
		clk, clk_ms
	);
	
	
		FSM fsm(
	  .clk(clk),
	  .rst(rst),
	  .start(start),
	  //.time_expired(time_expired),
	  .boats_placed(boats_placed),
	  .player_ships(player_ships),
	  .pc_ships(pc_ships),
	  .player_move(player_move),
	  .player_turn(player_turn),
	  .pc_turn(pc_turn),
	  .is_victory(is_victory),
	  .is_defeat(is_defeat)
	);
	
	
	
	controls movement_controls(
		i_actual, j_actual, 
		move_up, move_down, move_left, move_right, clk_ms, rst,
		i_next, j_next
	);
	
	updateIndex updateIJ(
		i_next, j_next, clk_ms, rst, player_turn,
		i_actual, j_actual
	);
	
	
	vga vga(
		clk, i_actual, j_actual,
		vgaclk, hsync, vsync, sync_b, blank_b, r, g, b
	);
	
	
	
endmodule
	