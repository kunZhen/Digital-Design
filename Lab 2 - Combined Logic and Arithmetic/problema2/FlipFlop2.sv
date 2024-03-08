module FlipFlop2
                #(parameter N=4)
                
					(input logic clk,        // Entrada del reloj
                input logic reset,      // Entrada de reset
                
				input logic[6:0] units_7segmentsff2, tens_7segmentsff2,
				input logic[N-1:0] 	resultff2, sumResultff2, 
											subResultff2, diviResultff2, 
											moduResultff2, andResultff2,
											orResultff2, xorResultff2,
											shift_left_resultff2, shift_right_resultff2,
				input logic [(N*2)-1:0] multiResultff2,
				input logic carryingSumff2, carryingSubtff2,
				input logic flagNegff2, flagZeroff2, flagCarryff2, flagOverff2,
				
				output logic [6:0] Output_units_7segmentsff2, Output_tens_7segmentsff2,
				output logic [N-1:0] Output_resultff2, Output_sumResultff2, 
											 Output_subResultff2, Output_diviResultff2, 
											 Output_moduResultff2, Output_andResultff2,
											 Output_orResultff2, Output_xorResultff2,
											 Output_shift_left_resultff2, Output_shift_right_resultff2,
				output logic [(N*2)-1:0] Output_multiResultff2,
				output logic Output_carryingSumff2, Output_carryingSubtff2,
				output logic Output_flagNegff2, Output_flagZeroff2, Output_flagCarryff2, Output_flagOverff2

					
				);
				
   always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
        Output_units_7segmentsff2 <= 1'b0;  // Reset the output variables to 0
        Output_tens_7segmentsff2 <= 1'b0;
        Output_resultff2 <= 1'b0;
        Output_sumResultff2 <= 1'b0;
        Output_subResultff2 <= 1'b0;
        Output_diviResultff2 <= 1'b0;
        Output_moduResultff2 <= 1'b0;
        Output_andResultff2 <= 1'b0;
        Output_orResultff2 <= 1'b0;
        Output_xorResultff2 <= 1'b0;
        Output_shift_left_resultff2 <= 1'b0;
        Output_shift_right_resultff2 <= 1'b0;
        Output_multiResultff2 <= 1'b0;
        Output_carryingSumff2 <= 1'b0;
        Output_carryingSubtff2 <= 1'b0;
        Output_flagNegff2 <= 1'b0;
        Output_flagZeroff2 <= 1'b0;
        Output_flagCarryff2 <= 1'b0;
        Output_flagOverff2 <= 1'b0;
    end else begin
        Output_units_7segmentsff2 <= units_7segmentsff2;
        Output_tens_7segmentsff2 <= tens_7segmentsff2;
        Output_resultff2 <= resultff2;
        Output_sumResultff2 <= sumResultff2;
        Output_subResultff2 <= subResultff2;
        Output_diviResultff2 <= diviResultff2;
        Output_moduResultff2 <= moduResultff2;
        Output_andResultff2 <= andResultff2;
        Output_orResultff2 <= orResultff2;
        Output_xorResultff2 <= xorResultff2;
        Output_shift_left_resultff2 <= shift_left_resultff2;
        Output_shift_right_resultff2 <= shift_right_resultff2;
        Output_multiResultff2 <= multiResultff2;
        Output_carryingSumff2 <= carryingSumff2;
        Output_carryingSubtff2 <= carryingSubtff2;
        Output_flagNegff2 <= flagNegff2;
        Output_flagZeroff2 <= flagZeroff2;
        Output_flagCarryff2 <= flagCarryff2;
        Output_flagOverff2 <= flagOverff2;
    end
end

endmodule