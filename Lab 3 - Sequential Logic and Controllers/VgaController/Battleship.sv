module Battleship (
	input logic move_up, move_down, move_left, move_right, clk, rst,
	input logic player_move,

	input reg [2:0] player_ships_input, //cantidad de barcos del jugador que después pasarán a ser iguales
												//a la cantidad de barcos por el PC
						
	input logic confirm_amount_button,
	
	input logic	confirm_colocation_button,
	output logic placement_error,
	
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
	output logic[6:0] ships_placed_seg,
	
	output logic[6:0] ships_left_seg_player,
	
	output logic[6:0] ships_left_seg_pc,
	
	output logic decision_State, colocation_ships_State, setup_State, player_turn_State,  pc_turn_State, is_victory_State, is_defeat_State
	);
	
	// Coordenadas actuales del jugador en el tablero
	logic [2:0] i_actual, j_actual; 
	
	reg [2:0] i_random;
   reg [2:0] j_random;
	
	// Coordenadas siguientes del jugador en el tablero
	logic [2:0] i_next, j_next; 
	
	// Registro para dividir la frecuencia del reloj clk
	reg clk_ms; 
	
	logic confirm_placement;
	// Cantidad de barcos de la PC (Inicializado con 0 barcos)
	reg [2:0] pc_ships = 3'b000; 

	// Cantidad de barcos del jugador (Inicializado con 0 barcos)
	reg [2:0] player_ships = 3'b000;
	
	
	// For FSM  ---------------------------------------------------------
	
	
	logic ships_decided;
	
	logic finished_placing;
	
	logic finished_setUp;
	
	logic update_enable_player_ship;
	
	
	logic player_has_move;
	logic pc_ships_zero;
	
	logic pc_has_move;
	logic player_ships_zero;

	// -------------------------------------------------------------------					  

	

	logic [2:0] player_ships_input_limit = 3'b101;
	
	reg [2:0] player_ships_input_internal; // Señal interna para realizar operaciones
	
	reg [2:0] player_ships_size_internal; // Señal interna para realizar operaciones
	
	reg [2:0] player_ships_placed;
	reg [2:0] player_actual_ship_amount;
	reg [2:0] player_ship_amount_define;
	
	reg[2:0] pc_actual_ship_amount;

	
	always_comb begin
	// Modified to set the number and size of the ships based on player input
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
	  .player_has_move(player_has_move),
	  .pc_ships_zero(0),
	  .pc_has_move(0),
	  .player_ships_zero(0),
	  .finished_placing(finished_placing),
	  .ships_decided(ships_decided),
	  .finished_setUp(finished_setUp),
	  .decision_State(decision_State),
	  .colocation_ships_State(colocation_ships_State),
	  .setup_State(setup_State),
	  .player_turn_State(player_turn_State),
	  .pc_turn_State(pc_turn_State),
	  .is_victory_State(is_victory_State),
	  .is_defeat_State(is_defeat_State)
	);
	
	decisionState decision_mod (
        .player_amount_ships(player_ships_input_internal),   // Conecta con la entrada de barcos del jugador
        .decision_State(decision_State),                            // Asumimos siempre activo para este ejemplo
		  .colocation_ships_State(colocation_ships_State),
        .clk(clk_ms),                                  // Reloj del sistema
        .rst(rst),                                  // Reset del sistema
        .player_confirm_amount(confirm_amount_button),     // Botón de confirmación de cantidad de barcos
		  .ships_decided(ships_decided),
		  //.finished_placing(finished_placing),
		  .player_ship_amount_define(player_ship_amount_define)
	 );
	 
	 /*colocationShipsState shipPlacer (
        .clk(clk),
        .rst(rst),
        .i_actual(i_actual),
        .j_actual(j_actual),
        .colocation_ships_State(colocation_ships_State),
        .confirm_colocation_button(confirm_colocation_button),
        .player_ships_input_internal(player_ships_input_internal),
        .player_ships_placed(player_ships_placed),
        .player_actual_ship(player_actual_ship_amout)
    );*/
	 
	 random_generator my_random_generator(
        .clk(clk),
        .rst(rst),
        .player_ships_input_internal(player_ships_input_internal),  // Ejemplo de semilla inicial
        .i_random(i_random),
        .j_random(j_random)
    );
	
	// Instancia del módulo tablero
    tablero game_board (
        .clk(clk_ms),
        .rst(rst),
		  .i_actual(i_actual),
		  .j_actual(j_actual),
		  .i_random(i_random),
		  .j_random(j_random),
		  .decision_State(decision_State),
		  .colocation_ships_State(colocation_ships_State),
		  .setup_State(setup_State),
		  .confirm_colocation_button(confirm_colocation_button),
		  .player_ships_input_internal(player_ships_input_internal),
		  .player_actual_ship_amount(player_actual_ship_amount),
		  .player_ship_amount_define(player_ship_amount_define),
		  .finished_placing(finished_placing),
		  .pc_actual_ship_amount(pc_actual_ship_amount),
		  .finished_setUp(finished_setUp),
        .tablero_jugador(tablero_jugador),
        .tablero_pc(tablero_pc)
    );
	
	
	controls movement_controls(
		.i_actual(i_actual), 
		.j_actual(j_actual),
		.colocation_ships_State(colocation_ships_State),
		.move_up(move_up), 
		.move_down(move_down), 
		.move_left(move_left), 
		.move_right(move_right),
		.player_ships_input_internal(player_ships_input_internal),
		.clk(clk_ms), 
		.rst(rst),
		.i_next(i_next), 
		.j_next(j_next)
	);
	
	updateIndex updateIJ(
		i_next, j_next, clk_ms, rst, colocation_ships_State, colocation_ships_State,
		i_actual, j_actual
	);
	
	
	vga display (
	.clk(clk),
	.i_actual(i_actual),
	.j_actual(j_actual),
	.tablero_jugador(tablero_jugador),
	.tablero_pc(tablero_pc),
	.player_ships_input_internal(player_ships_input_internal),
	.colocation_ships_State(colocation_ships_State),
	.decision_State(decision_State),
	.player_turn_State(player_turn_State),
	.vgaclk(vgaclk),
	.hsync(hsync),
	.vsync(vsync),
	.sync_b(sync_b),
	.blank_b(blank_b),
	.r(r),
	.g(g),
	.b(b)
	);

	
	
	// Decodifica las señales de barcos colocados y cantidad de barcos restantes para visualización en siete segmentos
	decoder amount_of_ships_deco(player_ships_input_internal, ships_placed_seg);
	decoder amount_of_ships_left_player(player_actual_ship_amount, ships_left_seg_player);
	decoder amount_of_ships_left_pc(pc_actual_ship_amount, ships_left_seg_pc);
	
endmodule
	