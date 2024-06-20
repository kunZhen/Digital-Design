module mux_21(input [7:0] A, B,
					input sel,
					output [7:0] C);
					

assign C = sel ? A : B;					
					
					
endmodule					
					