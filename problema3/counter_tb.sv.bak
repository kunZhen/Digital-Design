module counter_tb;

	 reg clk;
    reg rst;
    reg [5:0] num;
    wire [5:0] q;
    wire [6:0] seg1;
    wire [6:0] seg2;

    // Instanciar el módulo Contador
    Contador contador_inst (
        .clk(clk),
        .rst(rst),
        .num(num),
        .q(q),
        .seg1(seg1),
        .seg2(seg2)
    );

    // Generar un clock
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 0;
        num = 6'b010011; // Valor inicial (13 en hexadecimal)

        // Reset durante 20 unidades de tiempo
        #20 rst = 1;
        #20 rst = 0;

        // Simular el conteo durante 10 unidades de tiempo
        repeat (10) begin
            #10 num = num - 1;
        end
		  #10 $finish;
    end

endmodule