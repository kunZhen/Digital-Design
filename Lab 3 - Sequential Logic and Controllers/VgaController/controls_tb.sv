`timescale 1ns / 1ps

module controls_tb;

    // Inputs
    reg [2:0] i_actual, j_actual;
    reg colocation_ships_State, player_turn_State;
    reg [2:0] player_ships_input_internal;
    reg move_up, move_down, move_left, move_right;
    reg clk, rst;

    // Outputs
    wire [2:0] i_next, j_next;

    // Instantiate the Unit Under Test (UUT)
    controls uut (
        .i_actual(i_actual),
        .j_actual(j_actual),
        .colocation_ships_State(colocation_ships_State),
        .player_turn_State(player_turn_State),
        .player_ships_input_internal(player_ships_input_internal),
        .move_up(move_up),
        .move_down(move_down),
        .move_left(move_left),
        .move_right(move_right),
        .clk(clk),
        .rst(rst),
        .i_next(i_next),
        .j_next(j_next)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Clock with period of 10 ns
    end

    // Initial setup and test vectors
    initial begin
        rst = 1;
        i_actual = 2; j_actual = 2;
        colocation_ships_State = 0;
        player_turn_State = 0;
        player_ships_input_internal = 1;
        move_up = 1; move_down = 1; move_left = 1; move_right = 1;

        // Reset the system
        #10;
        rst = 0;
        #10;
        rst = 1;

        // Test case 1: Move up in player turn state
        player_turn_State = 1;
        move_up = 0; // Should decrease i_actual by 1
        #10; // Wait a clock cycle

        // Reset moves
        move_up = 1;

        // Test case 2: Move right in colocation state with ship size consideration
        colocation_ships_State = 1;
        move_right = 0; // Should increase j_actual by 1 considering ship size
        #10;

        // Reset test environment
        move_right = 1;
        #10;
		  
		  // Reset test environment
        move_down = 0;
        #10;
		  
		  // Reset test environment
        move_down = 1;
        #10;
		  
		  // Reset test environment
        move_left = 0;
        #10;
		  
		  move_left = 1;
        #10;
		  
		  
        // Final state check
        $display("Final state i_next = %d, j_next = %d", i_next, j_next);
        #10;
        $finish;
    end

endmodule
