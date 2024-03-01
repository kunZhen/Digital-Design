module subt #(parameter N = 4)
				(
				input logic[N-1:0] a, b,
				input logic cin,
				output logic[N-1:0] subtract,
				output logic cout
				);
		
	// Declaración de los cables internos de acarreo
	logic [N:0] carry;
	 
	logic not_b[N-1:0];
	
	always_comb begin
        for (int i = 0; i < N; i = i + 1) begin
            not_b[i] = ~b[i];
        end
    end
	 
	 genvar i;
    generate
        for (i = 0; i < N; i = i + 1) begin : subt_instances
            sum_1 adder_instance (
                .a(a[i]),
                .b(not_b[i]),
                .cin(carry[i]),
                .s(subtract[i]),
                .cout(carry[i+1])
            );
        end
    endgenerate
	 
	 assign carry[0] = cin;
    assign cout = carry[N];
	 
	
			
endmodule