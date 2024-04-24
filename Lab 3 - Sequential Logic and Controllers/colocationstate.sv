module colocationstate(

	/* 
	
	*/
	input logic [2:0] amount_ships,  // Number of ships to place
   input logic colocation_ships,                   // Signal to indicate decision state
   input logic clk,                        // System clock
   input logic rst,                        // Reset
   input logic player_confirm_amount,      // Input switch to confirm number of ships
   output logic ships_decided              // Output to indicate ships have been located
	
);

endmodule