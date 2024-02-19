`timescale 1ns/1ps

module counter_tb;

  reg clk;
  reg reset;
  wire [5:0] q_6bits;
  wire [3:0] q_4bits;
  wire [1:0] q_2bits;

  // Instanciar el módulo Counter con diferentes anchos
  counter #(6) uut_6bits (
    .clk(clk),
    .reset(reset),
    .q(q_6bits)
  );

  counter #(4) uut_4bits (
    .clk(clk),
    .reset(reset),
    .q(q_4bits)
  );

  counter #(2) uut_2bits (
    .clk(clk),
    .reset(reset),
    .q(q_2bits)
  );

  // Generar un clock
  always #5 clk = ~clk;

  // Inicializar el testbench
  initial begin
    clk = 0;
    reset = 1;

    // Esperar 20 unidades de tiempo y luego desactivar el reset
    #20 reset = 0;

    // Simular durante 50 unidades de tiempo
    #700 $finish; 
  end

  // Mostrar resultados
  always @(posedge clk) begin
    $display("Time=%0t, q_6bits=%b, q_4bits=%b, q_2bits=%b", $time, q_6bits, q_4bits, q_2bits);
  end

endmodule