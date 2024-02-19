module counter #(parameter N = 6)(
    input clk, 
    input reset, 
    output reg [N-1:0] q
);

    always @(posedge reset, posedge clk) begin
        if (reset) begin
            q <= 0;
        end else begin
            q <= q + 1;
        end
    end

endmodule