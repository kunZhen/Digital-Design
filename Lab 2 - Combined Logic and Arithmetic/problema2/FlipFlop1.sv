module FlipFlop1 #(parameter N=4)
    (input logic clk,        // Entrada del reloj
     input logic reset,      // Entrada de reset
     input logic [N-1:0] aff1,      // Entrada de datos
     input logic [N-1:0] bff1,
     input logic [2:0] opff1,
     input logic op_sumff1, op_restff1,
     output logic [N-1:0] Output_aff1,
     output logic [N-1:0] Output_bff1,
     output logic [2:0] Output_opff1,
     output logic Output_op_sumff1, Output_op_restff1
     );
     
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            Output_aff1 <= 1'b0;       // Si hay un reset, establece la salida en 0
            Output_bff1 <= 1'b0;
            Output_opff1 <= 1'b0;
            Output_op_sumff1 <= 1'b0;
            Output_op_restff1 <= 1'b0;
        end else begin
            Output_aff1 <= aff1;  // Copia la entrada de datos en la salida en el flanco de subida del reloj
            Output_bff1 <= bff1;
            Output_opff1 <= opff1;
            Output_op_sumff1 <= op_sumff1;
            Output_op_restff1 <= op_restff1;
        end
    end
endmodule
