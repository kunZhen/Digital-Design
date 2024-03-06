module modu #(parameter N = 4) (
	input logic[N-1:0] a, b,
	output logic[N-1:0] moduResult
);

	logic zeroDividing;
	
	assign zeroDividing = (b === '0);
	
	always_comb 
		if ( zeroDividing ) 
			for (int i = 0; i < N; i = i + 1) begin
				moduResult[i] = 1'b0;
			end
		else moduResult = a % b;
	
endmodule