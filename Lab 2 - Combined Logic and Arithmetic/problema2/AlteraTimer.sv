module AlteraTimer
     #(parameter N = 4)
	 (
	  //Se definen las entradas 	  
	 input logic [N-1:0] a_n, b_n, op_n,op_sum_n, op_rest_n,
	  input logic clk, reset,
	  
	  //Se definen las salidas 
	 
 output logic [6:0] a,
 output logic [6:0] b,
 output logic [N-1:0] c,d,e,f,g,h,i,j,k,l,
 output logic [(N*2)-1:0] m,
 output logic n,o,
 output logic q,r,s 

);





//Definir las variables intermedias 

reg [6:0] units_7segments, tens_7segments;
reg [N-1:0] result, sumResult, subResult, diviResult, moduResult, andResult, orResult, xorResult;
reg shift_left_result, shift_right_result;
reg [(N*2)-1:0] multiResult;
reg carryingSum, carryingSubt;
reg flagNeg, flagZero, flagCarry, flagOver;



reg [N-1:0] Output_A1;
reg [N-1:0] Output_B1;
reg [2:0] Output_op1;
reg Output_op_sum1, Output_op_rest1;



reg [6:0] O_units_7segments, O_tens_7segments;
reg [N-1:0] O_result, O_sumResult, O_subResult, O_diviResult, O_moduResult, O_andResult, O_orResult, O_xorResult;
reg O_shift_left_result, O_shift_right_result;
reg [(N*2)-1:0] O_multiResult;
reg O_carryingSum, O_carryingSubt;
reg O_flagNeg, O_flagZero, O_flagCarry, O_flagOver;

					
			

//Se instancian los 3 modulos ALU, FlipFlop1,FlipFlop2

FlipFlop1 #(N)
    ff1_inst (
        .clk(clk),
        .reset(reset),
        .aff1(a_n),
        .bff1(b_n),
        .opff1(op_n),
        .op_sumff1(op_sum_n),
        .op_restff1(op_rest_n),
        .Output_aff1(Output_A1),
        .Output_bff1(Output_B1),
        .Output_opff1(Output_op1),
        .Output_op_sumff1(Output_op_sum1),
        .Output_op_restff1(Output_op_rest1)
    );


alu #(N) alu_inst (
    .a(Output_A1),
    .b(Output_B1),
    .op(Output_op1),
    .op_sum(Output_op_sum1),
    .op_subt(Output_op_rest1),
    .units_7segments(O_units_7segments),
    .tens_7segments(O_tens_7segments),
    .result(O_result),
    .sumResult(O_sumResult),
    .subResult(O_subResult),
    .diviResult(O_diviResult),
    .moduResult(O_moduResult),
    .andResult(O_andResult),
    .orResult(O_orResult),
    .xorResult(O_xorResult),
    .shift_left_result(O_shift_left_result),
    .shift_right_result(O_shift_right_result),
    .multiResult(O_multiResult),
    .carryingSum(O_carryingSum),
    .carryingSubt(O_carryingSubt),
    .flagNeg(O_flagNeg),
    .flagZero(O_flagZero),
    .flagCarry(O_flagCarry),
    .flagOver(O_flagOver)
);

FlipFlop2 #(N) ff2_inst (
    .clk(clk),
    .reset(reset),
    .units_7segmentsff2(O_units_7segments),
    .tens_7segmentsff2(O_tens_7segments),
    .resultff2(O_result),
    .sumResultff2(O_sumResult),
    .subResultff2(O_subResult),
    .diviResultff2(O_diviResult),
    .moduResultff2(O_moduResult),
    .andResultff2(O_andResult),
    .orResultff2(O_orResult),
    .xorResultff2(O_xorResult),
    .shift_left_resultff2(O_shift_left_result),
    .shift_right_resultff2(O_shift_right_result),
    .multiResultff2(O_multiResult),
    .carryingSumff2(O_carryingSum),
    .carryingSubtff2(O_carryingSubt),
    .flagNegff2(O_flagNeg),
    .flagZeroff2(O_flagZero),
    .flagCarryff2(O_flagCarry),
    .flagOverff2(O_flagOver),
    .Output_units_7segmentsff2(a),
    .Output_tens_7segmentsff2(b),
    .Output_resultff2(c),
    .Output_sumResultff2(d),
    .Output_subResultff2(e),
    .Output_diviResultff2(f),
    .Output_moduResultff2(g),
    .Output_andResultff2(h),
    .Output_orResultff2(i),
    .Output_xorResultff2(j),
    .Output_shift_left_resultff2(k),
    .Output_shift_right_resultff2(l),
    .Output_multiResultff2(m),
    .Output_carryingSumff2(n),
    .Output_carryingSubtff2(o),
    .Output_flagNegff2(q),
    .Output_flagZeroff2(r),
    .Output_flagCarryff2(s)
);
endmodule