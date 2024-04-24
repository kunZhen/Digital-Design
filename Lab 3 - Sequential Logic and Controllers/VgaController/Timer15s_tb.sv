`timescale 1ns / 1ps

module Timer15s_tb;

    // Parámetros
    parameter NBits = 23;
    parameter countMAX = 5000000;

    // Definición de señales
    logic clk, reset, clkOut;

    // Instancia del módulo bajo prueba
    Timer15s #(NBits, countMAX) dut (
        .clk(clk),
        .reset(reset),
        .clkOut(clkOut)
    );

    // Generación de clock
    always #5 clk = ~clk;

    // Generación de reset inicial
    initial begin
        reset = 1;
        #10;
        reset = 0;
    end

    // Monitoreo de las señales
    always @(posedge clk) begin
        $display("Time: %0t, clkOut: %b", $time, clkOut);
        if ($time > 15_000_000) $finish; // Terminar la simulación después de 15 segundos
    end

endmodule
