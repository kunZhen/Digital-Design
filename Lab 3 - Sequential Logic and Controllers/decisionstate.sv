module decisionstate(
    input logic [2:0] player_amount_ships,  // Número de barcos a colocar
    input logic decision,                   // Señal para indicar que estamos en el estado de decisión
    input logic clk,                        // Reloj del sistema
    input logic rst,                        // Reset
    input logic player_confirm_amount,      // Entrada del switch para confirmar cantidad de barcos

    output logic [2:0] amount_ships_game,  // Número de barcos que quedan después del flanco de bajada
	 output logic ships_located
	 
	 );

    // Estado anterior del switch para detectar flanco de bajada
    logic player_confirm_amount_prev;
    
	 
    // Inicialización de valores de salida y de almacenamiento previo
    initial begin
        amount_ships_game = 3'b000;
        player_confirm_amount_prev = 1'b0;
    end
    
    // Proceso para actualizar el estado anterior del switch y manejar la lógica de colocación
    always_ff @(negedge clk or negedge rst) begin
        if (!rst) begin
            player_confirm_amount_prev <= 1'b0;  // Reset del estado anterior
            amount_ships_game <= 3'b000;         // Reset de la cantidad de barcos
        end else begin
            player_confirm_amount_prev <= player_confirm_amount; // Actualiza el estado anterior

            if (decision && !player_confirm_amount_prev && !player_confirm_amount) begin
                // Detecta un flanco de bajada cuando player_confirm_amount pasa de 1 a 0
                amount_ships_game <= player_amount_ships;  // Captura la cantidad actual de barcos
            end else begin
					player_confirm_amount_prev <= 1'b0;  // Restablece activation_colocation si no se detecta flanco de bajada
            end
        end
    end

endmodule
