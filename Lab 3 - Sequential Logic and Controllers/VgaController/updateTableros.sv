module updateTableros(
    input logic clk,
    input logic rst,
    input logic update_enable_player_ship,  // Habilita la actualización de los tableros
    input reg [1:0] tablero_jugador_next[5][5],
    input reg [1:0] tablero_pc_next[5][5],
    output reg [1:0] tablero_jugador[5][5],
    output reg [1:0] tablero_pc[5][5]
);

    // Proceso de actualización en cada ciclo de reloj
    always_ff @(negedge clk or negedge rst) begin
        if (!rst) begin
            // Limpieza de los tableros en caso de reset
            initialize_tableros();
        end else if (update_enable_player_ship) begin
            // Actualizar tableros con los estados futuros
            for (int i = 0; i < 5; i++) begin
					for (int j = 0; j < 5; j++) begin
						 tablero_jugador[i][j] = tablero_jugador_next[i][j];
						 tablero_pc[i][j] = tablero_pc_next[i][j];
					end
			  end
        end
    end

    // Tarea para inicializar los tableros
    task initialize_tableros;
        for (int i = 0; i < 5; i++) begin
            for (int j = 0; j < 5; j++) begin
                tablero_jugador[i][j] = 2'b00;  // AGUA
                tablero_pc[i][j] = 2'b00;
            end
        end
    endtask

    // Tarea para actualizar los tableros
    task update_tableros;
        for (int i = 0; i < 5; i++) begin
            for (int j = 0; j < 5; j++) begin
                tablero_jugador[i][j] = tablero_jugador_next[i][j];
                tablero_pc[i][j] = tablero_pc_next[i][j];
            end
        end
    endtask

endmodule
