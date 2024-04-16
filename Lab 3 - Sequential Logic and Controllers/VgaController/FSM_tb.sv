module FSM_tb();

    // Definir parámetros
    parameter CLK_PERIOD = 10; // Periodo del reloj en unidades de tiempo
    
    // Definir señales de prueba
    reg clk = 0;                // Señal de reloj
    reg rst = 1;                // Señal de reset
    reg start = 0;              // Señal de inicio del juego
    reg player_ships = 3'b010; // Cantidad de barcos del jugador
    reg pc_ships = 3'b010;     // Cantidad de barcos de la computadora
    reg player_move = 0;        // Señal de movimiento del jugador
    reg finished_placing = 0;   // Señal de finalización de colocación de barcos
    
    // Definir señales de salida
    wire placing_ships;         // Indica si el juego está en el estado de colocación de barcos
    wire player_turn;           // Indica si es el turno del jugador
    wire pc_turn;               // Indica si es el turno de la computadora
    wire is_victory;            // Indica si el juego ha terminado con la victoria del jugador
    wire is_defeat;             // Indica si el juego ha terminado con la derrota del jugador
    
    // Instanciar el módulo FSM
    FSM maquina(
        .clk(clk),
        .rst(rst),
        .start(start),
        .player_ships(player_ships),
        .pc_ships(pc_ships),
        .player_move(player_move),
        .finished_placing(finished_placing),
        .placing_ships(placing_ships),
        .player_turn(player_turn),
        .pc_turn(pc_turn),
        .is_victory(is_victory),
        .is_defeat(is_defeat)
    );

    // Generar el reloj
    always #((CLK_PERIOD)/2) clk = ~clk;

    // Iniciar el testbench
    initial begin
        // Esperar un poco antes de iniciar el testbench
        #100;
        
        // Desactivar el reset
        rst = 0;
        #50;
        
        // Iniciar el juego
        start = 1;
        #50;
        
        
        
        // Finalizar el testbench
        $finish;
    end

endmodule
