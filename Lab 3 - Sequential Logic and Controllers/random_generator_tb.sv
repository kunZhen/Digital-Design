`timescale 1ns / 1ps

module random_generator_tb();

    // Inputs
    reg clk;
    reg rst;
    reg [2:0] player_ships_input;

    // Output
    wire [2:0] random_number;

    // Instanciando el módulo random_generator
    random_generator uut (
        .clk(clk),
        .rst(rst),
        .player_ships_input(player_ships_input),
        .random_number(random_number)
    );

    // Generador de reloj
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Genera un reloj con período de 10 ns (frecuencia de 100 MHz)
    end

    // Procedimiento inicial
    initial begin
        // Inicialización de entradas
        rst = 0; // Asegura que el sistema esté en reset al inicio
        player_ships_input = 3'b011; // Semilla inicial arbitraria
        #10;

        // Liberar reset
        rst = 1;
        #10;

        // Cambio de semilla para observar comportamiento
        player_ships_input = 3'b101;
        #10;

        // Volver a aplicar reset
        rst = 0;
        #10;
        rst = 1;
        #10;

        // Ejecutar durante un tiempo para ver varios números aleatorios generados
        #100;
        
        // Terminar simulación
        $finish;
    end

    // Monitor de salida
    initial begin
        $monitor("At time %t, random_number = %d", $time, random_number);
    end

endmodule
