module divid #(parameter N = 2) (
	input logic[N-1:0] a, b,
	output logic[N-1:0] dividResult
);
	
	logic a_mayor_b;
	logic a_menor_b;
	
	assign a_mayor_b = (a > b);
	assign a_menor_b = (a < b);

	always_comb 
		if (a_menor_b | (b === '0) ) 
			for (int i = 0; i < N; i = i + 1) begin
				dividResult[i] = 1'b0;
			end
		else dividResult = a / b;
	

endmodule 