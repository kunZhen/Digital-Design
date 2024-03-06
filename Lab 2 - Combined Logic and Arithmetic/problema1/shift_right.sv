module shift_right #(parameter N = 4) (
	input logic[N-1:0] a,
	output logic[N-1:0] shift_right_result
);

	assign shift_right_result = a >> 1;

endmodule 