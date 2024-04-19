module controls(
	input reg [2:0] i_actual, j_actual,
	input logic colocation_ships_State,
	input logic move_up, move_down, move_left, move_right, clk, rst,
	output reg [2:0] i_next, j_next
);


				
	parameter MAX_INDEX = 4;
				
	always @(negedge clk or negedge rst) begin
	
		if (!rst) begin
			i_next = 0;
			j_next = 0;
			
		end else begin
		
			if (colocation_ships_State) begin 
				// If the position is not allowed
				if(i_actual == MAX_INDEX && move_down == 0) i_next = i_actual;
				else if(i_actual == 3'b000 && move_up == 0) i_next = i_actual;
				else if(j_actual == MAX_INDEX && move_right == 0) j_next = j_actual;
				else if(j_actual == 3'b000 && move_left == 0) j_next = j_actual;
				else begin
				
					if(!move_up) i_next = i_actual - 1;
					if(!move_down) i_next = i_actual + 1;
					if(!move_right) j_next = j_actual + 1;
					if(!move_left) j_next = j_actual - 1;
				end
			end else begin 
				i_next = 0;
				j_next = 0;
			end
			
		end
		
	end 
	
	//assign can_move = (!move_up || !move_right || !move_left || !move_down);
					 
endmodule