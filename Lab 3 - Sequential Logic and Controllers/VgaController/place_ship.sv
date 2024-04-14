module place_ship (input wire player_place_ship, // switch input
						input wire placing_ships, // placing ships state
						input logic clk, rst,
						input reg [2:0] amount_of_ships,
						output reg [2:0] ships_placed,
						output logic finished_placing);
						
	
	always @(negedge clk or negedge rst) begin
	
		if (!rst) begin
			ships_placed = 0;
			
		end else begin
		
		if (!player_place_ship && placing_ships)
			ships_placed = ships_placed + 1;
		end
		
	end
	
	assign finished_placing = (ships_placed == amount_of_ships);


endmodule