module colocationShipsState(
    input logic clk,
    input logic rst,
    input logic colocation_ships_State,
    input [2:0] i_actual,
    input [2:0] j_actual,
    input [2:0] initial_ships_count,
    input [2:0] player_ships_input_internal, // Added this missing input that specifies total number of ships
    input logic confirm_colocation_button,
    output reg [1:0] tablero_jugador[5][5],
    output reg [1:0] tablero_jugador_out[5][5],  // Reintroduced output
    output reg confirm_placement,
    output reg finished_placing,
    output reg placement_error
);

    localparam AGUA = 2'b00;
    localparam BARCO = 2'b01;

    reg [1:0] tablero_jugador_internal[5][5];
    reg confirm_colocation_button_prev;
    reg [2:0] current_ships_count; // To keep track of the ships currently placed

    // Task to fill the board with water
    task fill_with_water;
        integer i, j;  // Use integer for loop counters
        begin
            for (i = 0; i < 5; i = i + 1) begin
                for (j = 0; j < 5; j = j + 1) begin
                    tablero_jugador_internal[i][j] = AGUA;
                    tablero_jugador[i][j] = AGUA;
                    tablero_jugador_out[i][j] = AGUA;  // Reset output board as well
                end
            end
        end
    endtask

    integer i, j, k;  // Declare loop variables at the beginning of the block

    always_ff @(negedge clk or negedge rst) begin
        if (!rst) begin
            fill_with_water();
            confirm_placement = 0;
            finished_placing = 0;
            placement_error = 0;
            current_ships_count = 0;
        end else if (colocation_ships_State) begin
            if (confirm_colocation_button_prev && !confirm_colocation_button) begin
                if (current_ships_count < player_ships_input_internal) begin
                    if ((j_actual + initial_ships_count <= 5) && (initial_ships_count > 0)) begin
                        for (k = 0; k < initial_ships_count; k = k + 1) begin
                            tablero_jugador_internal[i_actual][j_actual + k] = BARCO;
                        end
                        confirm_placement = 1;
                        finished_placing = 1; // Assume last ship placement finishes the process
                        current_ships_count = current_ships_count + 1;
                    end else begin
                        placement_error = 1; // Indicate a placement error
                    end
                end else begin
                    placement_error = 1; // Too many ships placed
                end
            end
            for (i = 0; i < 5; i = i + 1) begin
                for (j = 0; j < 5; j = j + 1) begin
                    tablero_jugador[i][j] = tablero_jugador_internal[i][j];
                    tablero_jugador_out[i][j] = tablero_jugador_internal[i][j];  // Update the output board
                end
            end
            confirm_placement = 0; // Reset after processing to await new command
        end
        confirm_colocation_button_prev = confirm_colocation_button; // Update the state of the confirmation button
    end
endmodule
