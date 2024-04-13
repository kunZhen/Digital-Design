module Battleship (
	input logic move_up, move_down, move_left, move_right, clk, rst,
	output logic vgaclk,
	output logic hsync, vsync,
	output logic sync_b, blank_b,
	output logic [7:0] r, g, b
	);
	
	
	reg clk_ms;
	reg [2:0] i_actual, j_actual;
	reg [2:0] i_next, j_next;
							  
	vga_clock clkdiv (
		clk, clk_ms
	);
	
	controls movement_controls(
		i_actual, j_actual, 
		move_up, move_down, move_left, move_right, clk_ms, rst,
		i_next, j_next
	);
	
	updateIndex updateIJ(
		i_next, j_next, clk_ms, rst,
		i_actual, j_actual
	);
	
	
	vga vga(
		clk, i_actual, j_actual,
		vgaclk, hsync, vsync, sync_b, blank_b, r, g, b
	);
	
	
	
endmodule
	