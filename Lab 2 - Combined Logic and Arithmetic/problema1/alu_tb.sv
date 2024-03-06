module alu_tb #(parameter N = 4) ();

	logic [N-1:0] a_tb, b_tb, 	result_tb, sumResult, 
										subResult, diviResult, 
										moduResult, andResult, 
										orResult;
	logic [(N*2)-1:0] multiResult;
	logic [2:0] op_tb;
	logic op_sum_tb, op_subt_tb, carryingSum_tb, carryingSub_tb;
	
	// instantiate devide under test
	alu #(N) dut(a_tb, 
					b_tb, 
					op_tb, 
					op_sum_tb, 
					op_subt_tb, 
					result_tb, sumResult, 
					subResult, diviResult, 
					moduResult, andResult, 
					orResult,
					multiResult,
					carryingSum_tb, carryingSub_tb);
	
	// apply inputs one at a time
	// low logic level = pressed
	// high logic level = not pressed
	
	initial begin
	a_tb = 4'b1000;
	b_tb = 4'b0000;
	op_tb = 3'b111; // 0 : 000
	op_sum_tb = 0;
	op_subt_tb = 0;
	#10ns;
	a_tb = 4'b1001;
	b_tb = 4'b1001;
	op_tb = 3'b110; // 1 : 001
	op_sum_tb = 0;
	op_subt_tb = 0;
	#10ns;
	a_tb = 4'b1010;
	b_tb = 4'b0010;
	op_tb = 3'b101; // 2 : 010
	op_sum_tb = 0;
	op_subt_tb = 0;
	#10ns;
	a_tb = 4'b1011;
	b_tb = 4'b1011;
	op_tb = 3'b100; // 3 : 011
	op_sum_tb = 0;
	op_subt_tb = 0;
	#10ns;
	a_tb = 4'b1000;
	b_tb = 4'b1000;
	op_tb = 3'b011; // 4 : 100
	op_sum_tb = 0;
	op_subt_tb = 0;
	#10ns;
	a_tb = 4'b1000;
	b_tb = 4'b1000;
	op_tb = 3'b010; // 5 : 101
	op_sum_tb = 0;
	op_subt_tb = 0;
	#10ns;
	a_tb = 4'b1000;
	b_tb = 4'b1000;
	op_tb = 3'b001; // 6 : 110
	op_sum_tb = 0;
	op_subt_tb = 0;
	#10ns;
	a_tb = 4'b1000;
	b_tb = 4'b1000;
	op_tb = 3'b000; // 7 : 111
	op_sum_tb = 0;
	op_subt_tb = 0;
	#10ns;
	
	// To add or substract 
	a_tb = 4'b1111;
	b_tb = 4'b1000;
	op_tb = 3'b111; 
	op_sum_tb = 1; // sum
	op_subt_tb = 0;
	#10ns;
	a_tb = 4'b1111;
	b_tb = 4'b1000;
	op_tb = 3'b111; 
	op_sum_tb = 1; // sum
	op_subt_tb = 1;
	#10ns;
	a_tb = 4'b1111;
	b_tb = 4'b1111;
	op_tb = 3'b111;
	op_sum_tb = 0; 
	op_subt_tb = 1; // substract
	#10ns;
	
	end




endmodule