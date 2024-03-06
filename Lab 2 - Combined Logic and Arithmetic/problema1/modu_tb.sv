module modu_tb #(parameter N = 4) ();

	logic[N-1:0] a, b;
	logic[N-1:0] moduResult;

	modu #(N) dut(a, b, moduResult);
	
	initial begin
	a = 4'b0100;
	b = 4'b1111;
	#10ns;
	a = 4'b1110;
	b = 4'b0001;
	#10ns;
	a = 4'b1001;
	b = 4'b0010;
	#10ns;
	a = 4'b1000;
	b = 4'b0100;
	#10ns;
	a = 4'b1111;
	b = 4'b1111;
	#10ns;
	a = 4'b0000;
	b = 4'b1111;
	#10ns;
	a = 4'b0000;
	b = 4'b0000;
	#10ns;
	end

endmodule