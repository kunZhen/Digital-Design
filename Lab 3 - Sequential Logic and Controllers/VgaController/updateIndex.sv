module updateIndex (
    input reg [2:0] i_next, j_next, clk, rst,
	 
	 // Turno del jugador o si se encuentra colocando barcos en el tablero
	 input wire player_turn, placing_ships,
	 
    output reg [2:0] i_actual, j_actual
);


	always_ff @(negedge clk) begin
	  // Si la señal de reset (rst) está activa, se restablecen las coordenadas i_actual y j_actual a cero
	  if (!rst) begin
			i_actual = 0;
			j_actual = 0;
		
	  // El jugador está colocando barcos o es su turno, las coordenadas i_actual y j_actual se actualizan con los valores de i_next y j_next
	  end else if (placing_ships || player_turn) begin
			i_actual = i_next;
			j_actual = j_next;
			
	  end
	end

endmodule
