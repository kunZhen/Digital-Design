module sum #(parameter N = 4)
				(
				input logic[N-1:0] a, b,
				input logic cin,
				output logic[N-1:0] s,
				output logic cout
				);
				
		// Declaración de los cables internos de acarreo
    logic [N:0] carry;

    // Instancias de sum_1 para cada bit
    genvar i;
    generate
        for (i = 0; i < N; i = i + 1) begin : adder_instances
            sum_1 adder_instance (
                .a(a[i]),
                .b(b[i]),
                .cin(carry[i]),
                .s(s[i]),
                .cout(carry[i+1])
            );
        end
    endgenerate

    // Conexión del acarreo de entrada y salida
    assign carry[0] = cin;
    assign cout = carry[N];


endmodule