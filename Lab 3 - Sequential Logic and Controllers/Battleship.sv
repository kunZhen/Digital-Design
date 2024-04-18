module Battleship(
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
	
	
	
	logic decision, colocation_ships, player_turn,  pc_turn, is_victory, is_defeat ;
							  
							  
	reg[2:0] ships_placed;
	
	logic [2:0] ship_size_limit = 3'b101;

	logic [2:0] amount_of_ships_limit = 3'b101;
	
	reg [2:0] amount_of_ships_internal; // Señal interna para realizar operaciones
	
	// Definición de los tableros como matrices 5x5 de dos bits
   logic [1:0] tablero_jugador[5][5];
   logic [1:0] tablero_pc[5][5];

	always_comb begin
		 amount_of_ships_internal = (amount_of_ships > amount_of_ships_limit) ? amount_of_ships_limit : amount_of_ships;
	end
	
	

// Divide la frecuencia del reloj clk para generar una señal de reloj para el monitor VGA
	vga_clock clkdiv (
		clk, clk_ms
	);
	
	/*FSMgame fsm(
	  .clk(clk),
	  .rst(rst),
	  .start(start),
	  //.time_expired(time_expired),
	  .player_ships(player_ships),
	  .pc_ships_setup(pc_ships),
	  .player_move(player_move),
	  .finished_placing(finished_placing),
	  .decision(decision),
	  .colocation_ships(colocation_ships),
	  .player_turn(player_turn),
	  .pc_turn(pc_turn),
	  .is_victory(is_victory),
	  .is_defeat(is_defeat)
	);
	
	*/
	
	// Instancia del módulo tablero
    tablero game_board (
        .clk(clk),
        .rst(rst),
        .tablero_jugador(tablero_jugador),
        .tablero_pc(tablero_pc)
    );
	
// Genera señales de video VGA para mostrar el tablero del juego en un monitor
	vga vga(
		clk, i_actual, j_actual,
		vgaclk, hsync, vsync, sync_b, blank_b, r, g, b
	);
	
	
endmodule