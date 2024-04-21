module videoGen(
    input logic [9:0] x, y,
    input reg [2:0] i_actual, j_actual,
    input reg [1:0] tablero_jugador[5][5],
    input reg [1:0] tablero_pc[5][5],
    input [2:0] player_ships_input_internal, // Nueva entrada para la longitud del barco durante la colocación
    input logic colocation_ships_State,           // Nueva entrada para confirmar la colocación del barco
    output logic [7:0] r, g, b
);

    reg inrect_main, inrect_secondary, inline;
    reg [9:0] colIndex, rowIndex, col_px, row_px;
    reg [7:0] size, frame;
    reg [9:0] line_position;

    // Constantes del juego para simplificar el código
    localparam AGUA = 2'b00;
    localparam BARCO = 2'b01;
    localparam CASILLA_SELECCION = 2'b10;
    localparam CASILLA_CONFIRMADA = 2'b11;

    parameter VGA_WIDTH = 640;
    parameter VGA_HEIGHT = 480;
    parameter BOARD_SIZE = 5;
    parameter LINE_WIDTH = 2; // Anchura de la línea divisoria

    initial begin
        size = 58; // Tamaño de cada celda
        frame = 4; // Grosor del marco
        line_position = (BOARD_SIZE * (size + frame)); // Posición de inicio de la línea
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
    end
	


    always @* begin
        if (inline) begin
            r = 8'h00; g = 8'h00; b = 8'h00; // Black line
        end else if (inrect_main) begin
            if (colocation_ships_State && rowIndex == i_actual && colIndex >= j_actual && colIndex < j_actual + player_ships_input_internal) begin
                r = 8'hFF; g = 8'h8C; b = 8'h00; 
            end else begin
                case (tablero_jugador[rowIndex][colIndex])
                    AGUA: begin r = 8'h00; g = 8'h00; b = 8'hFF; end // Blue for water
                    BARCO: begin r = 8'h00; g = 8'hFF; b = 8'h00; end // Green for ships
                    CASILLA_SELECCION: begin r = 8'hFF; g = 8'h00; b = 8'h00; end // Red for missed shot
                    CASILLA_CONFIRMADA: begin r = 8'hFF; g = 8'hFF; b = 8'h00; end // Yellow for hit
                    default: begin r = 8'hFF; g = 8'hFF; b = 8'hFF; end // White by default
                endcase
            end
        end else if (inrect_secondary) begin
            case (tablero_pc[rowIndex][colIndex - BOARD_SIZE - (LINE_WIDTH / (size + frame))])
                AGUA: begin r = 8'h20; g = 8'h20; b = 8'h20; end // Grey for water
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
