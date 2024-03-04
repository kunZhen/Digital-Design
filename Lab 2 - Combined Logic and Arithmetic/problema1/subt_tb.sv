module subt_tb #(parameter N = 4) ();

	logic [N-1:0] a, b, subtract;
	logic cin, cout;
	
	subt #(N) dut(
						a, 
						b, 
						cin,
						subtract,
						cout
						);
	initial begin
	a = 4'b1000;
	b = 4'b1000;
	cin = 1;
	#10ns;
	a = 4'b1010;
	b = 4'b1000;
	cin = 1;
	#10ns;
	a = 4'b1111;
	b = 4'b1000;
	cin = 1;
	#10ns;
	a = 4'b1011;
	b = 4'b1000;
	cin = 1;
	#10ns;
	
	// case: a > b
	a = 4'b1000;
	b = 4'b1001;
	cin = 1;
	#10ns;
	a = 4'b0000;
	b = 4'b1111;
	cin = 1;
	#10ns;
	a = 4'b1001;
	b = 4'b1011;
	cin = 1;
	#10ns;
	a = 4'b1000;
	b = 4'b1011;
	cin = 1;
	#10ns;
	
	
	
	end

endmodule