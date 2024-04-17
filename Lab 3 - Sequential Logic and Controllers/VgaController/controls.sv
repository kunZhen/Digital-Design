module controls(
	
	// Coordenadas actuales del jugador
	/*El rango [2:0] corresponde a que el jugador 
	puede estar en las posiciones 000,001,010,011,100,101, 
	se deben invalida las opciones 110 y 111 debido a que los índices
	de 6 y 7 no existen
	*/
	input reg [2:0]i_actual, j_actual, 
	
	//  Cantidad de barcos ya colocados en el tablero
	ships_placed, 
	
	// Cantidad total de barcos a colocar en el tablero
	amount_of_ships,
	
	// Movimientos 
	input logic move_up, move_down, move_left, move_right, 
	
	// Señal de reloj y reset
	clk, rst,
	
	// Coordenadas a las que el jugador se moverá en el próximo ciclo de reloj
	output reg [2:0]i_next, j_next
);

	// Valor máximo para las coordenadas del tablero. En este caso, se establece en 4, lo que implica un tablero de 5x5.
	parameter MAX_INDEX = 4;
				
	always @(negedge clk or negedge rst) begin
    // Señal reset activa, reestablece las coordenadas
    if (!rst) begin
        i_next <= 0;
        j_next <= 0;
    end else begin
        // Movimientos verticales
        if(!move_up && i_actual > 0) begin
            i_next <= i_actual - 1;
        end
        if(!move_down && i_actual < MAX_INDEX) begin
            i_next <= i_actual + 1;
        end
        // Movimientos horizontales
        if(!move_right && j_actual < MAX_INDEX) begin
            j_next <= j_actual + 1;
        end
        if(!move_left && j_actual > 0) begin
            j_next <= j_actual - 1;
        end
    end
end

	
					 
endmodule