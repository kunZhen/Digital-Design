module updateIndex (
    input reg [2:0] i_next, j_next, clk, rst,
	 input wire colocation_ships_State, player_turn_State,
	 
    output reg [2:0] i_actual, j_actual
);


	always_ff @(negedge clk) begin
	  if (!rst) begin
			i_actual = 0;
			j_actual = 0;
			
	  end else if (colocation_ships_State || player_turn_State) begin
			i_actual = i_next;
			j_actual = j_next;
			
	  end
	end

endmodule
