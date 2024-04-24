`timescale 1ns/1ps

module tablero_tb;

    // Inputs
    reg clk;
    reg rst;
    reg [2:0] i_actual, j_actual;
    reg [2:0] i_random_setup;
    reg [2:0] j_random_setup;
    reg [2:0] i_random_attack;
    reg [2:0] j_random_attack;
    reg colocation_ships_State;
    reg decision_State;
    reg setup_State;
    reg confirm_colocation_button;
    reg [2:0] player_ships_input_internal;
    reg [2:0] player_ship_amount_define;
    reg player_turn_State;
    reg confirm_attack_player_to_pc;
    reg pc_turn_State;
    reg is_victory_State;
    reg is_defeat_State;

    // Outputs
    wire finished_placing;
    wire [2:0] player_actual_ship_amount;
    wire [2:0] pc_actual_ship_amount;
    wire finished_setUp;
    wire pc_ships_zero;
    wire player_has_move;
    wire pc_has_move;
    wire player_ships_zero;
    wire [1:0] tablero_jugador[5][5];
    wire [1:0] tablero_pc[5][5];

    // Instantiate the Unit Under Test (UUT)
    tablero uut (
        .clk(clk),
        .rst(rst),
        .i_actual(i_actual), 
        .j_actual(j_actual),
        .i_random_setup(i_random_setup),
        .j_random_setup(j_random_setup),
        .i_random_attack(i_random_attack),
        .j_random_attack(j_random_attack),
        .colocation_ships_State(colocation_ships_State),
        .decision_State(decision_State),
        .setup_State(setup_State),
        .confirm_colocation_button(confirm_colocation_button),
        .player_ships_input_internal(player_ships_input_internal),
        .player_actual_ship_amount(player_actual_ship_amount),
        .player_ship_amount_define(player_ship_amount_define),
        .finished_placing(finished_placing),
        .pc_actual_ship_amount(pc_actual_ship_amount),
        .finished_setUp(finished_setUp),
        .player_turn_State(player_turn_State),
        .confirm_attack_player_to_pc(confirm_attack_player_to_pc),
        .pc_ships_zero(pc_ships_zero),
        .player_has_move(player_has_move),
        .pc_turn_State(pc_turn_State),
        .pc_has_move(pc_has_move),
        .player_ships_zero(player_ships_zero),
        .tablero_jugador(tablero_jugador),
        .tablero_pc(tablero_pc),
        .is_victory_State(is_victory_State),
        .is_defeat_State(is_defeat_State)
    );

    initial begin
        // Initialize Inputs
        clk = 0;
        rst = 1;
        i_actual = 0;
        j_actual = 0;
        i_random_setup = 1;
        j_random_setup = 1;
        i_random_attack = 2;
        j_random_attack = 2;
        colocation_ships_State = 0;
        decision_State = 0;
        setup_State = 0;
        confirm_colocation_button = 0;
        player_ships_input_internal = 3;
        player_ship_amount_define = 5;
        player_turn_State = 0;
        confirm_attack_player_to_pc = 0;
        pc_turn_State = 0;
        is_victory_State = 0;
        is_defeat_State = 0;

        // Reset the system
        #100;
        rst = 0;
        #100;
        rst = 1;

        // Apply initial test values
        colocation_ships_State = 1; // Start ship placement
        confirm_colocation_button = 1; // Confirm placement

        #20;
        confirm_colocation_button = 0; // Release button
        player_turn_State = 1; // Start player's turn
        confirm_attack_player_to_pc = 1; // Confirm attack

        #20;
        confirm_attack_player_to_pc = 0; // Release attack confirmation

        // More tests can be added here
    end

    // Clock generation
    always #10 clk = ~clk; // 50 MHz Clock

endmodule

