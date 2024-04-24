`timescale 1ns / 1ps

module colocationShipsState_TB;

    // Inputs
    reg clk;
    reg rst;
    reg colocation_ships_State;
    reg [2:0] i_actual;
    reg [2:0] j_actual;
    reg [2:0] initial_ships_count;
    reg confirm_colocation_button;
    reg [1:0] tablero_jugador[5][5];

    // Outputs
    wire [1:0] tablero_jugador_out[5][5];
    wire confirm_placement;
    wire finished_placing;
    wire placement_error;

    // Instantiate the Unit Under Test (UUT)
    colocationShipsState uut (
        .clk(clk),
        .rst(rst),
        .colocation_ships_State(colocation_ships_State),
        .i_actual(i_actual),
        .j_actual(j_actual),
        .initial_ships_count(initial_ships_count),
        .confirm_colocation_button(confirm_colocation_button),
        .tablero_jugador(tablero_jugador),
        .tablero_jugador_out(tablero_jugador_out),
        .confirm_placement(confirm_placement),
        .finished_placing(finished_placing),
        .placement_error(placement_error)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // Clock with a period of 10ns
    end

    // Initialize Inputs and apply test cases
    initial begin
	 
		  integer i, j;
		  for (i = 0; i < 5; i = i + 1) begin
            for (j = 0; j < 5; j = j + 1) begin
                tablero_jugador[i][j] = 2'b00;  // Initializing with AGUA
            end
        end
        // Initialize all the inputs
        rst = 1;
        colocation_ships_State = 0;
        i_actual = 0;
        j_actual = 0;
        initial_ships_count = 0;
        confirm_colocation_button = 0;

        // Initialize tablero_jugador to AGUA (2'b00)
        
        

        // Apply Reset
        #10 rst = 0;
        #10 rst = 1;
        #10 colocation_ships_State = 1;  // Enable the state for colocation

        // Set parameters to place ships
        i_actual = 2;
        j_actual = 1;
        initial_ships_count = 3;
        confirm_colocation_button = 1;

        #10 confirm_colocation_button = 0;  // Simulate button press
        #20;

        $finish;  // End of simulation
    end

    // Task to print the board states
    always @(posedge clk) begin
        if (rst || colocation_ships_State) begin
            $display("Time = %t, Reset = %b, colocate = %b", $time, rst, colocation_ships_State);
            print_tablero("Jugador", tablero_jugador);
            print_tablero("Jugador out", tablero_jugador_out);
        end
    end
	 
	 task print_tablero(string name, logic [1:0] tab[5][5]);
        $display("Tablero de %s:", name);
        for (int i = 0; i < 5; i++) begin
            for (int j = 0; j < 5; j++) begin
                $write("%2b ", tab[i][j]);
            end
            $write("\n");
        end
    endtask
	 
endmodule