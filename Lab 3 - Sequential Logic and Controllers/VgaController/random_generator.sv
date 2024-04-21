module random_generator(
    input clk,
    input rst,
    input [2:0] player_ships_input_internal,
    output reg [2:0] i_random,
    output reg [2:0] j_random
);

    reg [4:0] lfsr;

    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            lfsr <= {2'b01, player_ships_input_internal};  // Asegurar 5 bits con una semilla inicial
        end else begin
            lfsr <= {lfsr[3:0], lfsr[4] ^ lfsr[1]};  // Polinomio correcto para un LFSR de 5 bits
        end
    end

    function [2:0] random_index;
        input [4:0] lfsr_value;
        begin
            random_index = lfsr_value[2:0] % 5;  // Reducir a un rango de 0 a 4
        end
    endfunction

    always @(posedge clk) begin
        i_random = random_index(lfsr);
        j_random = random_index({lfsr[1:0], lfsr[4:3]});  // Alterar bits para diferente valor
    end

endmodule
