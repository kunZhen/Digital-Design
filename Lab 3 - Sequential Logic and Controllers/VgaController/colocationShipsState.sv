/*module colocationShipsState(
    input logic clk,
    input logic rst,
    input logic colocation_ships_State,
    input reg [2:0] i_actual,
    input reg [2:0] j_actual,
    input reg [2:0] initial_ships_count, // Nuevo puerto de entrada para inicializar el conteo de barcos
    input logic confirm_colocation_button,
    output reg [1:0] tablero_jugador[5][5],
    output reg [1:0] tablero_pc[5][5],
    output reg finished_placing,
    output reg placement_error
);

    reg [2:0] player_ships_input_internal; // Ahora es una señal interna
    reg confirm_colocation_button_prev; // Registro para guardar el estado anterior del botón

    // Estados posibles para las celdas del tablero
    localparam AGUA = 2'b00;
    localparam BARCO = 2'b01;
    localparam TIRO_FALLADO = 2'b10;
    localparam TIRO_ACERTADO = 2'b11;

    always_ff @(posedge clk) begin
        if (rst) begin
            // Inicializar tablero y el contador de barcos
            for (int i = 0; i < 5; i++) begin
                for (int j = 0; j < 5; j++) begin
                    tablero_jugador[i][j] = AGUA;
                end
            end
            player_ships_input_internal <= initial_ships_count; // Inicializar con el valor de entrada
            finished_placing <= 0;
            placement_error <= 0;
            confirm_colocation_button_prev <= 0; // Inicializar el estado anterior del botón
        end else if (colocation_ships_State) begin
            if (confirm_colocation_button && !confirm_colocation_button_prev) begin
                // Flanco ascendente: confirmar la colocación del barco
                if (j_actual + player_ships_input_internal <= 5) begin
                    for (int k = 0; k < player_ships_input_internal; k++) begin
                        tablero_jugador[i_actual][j_actual + k] = BARCO;
                    end
                    placement_error <= 0;
                end else begin
                    placement_error <= 1;
                end
            end
            if (!confirm_colocation_button && confirm_colocation_button_prev) begin
                // Flanco descendente: preparar para el siguiente barco
                player_ships_input_internal <= player_ships_input_internal - 1;
            end

            // Actualizar el estado anterior del botón
            confirm_colocation_button_prev <= confirm_colocation_button;
        end
    end

	always_ff @(posedge clk) begin
		 if (rst) begin
			  finished_placing <= 0;
		 end else if (colocation_ships_State) begin
			  if (player_ships_input_internal == 0) begin
					finished_placing <= 1;
			  end else begin
					finished_placing <= 0;
			  end
		 end
	end

endmodule
*/