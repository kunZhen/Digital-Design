module shift_left #(parameter N = 4) (
	input logic[N-1:0] a,
	output logic[N-1:0] shift_left_result
);

	assign shift_left_result = a << 1;

endmodule 

