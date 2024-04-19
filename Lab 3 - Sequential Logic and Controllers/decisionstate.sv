module decisionstate(
    input logic [2:0] player_amount_ships,
    input logic decision,
    input logic clk,
    input logic rst,
    input logic player_confirm_amount,
    output logic ships_decided
	 
);

    
   
    // Proceso para actualizar ships_decided
    always_ff @(negedge clk or negedge rst) begin
        if (!rst) begin
            ships_decided <= 1'b0;
        end else begin
            if (player_amount_ships > 0 && !player_confirm_amount && decision) begin
                ships_decided <= 1'b1;
                
            end else begin
                ships_decided <= 1'b0;
            end
        end
    end

endmodule
