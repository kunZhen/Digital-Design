module subt #(parameter N = 4)
				(
				input logic[N-1:0] a, b,
				input logic cin,
				output logic[N-1:0] subtract,
				output logic cout
				);
		
	// Declaración de los cables internos de acarreo
	logic [N:0] carry;
	 
	
	logic a_number[N-1:0]; 
	logic b_number[N-1:0];
	
	logic number_convert[N-1:0];
	
	//assign number_convert = ((a > b) ? b : ((a < b) ? a : 4'b0000));  // choose the number to convert NOT: a or b
	
	logic a_mayor_b;
	logic a_menor_b;
	
	
	
	comparator #(N) comp(a, b, a_mayor_b, a_menor_b);
	
	always_comb begin
    if (a_mayor_b) begin
        for (int i = 0; i < N; i = i + 1) begin
				a_number[i] = a[i];
            b_number[i] = ~b[i];
        end
    end else begin
        for (int i = 0; i < N; i = i + 1) begin
            a_number[i] = ~a[i];
				b_number[i] = b[i];
        end
    end
end

	
	/*
	always_comb begin
        for (int i = 0; i < N; i = i + 1) begin
            not_number[i] = ~number_convert[i];
        end
    end*/
	 
	 genvar i;
    generate
        for (i = 0; i < N; i = i + 1) begin : subt_instances
            sum_1 adder_instance (
                .a(a_number[i]),
                .b(b_number[i]),
                .cin(carry[i]),
                .s(subtract[i]),
                .cout(carry[i+1])
            );
        end
    endgenerate
	 
	 assign carry[0] = cin;
    assign cout = carry[N];
	 
	
			
endmodule