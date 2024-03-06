module sum_1_tb();

	logic a_tb, b_tb, cin_tb;
	logic s_tb, cout_tb;
	
	// instantiate devide under test
	sum_1 dut(a_tb, b_tb, cin_tb, s_tb, cout_tb);
	
	// apply inputs one at a time
	initial begin
	a_tb = 0;
	b_tb = 1;
	cin_tb = 0;
	#40ns;
	
	a_tb = 0;
	b_tb = 0;
	cin_tb = 0;
	#40ns;
	
	a_tb = 0;
	b_tb = 1;
	cin_tb = 1;
	#40ns;
	
	a_tb = 1;
	b_tb = 1;
	cin_tb = 0;
	#40ns;
	
	end


endmodule