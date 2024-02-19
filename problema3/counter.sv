module counter #(parameter N=6)(
    input clk, 
    input rst, 
    input [N-1:0] num, 
    output reg [N-1:0] q,
    output reg [6:0] seg1,
    output reg [6:0] seg2
);
    initial begin
        q = num;
    end

    always @(posedge clk, posedge rst) begin
        if (rst)
            q <= num;
        else
            q <= q - 6'b000001;
    end

    always @(q) begin
        case (q[3:0])
            4'h0: seg1 = 7'b1000000; // 0
            4'h1: seg1 = 7'b1111001; // 1
            4'h2: seg1 = 7'b0100100; // 2
            4'h3: seg1 = 7'b0110000; // 3
            4'h4: seg1 = 7'b0011001; // 4
            4'h5: seg1 = 7'b0010010; // 5
            4'h6: seg1 = 7'b0000010; // 6
            4'h7: seg1 = 7'b1111000; // 7
            4'h8: seg1 = 7'b0000000; // 8
            4'h9: seg1 = 7'b0011000; // 9
            4'ha: seg1 = 7'b0001000; // A
            4'hb: seg1 = 7'b0000011; // B
            4'hc: seg1 = 7'b1000110; // C
            4'hd: seg1 = 7'b0100001; // D
            4'he: seg1 = 7'b0000110; // E
            4'hf: seg1 = 7'b0001110; // F
        endcase
    end

    always @(q) begin
        case (q[5:4]) // Obtener los dígitos inferiores en hexadecimal
            2'b00: seg2 = 7'b1000000; // 0
            2'b01: seg2 = 7'b1111001; // 1
            2'b10: seg2 = 7'b0100100; // 2
            2'b11: seg2 = 7'b0110000; // 3
        endcase
    end
endmodule