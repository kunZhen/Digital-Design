`timescale 1ns / 1ps

module updateIndex_tb;

    // Inputs
    reg [2:0] i_next, j_next;
    reg clk, rst;
    reg colocation_ships_State, player_turn_State;

    // Outputs
    wire [2:0] i_actual, j_actual;

    // Instantiate the Unit Under Test (UUT)
    updateIndex uut (
        .i_next(i_next),
        .j_next(j_next),
        .clk(clk),
        .rst(rst),
        .colocation_ships_State(colocation_ships_State),
        .player_turn_State(player_turn_State),
        .i_actual(i_actual),
        .j_actual(j_actual)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Clock with period of 10 ns
    end

    // Initial setup and test vectors
    initial begin
        // Reset and initialize inputs
        rst = 1;
        i_next = 3'd0;
        j_next = 3'd0;
        colocation_ships_State = 0;
        player_turn_State = 0;

        // Apply a reset
        #10;
        rst = 0; // Assert reset
        #10;
        rst = 1; // Deassert reset

        // Test case 1: Update indices in colocation state
        colocation_ships_State = 1; // Enable colocation state
        i_next = 3'd2; // Set next i index
        j_next = 3'd2; // Set next j index
        #10; // Wait a clock cycle

        // Test case 2: Update indices in player turn state
        colocation_ships_State = 0; // Disable colocation state
        player_turn_State = 1; // Enable player turn state
        i_next = 3'd4; // Change next i index
        j_next = 3'd4; // Change next j index
        #10; // Wait a clock cycle

			// Test case 2: Update indices in player turn state
        colocation_ships_State = 0; // Disable colocation state
        player_turn_State = 0; // Enable player turn state
        i_next = 3'd0; // Change next i index
        j_next = 3'd0; // Change next j index
        #10;

        // Observe the outputs
        $display("Test Case 1 Outputs: i_actual = %d, j_actual = %d", i_actual, j_actual);
        $display("Test Case 2 Outputs: i_actual = %d, j_actual = %d", i_actual, j_actual);
        #10;
        $finish;
    end

endmodule
