module tablero(
    input logic clk, rst,
    input logic decision,  // Señal de decisión para controlar el llenado del tablero
    output logic [1:0] tablero_jugador[5][5],
    output logic [1:0] tablero_pc[5][5]
);

    // Estados posibles para las celdas del tablero
    localparam AGUA = 2'b00;
    localparam BARCO = 2'b01;
    localparam TIRO_FALLADO = 2'b10;
    localparam TIRO_ACERTADO = 2'b11;

    // Implementación de la lógica para actualizar los tableros
    always_ff @(posedge clk or negedge rst) begin
        if (!rst) begin
            // Resetear tableros a estado inicial
            fill_with_water();  // Llama a una tarea para llenar con agua
        end else if (decision) begin
            // Llenar tableros con agua cuando 'decision' es activo
            fill_with_water();  // Llama a una tarea para llenar con agua
        end
    end

    // Tarea para llenar los tableros con agua
    task fill_with_water;
        for (int i = 0; i < 5; i++) begin
            for (int j = 0; j < 5; j++) begin
                tablero_jugador[i][j] <= AGUA;
                tablero_pc[i][j] <= BARCO;
            end
        end
    endtask

endmodule
