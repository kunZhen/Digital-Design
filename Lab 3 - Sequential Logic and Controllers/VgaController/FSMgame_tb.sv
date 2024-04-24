`timescale 1ns / 1ps

module FSMgame_tb;

    // Inputs
    reg clk, rst;
    reg ships_decided, finished_placing, finished_setUp;
    reg player_has_move, pc_ships_zero;
    reg pc_has_move, player_ships_zero;

    // Outputs
    wire setup_State, decision_State, colocation_ships_State;
    wire player_turn_State, pc_turn_State, is_victory_State, is_defeat_State;

    // Instantiate the Unit Under Test (UUT)
    FSMgame uut (
        .clk(clk), .rst(rst),
        .ships_decided(ships_decided), .finished_placing(finished_placing), .finished_setUp(finished_setUp),
        .player_has_move(player_has_move), .pc_ships_zero(pc_ships_zero),
        .pc_has_move(pc_has_move), .player_ships_zero(player_ships_zero),
        .setup_State(setup_State), .decision_State(decision_State), .colocation_ships_State(colocation_ships_State),
        .player_turn_State(player_turn_State), .pc_turn_State(pc_turn_State),
        .is_victory_State(is_victory_State), .is_defeat_State(is_defeat_State)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Clock with period of 10 ns
    end

    // Initial setup and test vectors
    initial begin
        // Initialize inputs
        rst = 1; ships_decided = 0; finished_placing = 0; finished_setUp = 0;
        player_has_move = 0; pc_ships_zero = 0; pc_has_move = 0; player_ships_zero = 0;

        // Apply reset
        #10;
        rst = 0;
        #10;
        rst = 1;

        // Begin state transitions
        // Test transition from DECISION to COLOCATION
        ships_decided = 1;
        #10; ships_decided = 0;

        // Test transition from COLOCATION to SETUP
        finished_placing = 1;
        #10; finished_placing = 0;

        // Test transition from SETUP to PLAYER_TURN
        finished_setUp = 1;
        #10; finished_setUp = 0;

        // Simulate PLAYER_TURN moving to PC_TURN and back to PLAYER_TURN
        player_has_move = 1;
        #10; player_has_move = 0;
        pc_has_move = 1;
        #10; pc_has_move = 0;

        // Simulate victory condition
        pc_ships_zero = 1;
        #10; pc_ships_zero = 0;

        // Reset and simulate defeat condition
        player_ships_zero = 1;
        #10;
        
        // Check final states
        $display("Final States: Victory: %b, Defeat: %b", is_victory_State, is_defeat_State);
        $finish;
    end

endmodule
