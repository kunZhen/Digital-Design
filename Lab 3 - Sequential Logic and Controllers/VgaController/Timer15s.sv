module Timer15s #(parameter NBits = 23,   parameter countMAX = 5000000)(input logic clk, reset,
		output clkOut
	);
	
logic [22:0] result;
reg flagUp;
logic seudoRst;
	
counter #(NBits) tally(clk, seudoRst, result);

comparatorEqualThan #(NBits) compare (countMAX, result, flagUp);

assign clkOut = flagUp;
assign seudoRst = reset || flagUp;

endmodule