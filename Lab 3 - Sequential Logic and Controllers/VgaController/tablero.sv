module tablero(
    input logic clk, rst,
    input logic decision_State,  // Señal de decisión para controlar el llenado del tablero
    output reg [1:0] tablero_jugador[5][5],
    output reg [1:0] tablero_pc[5][5]
);

    // Estados posibles para las celdas del tablero
    localparam AGUA = 2'b00;
    localparam BARCO = 2'b01;
    localparam TIRO_FALLADO = 2'b10;
    localparam TIRO_ACERTADO = 2'b11;

    // Implementación de la lógica para actualizar los tableros
    always_ff @(negedge clk or negedge rst) begin
        if (!rst) begin
            // Resetear tableros a estado inicial
            fill_with_water();  // Llama a una tarea para llenar con agua
        end else if (decision_State) begin
            // Llenar tableros con agua cuando 'decision' es activo
            fill_with_water();  // Llama a una tarea para llenar con agua
        end
    end

    // Tarea para llenar los tableros con agua
    task fill_with_water;
        for (int i = 0; i < 5; i++) begin
            for (int j = 0; j < 5; j++) begin
                tablero_jugador[i][j] <= TIRO_FALLADO;
                tablero_pc[i][j] <= TIRO_FALLADO;
            end
        end
    endtask

endmodule
