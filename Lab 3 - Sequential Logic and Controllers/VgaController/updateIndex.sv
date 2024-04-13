module updateIndex (
    input reg [2:0] i_next, j_next, clk, rst,
	 input wire player_turn,
    output reg [2:0] i_actual, j_actual
);

	logic enable_mov = 1;

	always_ff @(negedge clk) begin
	  if (!rst) begin
			i_actual = 0;
			j_actual = 0;
	  end else if (player_turn) begin
			i_actual = i_next;
			j_actual = j_next;
			
	  end
	end

endmodule
