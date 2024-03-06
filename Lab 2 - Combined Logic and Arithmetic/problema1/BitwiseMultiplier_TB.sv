module BitwiseMultiplier_TB;

  // Parámetros del testbench
  parameter N = 4;
  
  // Señales de entrada
  logic [N-1:0] a, b;
  
  // Señal de salida
  logic [2*N-1:0] m;
  
  // Instancia del módulo BitwiseMultiplier
  BitwiseMultiplier #(4) dut (
    .A(a),
    .B(b),
    .M(m)
  );
  
  // Inicialización
  initial begin
    // Asigna valores de prueba a y b
    a = 4'b1010;
    b = 4'b1100;
    #10;
    a = 4'b1111;
    b = 4'b0000;
    #10;
	 a = 4'b1011;
    b = 4'b1111;
    #10;
    // Imprime los resultados
    $display("Resultado: %b * %b = %b", a, b, m);
    
   
  end

endmodule