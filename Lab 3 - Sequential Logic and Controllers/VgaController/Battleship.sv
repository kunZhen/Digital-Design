module Battleship (
	input logic move_up, move_down, move_left, move_right, clk, rst,
	input logic player_move,

	input reg [2:0] player_ships_input, //cantidad de barcos del jugador que después pasarán a ser iguales
												//a la cantidad de barcos por el PC
						
	input logic confirm_amount_button,
	
	// Graphics --------------------------------------------------------
	// Señal de reloj para el monitor VGA
	output logic vgaclk,
	
	// Señales de sincronización horizontal y vertical para el monitor VGA
	output logic hsync, vsync,
	
	// Señales de sincronización y en blanco para el monitor VGA
	output logic sync_b, blank_b,
	
	//Componentes de color para el monitor VGA
	output logic [7:0] r, g, b,
	

	// 7 segments ------------------------------------------------------
	// siete segmentos para mostrar el número de barcos colocados y la cantidad de barcos restantes.
	output logic[6:0] ships_placed_seg
	);
	
	// Coordenadas actuales del jugador en el tablero
	logic [2:0] i_actual, j_actual; 
	
	// Coordenadas siguientes del jugador en el tablero
	logic [2:0] i_next, j_next; 
	
	// Registro para dividir la frecuencia del reloj clk
	reg clk_ms; 
	
	
	// Cantidad de barcos de la PC (Inicializado con 0 barcos)
	reg [2:0] pc_ships = 3'b000; 

	// Cantidad de barcos del jugador (Inicializado con 0 barcos)
	reg [2:0] player_ships = 3'b000;
	
	
	// For FSM  ---------------------------------------------------------
	logic decision, colocation_ships, player_turn,  pc_turn, is_victory, is_defeat;
	
	logic ships_decided;
	
	logic finished_placing;

	// -------------------------------------------------------------------					  

	

	logic [2:0] player_ships_input_limit = 3'b101;
	
	reg [2:0] player_ships_input_internal; // Señal interna para realizar operaciones

	always_comb begin
		 player_ships_input_internal = (player_ships_input > player_ships_input_limit) ? player_ships_input_limit : player_ships_input;
	end

	// Boards ------------------------------------------------------------
	
	// Definición de los tableros como matrices 5x5 de dos bits
   reg [1:0] tablero_jugador[5][5];
   reg [1:0] tablero_pc[5][5];
							  
							  
	vga_clock clkdiv (
		clk, clk_ms
	);

	
	FSMgame fsm(
	  .clk(clk),
	  .rst(rst),
	  //.time_expired(time_expired),
	  .player_ships(player_ships),
	  .pc_ships_setup(pc_ships),
	  .player_move(player_move),
	  .finished_placing(0),
	  .ships_decided(ships_decided),
	  .decision(decision),
	  .colocation_ships(colocation_ships),
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
		.i_actual(i_actual), .j_actual(j_actual), .ships_placed(0), .amount_of_ships(0),
		.move_up(move_up), .move_down(move_down), .move_left(move_left), .move_right(move_right),
		.clk(clk_ms), .rst(rst),
		.i_next(i_next), .j_next(j_next)
	);
	
	updateIndex updateIJ(
		i_next, j_next, clk_ms, rst, 1, 1,
		i_actual, j_actual
	);
	
	
	vga vga(
		clk, i_actual, j_actual,
		vgaclk, hsync, vsync, sync_b, blank_b, tablero_jugador,
		tablero_pc, r, g, b
	);
	
	
	// Decodifica las señales de barcos colocados y cantidad de barcos restantes para visualización en siete segmentos
	decoder amount_of_ships_deco(player_ships_input_internal, ships_placed_seg);
	
endmodule
	