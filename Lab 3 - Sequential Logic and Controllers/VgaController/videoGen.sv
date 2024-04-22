module videoGen(
    input logic [9:0] x, y,
    input reg [2:0] i_actual, j_actual,
    input reg [1:0] tablero_jugador[5][5],
    input reg [1:0] tablero_pc[5][5],
    input [2:0] player_ships_input_internal, // Nueva entrada para la longitud del barco durante la colocación
    input logic colocation_ships_State,           // Nueva entrada para confirmar la colocación del barco
	 input logic decision_State,
	 input logic player_turn_State,
    output logic [7:0] r, g, b
);

    reg inrect_main, inrect_secondary, inline;
	 reg char_idx, bit_idx, row_char; // Declarar fuera de las condiciones
	
    reg [9:0] colIndex, rowIndex, col_px, row_px;
    reg [7:0] size, frame;
    reg [9:0] line_position;
	 
	 reg[1:0] tablero_jugador_videoGen[5][5];
	 reg[1:0] tablero_pc_videoGen[5][5];
	 
	 reg[7:0] r_agua_tablero_pc, g_agua_tablero_pc, b_agua_tablero_pc;
	 reg[7:0] r_agua_tablero_jugador, g_agua_tablero_jugador, b_agua_tablero_jugador;
	 
	 // Definición de la ROM de caracteres (128 caracteres con 8 filas de 8 bits cada una)
    reg [7:0] character_rom[128][8];

    // Buffer de texto (suficiente para una línea de texto)
    reg [7:0] text_buffer[40];

    // Constantes del juego para simplificar el código
    localparam AGUA = 2'b00;
    localparam BARCO = 2'b01;
    localparam CASILLA_SELECCION = 2'b10;
    localparam CASILLA_CONFIRMADA = 2'b11;

    parameter VGA_WIDTH = 640;
    parameter VGA_HEIGHT = 480;
    parameter BOARD_SIZE = 5;
    parameter LINE_WIDTH = 2; // Anchura de la línea divisoria
	 
	 parameter CHAR_WIDTH = 8;
    parameter CHAR_HEIGHT = 8;
	 parameter TEXT_AREA_START = VGA_HEIGHT - CHAR_HEIGHT;  // Inicio del área de texto

    initial begin
        size = 58; // Tamaño de cada celda
        frame = 4; // Grosor del marco
        line_position = (BOARD_SIZE * (size + frame)); // Posición de inicio de la línea
		  
		  // Espacio en blanco
        begin
            character_rom[32][0] = 8'b00000000;
            character_rom[32][1] = 8'b00000000;
            character_rom[32][2] = 8'b00000000;
            character_rom[32][3] = 8'b00000000;
            character_rom[32][4] = 8'b00000000;
            character_rom[32][5] = 8'b00000000;
            character_rom[32][6] = 8'b00000000;
            character_rom[32][7] = 8'b00000000;
        end
		  
		  // Carácter 'E'
        begin
            character_rom[69][0] = 8'b11111111;
            character_rom[69][1] = 8'b10000000;
            character_rom[69][2] = 8'b10000000;
            character_rom[69][3] = 8'b11110000;
            character_rom[69][4] = 8'b10000000;
            character_rom[69][5] = 8'b10000000;
            character_rom[69][6] = 8'b10000000;
            character_rom[69][7] = 8'b11111111;
        end
		  
		  // Asigna cada carácter individualmente
		  begin
			 text_buffer[0] = "E";
			 text_buffer[1] = "s";
			 text_buffer[2] = "t";
			 text_buffer[3] = "a";
			 text_buffer[4] = "d";
			 text_buffer[5] = "o";
			 text_buffer[6] = ":";
			 text_buffer[7] = " ";
			 text_buffer[8] = "I";
			 text_buffer[9] = "n";
			 text_buffer[10] = "i";
			 text_buffer[11] = "c";
			 text_buffer[12] = "i";
			 text_buffer[13] = "a";
			 text_buffer[14] = "l";
			 text_buffer[15] = "i";
			 text_buffer[16] = "z";
			 text_buffer[17] = "a";
			 text_buffer[18] = "n";
			 text_buffer[19] = "d";
			 text_buffer[20] = "o";
			 text_buffer[21] = ".";
			 text_buffer[22] = ".";
			 text_buffer[23] = ".";
			 // Continúa para los demás caracteres o completa hasta 40 con espacios si es necesario
			 for (int i = 24; i < 40; i = i + 1) begin
				  text_buffer[i] = " ";  // Llena el resto con espacios
			 end
			end 
    end

    always @* begin
        colIndex = x / (size + frame);
        rowIndex = y / (size + frame);
        inline = (x >= line_position) && (x < line_position + LINE_WIDTH);
    end

    always @* begin
        col_px = colIndex * (size + frame);
        row_px = rowIndex * (size + frame);
    end

    always @* begin
        inrect_main = (colIndex < BOARD_SIZE && rowIndex < BOARD_SIZE) &&
                      (x >= col_px + frame && x < col_px + size &&
                       y >= row_px + frame && y < row_px + size);

        inrect_secondary = ((colIndex >= BOARD_SIZE + (LINE_WIDTH / (size + frame))) &&
                            (colIndex < 2 * BOARD_SIZE + (LINE_WIDTH / (size + frame))) &&
                            (rowIndex < BOARD_SIZE)) &&
                           (x >= col_px + frame && x < col_px + size &&
                            y >= row_px + frame && y < row_px + size);
									 
			char_idx = (x / CHAR_WIDTH) % 40; // Asegúrate de no salir del buffer
			bit_idx = x % CHAR_WIDTH;
			row_char = y % CHAR_HEIGHT;
    end
	
	// Lógica para actualizar el texto basado en el estado
	always @* begin
		 if (colocation_ships_State) begin
			  text_buffer[0] = "E"; text_buffer[1] = "s"; text_buffer[2] = "t";
			  text_buffer[3] = "a"; text_buffer[4] = "d"; text_buffer[5] = "o";
			  text_buffer[6] = ":"; text_buffer[7] = " ";
			  text_buffer[8] = "C"; text_buffer[9] = "o"; text_buffer[10] = "l";
			  text_buffer[11] = "o"; text_buffer[12] = "c"; text_buffer[13] = "a";
			  text_buffer[14] = "c"; text_buffer[15] = "i"; text_buffer[16] = "o";
			  text_buffer[17] = "n"; text_buffer[18] = " ";
			  for (int i = 19; i < 40; i++) begin
					text_buffer[i] = " ";
			  end
		 end else if (decision_State) begin
			  text_buffer[0] = "E"; text_buffer[1] = "s"; text_buffer[2] = "t";
			  text_buffer[3] = "a"; text_buffer[4] = "d"; text_buffer[5] = "o";
			  text_buffer[6] = ":"; text_buffer[7] = " ";
			  text_buffer[8] = "D"; text_buffer[9] = "e"; text_buffer[10] = "c";
			  text_buffer[11] = "i"; text_buffer[12] = "s"; text_buffer[13] = "i";
			  text_buffer[14] = "o"; text_buffer[15] = "n"; text_buffer[16] = " ";
			  for (int i = 17; i < 40; i++) begin
					text_buffer[i] = " ";
			  end
		 end
	end
	
	always @* begin
		 if (colocation_ships_State | decision_State) begin
			  tablero_jugador_videoGen = tablero_jugador;
			  tablero_pc_videoGen = tablero_pc;
			  r_agua_tablero_pc = 8'h66; g_agua_tablero_pc = 8'hCC; b_agua_tablero_pc = 8'hFF;
			  r_agua_tablero_jugador = 8'h00; g_agua_tablero_jugador = 8'h00; b_agua_tablero_jugador = 8'hFF;
		 end else if (player_turn_State) begin
			  tablero_jugador_videoGen = tablero_pc;
			  tablero_pc_videoGen = tablero_jugador;
			  r_agua_tablero_pc = 8'h00; g_agua_tablero_pc = 8'h00; b_agua_tablero_pc = 8'hFF;
			  r_agua_tablero_jugador = 8'h66; g_agua_tablero_jugador = 8'hCC; b_agua_tablero_jugador = 8'hFF;
		 end
	end

    always @* begin
        if (inline) begin
            r = 8'h00; g = 8'h00; b = 8'h00; // Black line
        end else if (inrect_main) begin
            if (colocation_ships_State && rowIndex == i_actual && colIndex >= j_actual && colIndex < j_actual + player_ships_input_internal) begin
						r = 8'hFF; g = 8'h8C; b = 8'h00; 
            end else if (player_turn_State && (colIndex == j_actual && rowIndex == i_actual) )  begin
						r = 8'hFF; g = 8'h8C; b = 8'h00; 
				end else begin
                case (tablero_jugador_videoGen[rowIndex][colIndex])
                    AGUA: begin r = r_agua_tablero_jugador; g = g_agua_tablero_jugador; b = b_agua_tablero_jugador; end // Blue for water
                    BARCO: begin r = 8'h00; g = 8'hFF; b = 8'h00; end // Green for ships
                    CASILLA_SELECCION: begin r = 8'hFF; g = 8'h00; b = 8'h00; end // Red for missed shot
                    CASILLA_CONFIRMADA: begin r = 8'hFF; g = 8'hFF; b = 8'h00; end // Yellow for hit
                    default: begin r = 8'hFF; g = 8'hFF; b = 8'hFF; end // White by default
                endcase
            end
        end else if (inrect_secondary) begin
            case (tablero_pc_videoGen[rowIndex][colIndex - BOARD_SIZE - (LINE_WIDTH / (size + frame))])
                AGUA: begin r = r_agua_tablero_pc; g = g_agua_tablero_pc; b = b_agua_tablero_pc; end 
                BARCO: begin r = 8'h00; g = 8'hFF; b = 8'h00; end // Green for ships
                CASILLA_SELECCION: begin r = 8'hFF; g = 8'h00; b = 8'h00; end // Red for missed shott
                CASILLA_CONFIRMADA: begin r = 8'hFF; g = 8'hFF; b = 8'h00; end // Yellow for hit
                default: begin r = 8'hFF; g = 8'hFF; b = 8'hFF; end // White by default
            endcase
        end else begin
            r = 8'hFF; g = 8'hFF; b = 8'hFF; // Default white outside rectangles
        end
    end


	 
	 
endmodule
