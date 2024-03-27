module bw_or(data_result, data_operandA, data_operandB);
    input [31:0] data_operandA, data_operandB;

    output [31:0] data_result;

    or or0(data_result[0], data_operandA[0], data_operandB[0]);
    or or1(data_result[1], data_operandA[1], data_operandB[1]);
    or or2(data_result[2], data_operandA[2], data_operandB[2]);
    or or3(data_result[3], data_operandA[3], data_operandB[3]);
    or or4(data_result[4], data_operandA[4], data_operandB[4]);
    or or5(data_result[5], data_operandA[5], data_operandB[5]);
    or or6(data_result[6], data_operandA[6], data_operandB[6]);
    or or7(data_result[7], data_operandA[7], data_operandB[7]);
    or or8(data_result[8], data_operandA[8], data_operandB[8]);
    or or9(data_result[9], data_operandA[9], data_operandB[9]);

    or or10(data_result[10], data_operandA[10], data_operandB[10]);
    or or11(data_result[11], data_operandA[11], data_operandB[11]);
    or or12(data_result[12], data_operandA[12], data_operandB[12]);
    or or13(data_result[13], data_operandA[13], data_operandB[13]);
    or or14(data_result[14], data_operandA[14], data_operandB[14]);
    or or15(data_result[15], data_operandA[15], data_operandB[15]);
    or or16(data_result[16], data_operandA[16], data_operandB[16]);
    or or17(data_result[17], data_operandA[17], data_operandB[17]);
    or or18(data_result[18], data_operandA[18], data_operandB[18]);
    or or19(data_result[19], data_operandA[19], data_operandB[19]);

    or or20(data_result[20], data_operandA[20], data_operandB[20]);
    or or21(data_result[21], data_operandA[21], data_operandB[21]);
    or or22(data_result[22], data_operandA[22], data_operandB[22]);
    or or23(data_result[23], data_operandA[23], data_operandB[23]);
    or or24(data_result[24], data_operandA[24], data_operandB[24]);
    or or25(data_result[25], data_operandA[25], data_operandB[25]);
    or or26(data_result[26], data_operandA[26], data_operandB[26]);
    or or27(data_result[27], data_operandA[27], data_operandB[27]);
    or or28(data_result[28], data_operandA[28], data_operandB[28]);
    or or29(data_result[29], data_operandA[29], data_operandB[29]);

    or or30(data_result[30], data_operandA[30], data_operandB[30]);
    or or31(data_result[31], data_operandA[31], data_operandB[31]);
endmodule