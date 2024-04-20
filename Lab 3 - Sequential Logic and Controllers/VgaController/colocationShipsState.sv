module colocationShipsState(
    input logic clk, rst,
	 output logic update_enable_player_ship,
    input reg [2:0] i_actual, j_actual,
    input logic colocation_ships_State,
    input logic confirm_colocation_button,
    input reg [2:0] player_ships_size_internal, // Tamaño del barco a colocar
    input reg [2:0] player_ships_placed, // Cantidad de barcos ya colocados
    input reg [2:0] player_actual_ship, // Identificador del barco a colocar
	 output reg [2:0] player_ships_placed_next, // Cantidad de barcos ya colocados
    output reg [2:0] player_actual_ship_next, // Identificador del barco a colocar
    input reg [1:0] tablero_jugador[5][5],
    input reg [1:0] tablero_pc[5][5],
    output reg [1:0] tablero_jugador_next[5][5],
    output reg [1:0] tablero_pc_next[5][5]
	 //output reg [1:0] tablero_jugador_copy[5][5],
	 //output reg [1:0] tablero_pc_copy[5][5]
);

    localparam AGUA = 2'b00;
    localparam BARCO = 2'b01;
    localparam CASILLA_SELECCION = 2'b10;
    localparam CASILLA_CONFIRMADA = 2'b11;
	 
	 /*reg [1:0] tablero_jugador_next_upd[5][5];
	 reg [1:0] tablero_pc_next_upd[5][5];
	 
	 reg [1:0] tablero_jugador_upd[5][5];
	 reg [1:0] tablero_pc_upd[5][5];
	 
	 tablero_jugador_upd = tablero_jugador;
	 tablero_pc_upd = tablero_pc;*/
    
    always @(negedge clk or negedge rst) begin
        if (!rst) begin
            fill_with_water(); // Llama a una tarea para llenar con agua
				update_enable_player_ship = 0;
        end else if (colocation_ships_State && !confirm_colocation_button) begin
            // Lógica para manejar la colocación de un barco
            place_ship(); // Llama a una tarea para colocar el barco
				update_enable_player_ship = 1;
				
				//tablero_jugador_copy = tablero_jugador;
				//tablero_pc_copy = tablero_pc;
				
        end
    end
	 
	 /*updateTableros update_tableros(
		.clk(clk),
		.rst(rst),
		.update_enable_player_ship(update_enable_player_ship),
		.tablero_jugador_next(tablero_jugador_next_upd),
		.tablero_pc_next(tablero_pc_next),
		.tablero_jugador(tablero_jugador_upd),
		.tablero_pc(tablero_pc_upd)
	);*/
    
    // Tarea para llenar los tableros con agua
    task fill_with_water;
        for (int i = 0; i < 5; i++) begin
            for (int j = 0; j < 5; j++) begin
                tablero_jugador_next[i][j] = AGUA;
                tablero_pc_next[i][j] = AGUA;
            end
        end
    endtask
    
    // Tarea para colocar el barco
	task place_ship;
		tablero_jugador_next[i_actual][j_actual] <= BARCO;
	endtask



endmodule
