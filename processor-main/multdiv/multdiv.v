module multdiv(
	data_operandA, data_operandB, 
	ctrl_MULT, ctrl_DIV, 
	clock, enable,
	data_result, data_exception, data_resultRDY);

    // Input declarations:
    input [31:0] data_operandA, data_operandB;
    input ctrl_MULT, ctrl_DIV, clock, enable;

    // Output declarations:
    output [31:0] data_result;
    output data_exception, data_resultRDY;

    // Wire Declarations:
    wire [31:0] wMult_data_result, wDiv_data_result, wDiv_data_out, wDiv_data_op, wN_Div_data_out, 
                wN_A, wN_B, wOp_A, wOp_B, wDiv_A, wDiv_B;
                // data_operandA, data_operandB;
    wire [5:0] wCount;
    wire wClear, wMult_enable, wMult_dff_en, wMult_clear, wMult_data_exception, wMult_ready, 
         wDiv_enable, wDiv_dff_en, wDiv_clear, wDiv_data_exception, wDiv_ready, wDiv_neg;

    // register a(~clock, ctrl_MULT||ctrl_DIV, 1'b0, data_A, data_operandA);
    // register b(~clock, ctrl_MULT||ctrl_DIV, 1'b0, data_B, data_operandB);
    
    // Declare two DFFs that track what the current operation is
    custom_dff mult_enable(wMult_enable, ctrl_MULT, clock, ctrl_MULT, ctrl_DIV||~enable);
    custom_dff div_enable(wDiv_enable, ctrl_DIV, clock, ctrl_DIV, ctrl_MULT||~enable);

    // Negate A and B in the negative case for div:
    bw_not nA(wN_A, data_operandA);
    bw_not nB(wN_B, data_operandB);
    // If negative operand, operate on the negated version for div
    assign wOp_A = data_operandA[31] ? wN_A: data_operandA;
    assign wOp_B = data_operandB[31] ? wN_B: data_operandB;
    // Positive cases pass through, negative are made positive for div
    adder A_adder(wDiv_A, wOp_A, 32'b0, data_operandA[31]);
    adder B_adder(wDiv_B, wOp_B, 32'b0, data_operandB[31]);

    // Declare counter that resets when a new operation is asserted
    or clr(wClear, ctrl_MULT, ctrl_DIV);
    counter count(wCount, clock, enable, wClear);

    // Declare instances of multiplier and divider
    mult multiplier(data_operandA, data_operandB, ctrl_MULT, clock, wMult_enable, wMult_data_result, wMult_data_exception);
    div divider(wDiv_A, wDiv_B, ctrl_DIV, clock, wDiv_enable, wDiv_data_out, wDiv_data_exception);

    // Check for diagreeing input signs for div
    xor sign_check(wDiv_neg, data_operandA[31], data_operandB[31]);
    // If they disagree, negate the output as done for the inputs above
    bw_not nDiv(wN_Div_data_out, wDiv_data_out);
    assign wDiv_data_op = wDiv_neg ? wN_Div_data_out : wDiv_data_out;
    adder div_adder(wDiv_data_result, wDiv_data_op, 32'b0, wDiv_neg);

    // Assert an exception if mult or div throws an exception when they are the current operation
    or execption(data_exception, wDiv_data_exception&wDiv_enable, wMult_data_exception&wMult_enable);

    // Check if the either data is ready and that they are the current operation
    and mult_ready(wMult_ready, wMult_enable, ~wCount[5], wCount[4], ~wCount[3], ~wCount[2], ~wCount[1], ~wCount[0]); 
    and div_ready(wDiv_ready, wDiv_enable, wCount[5], ~wCount[4], ~wCount[3], ~wCount[2], ~wCount[1], wCount[0]); 
    or ready(data_resultRDY, wMult_ready, wDiv_ready);

    // Set data_result to the mult or div output depending on what operation we are on
    assign data_result = wMult_enable ? wMult_data_result : wDiv_data_result;

endmodule