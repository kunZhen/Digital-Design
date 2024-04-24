`timescale 1ns / 1ps

module battleship_testbench;

    // Inputs
    reg move_up, move_down, move_left, move_right, clk, rst;
    reg player_move;
    reg [2:0] player_ships_input;
    reg confirm_amount_button;
    reg confirm_colocation_button;

    // Outputs
    wire placement_error;
    wire vgaclk;
    wire hsync, vsync;
    wire sync_b, blank_b;
    wire [7:0] r, g, b;
    wire [6:0] ships_placed_seg;

    // Instantiate the Unit Under Test (UUT)
    Battleship uut (
        .move_up(move_up),
        .move_down(move_down),
        .move_left(move_left),
        .move_right(move_right),
        .clk(clk),
        .rst(rst),
        .player_move(player_move),
        .player_ships_input(player_ships_input),
        .confirm_amount_button(confirm_amount_button),
        .confirm_colocation_button(confirm_colocation_button),
        .placement_error(placement_error),
        .vgaclk(vgaclk),
        .hsync(hsync),
        .vsync(vsync),
        .sync_b(sync_b),
        .blank_b(blank_b),
        .r(r),
        .g(g),
        .b(b),
        .ships_placed_seg(ships_placed_seg)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // Clock period of 10ns
    end

    // Initialize Inputs and apply test cases
    initial begin
        // Initialize Inputs
        move_up = 0;
        move_down = 0;
        move_left = 0;
        move_right = 0;
        rst = 1;
        player_move = 0;
        player_ships_input = 0;
        confirm_amount_button = 0;
        confirm_colocation_button = 0;

        // Wait for global reset
        #100;
        rst = 0;  // Release reset

        // Setup test scenario
        #10;
        player_ships_input = 3'b011;  // Set number of player ships
        confirm_amount_button = 1;    // Confirm ship amount
        #10;
        confirm_amount_button = 0;    

        // Start ship placement
        move_right = 1;
        #10;
        move_right = 0;
        move_down = 1;
        #10;
        move_down = 0;
        confirm_colocation_button = 1;  // Confirm ship placement
        #10;
        confirm_colocation_button = 0;

        // Wait and check output
        #50;

        // Print out the player's board
			$display("Player Board:");
			for (int i = 0; i < 5; i++) begin
				 for (int j = 0; j < 5; j++) begin
					  $write("%b ", uut.tablero_jugador[i][j]);
				 end
				 $write("\n");
			end

			$display("Player Out Board:");
			for (int i = 0; i < 5; i++) begin
				 for (int j = 0; j < 5; j++) begin
					  $write("%b ", uut.tablero_jugador_out[i][j]);
				 end
				 $write("\n");
			end
end

endmodule
