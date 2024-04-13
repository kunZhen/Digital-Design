module updateIndex (
    input reg [2:0] i_next, j_next, clk, rst,
    output reg [2:0] i_actual, j_actual
);

	logic enable_mov = 1;

	always_ff @(negedge clk) begin
	  if (!rst) begin
			i_actual = 0;
			j_actual = 0;
	  end else if (enable_mov) begin
			i_actual = i_next;
			j_actual = j_next;
			
	  end
	end

endmodule
