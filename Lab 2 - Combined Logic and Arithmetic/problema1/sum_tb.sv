module sum_tb();

	logic [3:0] a_tb, b_tb, s_tb;
	logic cin_tb, cout_tb;
	
	// instantiate devide under test
	sum #(4) dut(a_tb, b_tb, cin_tb, s_tb, cout_tb);
	
	//apply inputs one at a time
	
	initial begin
	a_tb = 4'b1000;
	b_tb = 4'b1000;
	cin_tb = 0;
	#40ns;
	a_tb = 4'b0000;
	b_tb = 4'b0000;
	cin_tb = 0;
	#40ns;
	a_tb = 4'b1001;
	b_tb = 4'b1001;
	cin_tb = 0;
	#40ns;
	a_tb = 4'b1111;
	b_tb = 4'b1111;
	cin_tb = 0;
	#40ns;
	a_tb = 4'b1001;
	b_tb = 4'b1111;
	cin_tb = 0;
	#40ns;
	
	end


endmodule