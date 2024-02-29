module alu_tb #(parameter N = 4) ();

	logic [N-1:0] a_tb, b_tb, result_tb;
	logic carrying_tb;
	
	// instantiate devide under test
	alu #(N) dut(a_tb, b_tb, result_tb, carrying_tb);
	
	//apply inputs one at a time
	
	initial begin
	a_tb = 4'b1000;
	b_tb = 4'b1000;
	#10ns;
	a_tb = 4'b1001;
	b_tb = 4'b1000;
	#10ns;
	a_tb = 4'b1011;
	b_tb = 4'b1000;
	#10ns;
	a_tb = 4'b1111;
	b_tb = 4'b1000;
	#10ns;
	
	end




endmodule