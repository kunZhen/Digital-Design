module colocationShipsState(
    input logic clk,
    input logic rst,
    input logic colocation_ships_State,
    input [2:0] i_actual,
    input [2:0] j_actual,
    input [2:0] initial_ships_count,
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

    // Tarea para llenar el tablero con agua
    task fill_with_water;
        for (int i = 0; i < 5; i++) begin
            for (int j = 0; j < 5; j++) begin
                tablero_jugador_internal[i][j] <= AGUA;
                tablero_jugador[i][j] <= AGUA;
                tablero_jugador_out[i][j] <= AGUA;  // Reset output board as well
            end
        end
    endtask

    always_ff @(negedge clk or negedge rst) begin
        if (!rst) begin
            fill_with_water();
            confirm_placement <= 0;
            finished_placing <= 0;
            placement_error <= 0;
        end else if (colocation_ships_State) begin
            if (!confirm_colocation_button_prev && !confirm_colocation_button) begin
                if ((j_actual + initial_ships_count <= 5) && (initial_ships_count > 0)) begin
                    for (int k = 0; k < initial_ships_count; k++) begin
                        tablero_jugador_internal[i_actual][j_actual + k] <= BARCO;
                    end
                    confirm_placement <= 1;
                    for (int i = 0; i < 5; i++) begin
                        for (int j = 0; j < 5; j++) begin
                            tablero_jugador[i][j] <= tablero_jugador_internal[i][j];
                            tablero_jugador_out[i][j] <= tablero_jugador_internal[i][j];  // Update the output board
                        end
                    end
                end else begin
                    placement_error <= 1;
                end
            end
            if (confirm_colocation_button_prev && !confirm_colocation_button) begin
                confirm_placement <= 0;
            end
            confirm_colocation_button_prev <= confirm_colocation_button;
        end
    end
endmodule
