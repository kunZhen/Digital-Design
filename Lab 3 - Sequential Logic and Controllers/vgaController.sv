module vgaController #(
	// definen los periodos de tiempo para 
	parameter HACTIVE = 10'd640, // la activación horizontal, 
				 HFP = 10'd16, // el tiempo de preparación horizontal, 
				 HSYN = 10'd96, // el tiempo de sincronización horizontal y 
				 HBP = 10'd48, // el tiempo de post-sincronización horizontal 
				 
				 HMAX = HACTIVE + HFP + HSYN + HBP, 
				 
				 // // definen los periodos de tiempo para
				 VBP = 10'd33, // el tiempo de post-sincronización vertical,
				 VACTIVE = 10'd480, // la activación vertica, 
				 VFP = 10'd10, // el tiempo de preparación vertical y
				 VSYN = 10'd2, // el tiempo de sincronización vertical
				 
				 VMAX = VBP + VACTIVE + VFP + VSYN
	)
	(
				 input logic vgaclk,
				 output logic hsync, vsync, sync_b, blank_b,
				 output logic [9:0] x, y
	);
	
	always @(posedge vgaclk) begin
		x++;
		if(x == HMAX) begin
			x = 0;
			y++;
			if(y == VMAX) y = 0;
		end
	end
	
	assign hsync = ~(x >= HACTIVE + HFP & x < HACTIVE + HFP + HSYN);
	assign vsync = ~(y >= VACTIVE + VFP & y < VACTIVE + VFP + VSYN);
	assign sync_b = hsync & vsync;
	
	assign blank_b = (x < HACTIVE) & (y < VACTIVE);
	
endmodule