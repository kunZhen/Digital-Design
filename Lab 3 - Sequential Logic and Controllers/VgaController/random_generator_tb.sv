`timescale 1ns / 1ps

module random_generator_tb;

    // Entradas del módulo
    reg clk;
    reg rst;
    reg [2:0] player_ships_input_internal;

    // Salidas del módulo
    wire [2:0] i_random;
    wire [2:0] j_random;

    // Instancia del módulo a probar
    random_generator uut (
        .clk(clk),
        .rst(rst),
        .player_ships_input_internal(player_ships_input_internal),
        .i_random(i_random),
        .j_random(j_random)
    );

    // Generador de reloj
    initial begin
        clk = 0;
        forever #10 clk = ~clk;  // Periodo del reloj de 20 ns
    end

    // Procedimiento de prueba
    initial begin
        // Inicializar entradas
        rst = 1;
        player_ships_input_internal = 3'b101;

        // Resetear el sistema
        #5;
        rst = 0;
        #20;
        rst = 1;
        #30;

        // Cambiar entrada para ver efectos en la generación de números aleatorios
        player_ships_input_internal = 3'b011;
        #100;

        // Otra prueba con diferente entrada
        player_ships_input_internal = 3'b110;
        #100;

        // Finaliza la simulación
        $finish;
    end

    // Monitorear cambios en las salidas
    initial begin
        $monitor("At time %t, i_random = %d, j_random = %d", $time, i_random, j_random);
    end

endmodule
