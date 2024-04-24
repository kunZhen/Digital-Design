module comparatorEqualThan
#(parameter n = 10) 
(input wire [n-1:0] a, b,
  output reg result);

    always @* begin
      if (a == b) begin
        result = 1;
      end
      else begin
        result = 0;
      end
    end
	 
endmodule