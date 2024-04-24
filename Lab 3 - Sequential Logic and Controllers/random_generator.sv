module random_generator(
    input clk,
    input rst,
	 input reg [2:0] player_ships_input,
    output reg [2:0] random_number  // Salida de 3 bits, pero solo usamos valores de 0 a 4
);

	// LFSR de 3 bits con una semilla inicial arbitraria
	reg [2:0] lfsr = player_ships_input;  // Semilla inicial

	// Actualización del LFSR en cada ciclo de reloj
	always @(negedge clk or negedge rst) begin
		 if (!rst) begin
			  lfsr <= player_ships_input;  // Restablece a la semilla inicial
		 end else begin
			  // Polinomio de retroalimentación: x^3 + x^2 + 1
			  // Desplazamiento del registro y realimentación del bit de salida
			  lfsr <= {lfsr[1], lfsr[0], lfsr[2] ^ lfsr[1]};
		 end
	end

	// Mapeo del valor del LFSR a un número de 0 a 4
	always @(lfsr) begin
		 if (lfsr > 4) begin
			  // Si el número es mayor que 4, lo reducimos
			  random_number <= lfsr - 3;
		 end else begin
			  random_number <= lfsr;
		 end
	end

endmodule
