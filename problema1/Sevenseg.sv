module Sevenseg(
    input logic [3:0] seg_input, // input de 4 bits
    output logic [6:0] seg_output	// output de 7 bits
    );
     

		// Conversion BCD a 7 segmentos
    always @(seg_input)
    begin
        case (seg_input) 
            4'b0000 : seg_output = 7'b0000001; //0
            4'b0001 : seg_output = 7'b1001111; //1
            4'b0010 : seg_output = 7'b0010010; //2
            4'b0011 : seg_output = 7'b0000110; //3
            4'b0100 : seg_output = 7'b1001100; //4
            4'b0101 : seg_output = 7'b0100100; //5
            4'b0110 : seg_output = 7'b0100000; //6
            4'b0111 : seg_output = 7'b0001111; //7
            4'b1000 : seg_output = 7'b0000000; //8
            4'b1001 : seg_output = 7'b0000100; //9
            default : seg_output = 7'b1111111; 
        endcase
    end
    
endmodule