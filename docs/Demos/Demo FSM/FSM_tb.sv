module FSM_tb();

logic clk, rst, x, a, b;

FSM maquina(clk, rst, x, a, b);

always begin
	#10 clk = ~clk;
end

initial begin

	clk = 0;
	rst = 1;
	
	#10
	rst = 0;
	x = 1;
	
	#10
	x = 0;

end

endmodule