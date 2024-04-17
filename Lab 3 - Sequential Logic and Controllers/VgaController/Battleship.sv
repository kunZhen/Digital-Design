module Battleship (
	input logic start, // 
	input logic move_up, move_down, move_left, move_right, clk, rst,
	input logic player_move, player_place_ship,
	input reg [2:0] amount_of_ships, //cantidad de barcos
	
	// Señal de reloj para el monitor VGA
	output logic vgaclk,
	
	// Señales de sincronización horizontal y vertical para el monitor VGA
	output logic hsync, vsync,
	
	// Señales de sincronización y en blanco para el monitor VGA
	output logic sync_b, blank_b,
	
	//Componentes de color para el monitor VGA
	output logic [7:0] r, g, b,
	
	// siete segmentos para mostrar el número de barcos colocados y la cantidad de barcos restantes.
	output logic[6:0] ships_placed_seg, 
	output logic[6:0] amount_of_ships_seg
	);
	
	
	// Registro para dividir la frecuencia del reloj clk
	reg clk_ms; 
	
	// Coordenadas actuales del jugador en el tablero
	reg [2:0] i_actual, j_actual; 
	
	// Coordenadas siguientes del jugador en el tablero
	reg [2:0] i_next, j_next; 
	
	// Cantidad de barcos de la PC (Inicializado con 0 barcos)
	reg [2:0] pc_ships = 3'b000; 

	// Cantidad de barcos del jugador (Inicializado con 0 barcos)
	reg [2:0] player_ships = 3'b000;
	
	
	logic player_turn, pc_turn, placing_ships, is_victory, is_defeat, finished_placing;
							  
							  
	reg[2:0] ships_placed;
	
	logic [2:0] ship_size_limit = 3'b101;

	logic [2:0] amount_of_ships_limit = 3'b101;
	
	reg [2:0] amount_of_ships_internal; // Señal interna para realizar operaciones

always_comb begin
    amount_of_ships_internal = (amount_of_ships > amount_of_ships_limit) ? amount_of_ships_limit : amount_of_ships;
end
	
	// Divide la frecuencia del reloj clk para generar una señal de reloj para el monitor VGA
	vga_clock clkdiv (
		clk, clk_ms
	);
	
	
							  
	// Controla el proceso de colocación de barcos por parte del jugador
	place_ship place_ship(
		.player_place_ship(player_place_ship), // switch player selected cell
		.placing_ships(placing_ships), // state
		.clk(clk_ms), .rst(rst),
		.ship_size_limit(ship_size_limit),
		.amount_of_ships_limit(amount_of_ships_limit),
		.ships_placed(ships_placed),
		.finished_placing(finished_placing) // how many ships have been placed
	);
	
	
	// Máquina de estados finitos que controla el flujo del juego
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
	
	// Controla el movimiento del jugador en el tablero
	controls movement_controls(
		.i_actual(i_actual), 
		.j_actual(j_actual), 
		.ships_placed(ships_placed), 
		.amount_of_ships(amount_of_ships_internal),
		.move_up(move_up), 
		.move_down(move_down), 
		.move_left(move_left), 
		.move_right(move_right),
		.clk(clk_ms), .rst(rst),
		.i_next(i_next), .j_next(j_next)
	);
	
	// Actualiza las coordenadas del jugador en el tablero
	updateIndex updateIJ(
		i_next, j_next, clk_ms, rst, player_turn, placing_ships,
		i_actual, j_actual
	);
	
	// Genera señales de video VGA para mostrar el tablero del juego en un monitor
	vga vga(
		clk, i_actual, j_actual,
		vgaclk, hsync, vsync, sync_b, blank_b, r, g, b
	);
	
	// Decodifica las señales de barcos colocados y cantidad de barcos restantes para visualización en siete segmentos
	decoder ships_placed_deco(ships_placed, ships_placed_seg);
	decoder amount_of_ships_deco(amount_of_ships_internal, amount_of_ships_seg);
	
	
endmodule
	