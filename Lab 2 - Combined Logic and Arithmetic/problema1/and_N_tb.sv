module and_N_tb #(parameter N = 4) ();

	logic[N-1:0] a, b;
	logic[N-1:0] andResult;

	and_N_bits #(N) dut(a, b, andResult);
	
	initial begin
	a = 4'b0111;
	b = 4'b1111;
	#10ns;
	a = 4'b1110;
	b = 4'b0111;
	#10ns;
	a = 4'b1001;
	b = 4'b1001;
	#10ns;
	a = 4'b1000;
	b = 4'b0000;
	#10ns;
	a = 4'b1111;
	b = 4'b1111;
	#10ns;
	a = 4'b0000;
	b = 4'b1111;
	#10ns;
	a = 4'b0011;
	b = 4'b1100;
	#10ns;
	end

endmodule