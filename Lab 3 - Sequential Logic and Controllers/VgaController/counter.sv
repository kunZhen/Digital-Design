module counter #(parameter n = 10) (input logic clk, reset,              
												 output reg [n-1:0] result);  
						
	reg [n-1:0] count = 0;
	
	always @ (posedge clk) begin
		 if (reset)
			  count<= 0;
		 else
		 count <= count + 1'd1;
	end 
	
	assign result = count;

endmodule
