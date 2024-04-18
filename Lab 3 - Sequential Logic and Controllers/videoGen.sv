module videoGen(
    // Coordenadas de píxeles en la pantalla VGA
    input logic [9:0] x, y,

    // Posición actual del jugador en el juego
    input reg [2:0] i_actual, j_actual,

    // Estado actual de los tableros como entradas
    input reg [1:0] tablero_jugador[5][5],
    input reg [1:0] tablero_pc[5][5],

    // Componentes de color para cada píxel en la pantalla VGA
    output logic [7:0] r, g, b
);

    // Variables para indicar si el píxel está dentro de un rectángulo
    reg inrect_main, inrect_secondary;
    reg [9:0] colIndex, rowIndex, col_px, row_px;
    reg [7:0] size, frame;

    // Constantes
    parameter VGA_WIDTH = 640;
    parameter VGA_HEIGHT = 480;
    parameter BOARD_SIZE = 5;

    // Inicialización de parámetros
    initial begin
        size = 58;
        frame = 2;
    end

    // Cálculo de índices de columna y fila
    always @* begin
        colIndex = x / (size + frame);
        rowIndex = y / (size + frame);
    end

    // Cálculo de píxeles de columna y fila
    always @* begin
        col_px = colIndex * (size + frame);
        row_px = rowIndex * (size + frame);
    end

    // Verificar si el píxel está dentro de un rectángulo
    always @* begin
        inrect_main = (colIndex < BOARD_SIZE && rowIndex < BOARD_SIZE) &&
                      (x >= col_px + frame && x < col_px + size &&
                       y >= row_px + frame && y < row_px + size);
        inrect_secondary = ((colIndex >= BOARD_SIZE) && (colIndex < (2 * BOARD_SIZE)) &&
                            (rowIndex >= 0) && (rowIndex < BOARD_SIZE)) &&
                           (x >= col_px + frame && x < col_px + size &&
                            y >= row_px + frame && y < row_px + size);
    end

    // Establecer color basado en los rectángulos
    always @* begin
        {r, g, b} = inrect_main ? (colIndex == j_actual && rowIndex == i_actual) ? {8'hFF, 8'hFF, 8'hFF} : {8'hFF, 8'h00, 8'h00} :
                                  inrect_secondary ? {8'h00, 8'h00, 8'hFF} :
                                  {8'h00, 8'h00, 8'h00};
    end

endmodule
