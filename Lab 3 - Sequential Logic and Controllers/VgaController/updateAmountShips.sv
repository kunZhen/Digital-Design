module updateAmountShips(
    input logic clk,
    input logic rst,
    input logic colocation_ships_State,  // Señal para habilitar la actualización de los registros
    input reg [2:0] player_ships_placed_next,  // Valor futuro de barcos colocados
    input reg [2:0] player_actual_ship_next,  // Valor futuro del barco actualmente seleccionado
    output reg [2:0] player_ships_placed,  // Registro actual de barcos colocados
    output reg [2:0] player_actual_ship  // Registro actual del barco seleccionado
);

    // Proceso de actualización en cada ciclo de reloj
    always @(negedge clk or negedge rst) begin
        if (!rst) begin
            // Inicializar registros a un estado conocido en reset
            player_ships_placed <= 3'b000;
            player_actual_ship <= 3'b000;
        end else if (colocation_ships_State) begin
            // Actualizar registros con los valores futuros
            player_ships_placed <= player_ships_placed_next;
            player_actual_ship <= player_actual_ship_next;
        end
    end

endmodule
