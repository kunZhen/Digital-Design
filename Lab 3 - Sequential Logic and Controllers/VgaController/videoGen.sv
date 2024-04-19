module videoGen(
    input logic [9:0] x, y,
    input reg [2:0] i_actual, j_actual,
    input reg [1:0] tablero_jugador[5][5],
    input reg [1:0] tablero_pc[5][5],
    output logic [7:0] r, g, b
);

    reg inrect_main, inrect_secondary, inline;
    reg [9:0] colIndex, rowIndex, col_px, row_px;
    reg [7:0] size, frame;
    reg [9:0] line_position;

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
            r = 8'h00; g = 8'h00; b = 8'h00; // Línea negra divisoria
        end else if (inrect_main) begin
            if (rowIndex == i_actual && colIndex == j_actual) begin
                r = 8'hA5; g = 8'h2A; b = 8'h2A; // Color café para la celda seleccionada
            end else begin
                case (tablero_jugador[rowIndex][colIndex])
                    2'b00: begin r = 8'h00; g = 8'h00; b = 8'h00; end // Agua
                    2'b01: begin r = 8'hFF; g = 8'h00; b = 8'h00; end // Barco
                    2'b10: begin r = 8'h00; g = 8'h00; b = 8'hFF; end // Tiro fallado
                    2'b11: begin r = 8'h00; g = 8'hFF; b = 8'h00; end // Tiro acertado
                    default: begin r = 8'hFF; g = 8'hFF; b = 8'hFF; end // Blanco por defecto
                endcase
            end
        end else if (inrect_secondary) begin
            case (tablero_pc[rowIndex][colIndex - BOARD_SIZE - (LINE_WIDTH / (size + frame))])
                2'b00: begin r = 8'h20; g = 8'h20; b = 8'h20; end // Agua
                2'b01: begin r = 8'h80; g = 8'h00; b = 8'h80; end // Barco
                2'b10: begin r = 8'hFF; g = 8'hFF; b = 8'h00; end // Tiro fallado
                2'b11: begin r = 8'hFF; g = 8'hA5; b = 8'h00; end // Tiro acertado
                default: begin r = 8'hFF; g = 8'hFF; b = 8'hFF; end // Blanco por defecto
            endcase
        end else begin
            r = 8'hFF; g = 8'hFF; b = 8'hFF; // Blanco por defecto fuera de los rectángulos
        end
    end

endmodule
