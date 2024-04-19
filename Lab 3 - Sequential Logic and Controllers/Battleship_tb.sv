`timescale 1ns / 1ps

module Battleship_tb();

    // Inputs
    reg start;
    reg move_up, move_down, move_left, move_right, clk, rst;
    reg player_move;
    reg [2:0] player_ships_input;
    reg confirm_amount_button;

    // Outputs
    wire [2:0] game_ships_amount;
    wire vgaclk;
    wire hsync, vsync;
    wire sync_b, blank_b;
    wire [7:0] r, g, b;
    wire [6:0] ships_placed_seg;
    wire [6:0] player_ships_input_seg;

    // Instanciando el módulo Battleship
    Battleship uut (
        .start(start), 
        .move_up(move_up), .move_down(move_down), .move_left(move_left), .move_right(move_right), .clk(clk), .rst(rst),
        .player_move(player_move),
        .player_ships_input(player_ships_input),
        .confirm_amount_button(confirm_amount_button),
        .game_ships_amount(game_ships_amount),
        .vgaclk(vgaclk),
        .hsync(hsync), .vsync(vsync),
        .sync_b(sync_b), .blank_b(blank_b),
        .r(r), .g(g), .b(b),
        .ships_placed_seg(ships_placed_seg), 
        .player_ships_input_seg(player_ships_input_seg)
    );

    // Generador de reloj
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // Genera un reloj de 100 MHz
    end

    // Procedimiento inicial
    initial begin
        // Inicialización de entradas
        rst = 1;
        start = 0;
        move_up = 0;
        move_down = 0;
        move_left = 0;
        move_right = 0;
        player_move = 0;
        player_ships_input = 0;
        confirm_amount_button = 0;

        // Reset del sistema
        #10;
        rst = 0;
        #10;
        rst = 1;
        #10;
        
        // Configuración de simulación de ejemplo
        player_ships_input = 3; // Establecer 3 barcos
        #10;
        confirm_amount_button = 1; // Confirmar cantidad de barcos
        #10;
        confirm_amount_button = 0;
        #50;

        // Movimiento del jugador
        move_up = 1; #10; move_up = 0; #10;
        move_right = 1; #10; move_right = 0; #10;

        // Ejemplos adicionales de control de movimientos y lógica de juego se añadirían aquí

        // Terminar simulación
        #100;
        $finish;
    end
endmodule
