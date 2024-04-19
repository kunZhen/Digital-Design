`timescale 1ns / 1ps

module decisionstate_tb;

    // Testbench Signals
    reg [2:0] player_amount_ships;
    reg decision;
    reg clk;
    reg rst;
    reg player_confirm_amount;
    wire ships_decided;

    // Instantiate the Unit Under Test (UUT)
    decisionstate uut (
        .player_amount_ships(player_amount_ships),
        .decision(decision),
        .clk(clk),
        .rst(rst),
        .player_confirm_amount(player_confirm_amount),
        .ships_decided(ships_decided)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // Clock with 10 ns period
    end

    // Test scenarios
    initial begin
        // Initialize Inputs
        rst = 0;  // Assert reset
        player_amount_ships = 0;
        decision = 0;
        player_confirm_amount = 0;

        // Wait for global reset
        #10;
        rst = 1;  // Deassert reset
        #10;

        // Test Case 1: No ships to place
        @(negedge clk);
        player_amount_ships = 3'b000;
        decision = 1;
        player_confirm_amount = 1;
        #10;
        
        // Test Case 2: Valid ship placement
        @(negedge clk);
        player_amount_ships = 3'b011; // 3 ships
        decision = 1;
        player_confirm_amount = 1;
        #10;

        // Test Case 3: Change decision while confirmed
        @(negedge clk);
        decision = 0;
        #10;

        // Test Case 4: Reset ships and decision
        @(posedge clk);
        player_amount_ships = 3'b010; // 2 ships
        decision = 1;
        player_confirm_amount = 0;  // No confirmation
        #10;

        // Test Case 5: Re-confirm with ships
        @(negedge clk);
        player_confirm_amount = 1;
        #10;

        // Test Case 6: Assert reset during operation
        @(negedge clk);
        rst = 0;
        #10;
        rst = 1;
        #20;

        // Finish the simulation
        $finish;
    end

    // Monitor changes
    initial begin
        $monitor("At time %t, ships_decided = %d (amount_ships=%b, decision=%b, confirm=%b)",
                 $time, ships_decided, player_amount_ships, decision, player_confirm_amount);
    end

endmodule
