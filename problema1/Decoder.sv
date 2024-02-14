// Decodificador BCD de 4 bits
module Decoder (
    input logic [3:0] binary_input, // input de 4 bits
    output logic [4:0] bcd_output	// output de 5 bits
);

    always_comb begin // Se ejecuta cuando hay un cambio en los inputs
        case (binary_input)
            4'b0000: bcd_output = 5'b00000; // 0
            4'b0001: bcd_output = 5'b00001; // 1
            4'b0010: bcd_output = 5'b00010; // 2
            4'b0011: bcd_output = 5'b00011; // 3
            4'b0100: bcd_output = 5'b00100; // 4
            4'b0101: bcd_output = 5'b00101; // 5
            4'b0110: bcd_output = 5'b00110; // 6
            4'b0111: bcd_output = 5'b00111; // 7
            4'b1000: bcd_output = 5'b01000; // 8
            4'b1001: bcd_output = 5'b01001; // 9
            4'b1010: bcd_output = 5'b10000; // 10
            4'b1011: bcd_output = 5'b10001; // 11
            4'b1100: bcd_output = 5'b10010; // 12
            4'b1101: bcd_output = 5'b10011; // 13
            4'b1110: bcd_output = 5'b10100; // 14
            4'b1111: bcd_output = 5'b10101; // 15
            // Otros casos no contemplados, se pueden manejar según las necesidades
            default: bcd_output = 5'b00000; // Por ejemplo, establecer a 0 en caso de entrada no válida
        endcase
    end

endmodule