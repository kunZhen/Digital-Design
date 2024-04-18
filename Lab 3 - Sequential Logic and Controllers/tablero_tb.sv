`timescale 1ns/1ps

module tablero_tb;
    // Inputs al DUT (Device Under Test)
    logic clk, rst, decision;

    // Outputs del DUT
    logic [1:0] tablero_jugador[5][5];
    logic [1:0] tablero_pc[5][5];

    // Instancia del módulo a testear
    tablero dut(
        .clk(clk),
        .rst(rst),
        .decision(decision),
        .tablero_jugador(tablero_jugador),
        .tablero_pc(tablero_pc)
    );

    // Generación del reloj
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // Reloj con periodo de 10ns
    end

    // Test cases
    initial begin
        // Inicialización
        rst = 1;       // Activamos reset
        decision = 0;  // Sin decisión
        #10;           // Esperamos un tiempo para estabilizar el reset

        rst = 0;       // Desactivamos reset
        #10;           // Esperamos para ver la respuesta de desactivación de reset

        // Prueba llenando tablero con agua
        decision = 1;  // Activamos la decisión para llenar con agua
        #10;           // Observamos la activación de la señal

        decision = 0;  // Desactivamos la decisión
        #10;           // Observamos la respuesta a la desactivación

        $finish;       // Terminamos la simulación
    end

    // Task para imprimir los estados del tablero
    always @(posedge clk) begin
        if (rst || decision) begin
            $display("Time = %t, Reset = %b, Decision = %b", $time, rst, decision);
            print_tablero("Jugador", tablero_jugador);
            print_tablero("PC", tablero_pc);
        end
    end

    // Función para imprimir tablero
    task print_tablero(string name, logic [1:0] tab[5][5]);
        $display("Tablero de %s:", name);
        for (int i = 0; i < 5; i++) begin
            for (int j = 0; j < 5; j++) begin
                $write("%2b ", tab[i][j]);
            end
            $write("\n");
        end
    endtask

endmodule
