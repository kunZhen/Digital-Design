module sum_tb_2();

	logic [4:0] a_tb, b_tb, s_tb;
	logic cin_tb, cout_tb;
	
	// instantiate devide under test
	sum #(5) dut(a_tb, b_tb, cin_tb, s_tb, cout_tb);
	
	//apply inputs one at a time
	
	initial begin
	a_tb = 5'b10000;
	b_tb = 5'b10000;
	cin_tb = 1;
	#10ns;
	a_tb = 5'b10001;
	b_tb = 5'b10001;
	cin_tb = 0;
	#10ns;
	a_tb = 5'b10011;
	b_tb = 5'b10000;
	cin_tb = 0;
	#10ns;
	a_tb = 5'b10011;
	b_tb = 5'b10111;
	cin_tb = 0;
	#10ns;
	a_tb = 5'b11111;
	b_tb = 5'b10000;
	cin_tb = 0;
	#10ns;
	
	end


endmodule