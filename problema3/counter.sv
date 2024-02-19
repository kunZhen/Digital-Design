module counter(clk, reset, q);

input clk,reset;
output reg[3:0] q;

always@(posedge reset,posedge clk)

	if(reset)
	q<= 0;
	else
	q<=q + 1;
	
endmodule