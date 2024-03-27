module sra(data_result, data_operandA, ctrl_shiftamt);

    input [31:0] data_operandA;
    input [4:0] ctrl_shiftamt;

    output [31:0] data_result;
    

    wire [31:0] wSRA_SIXTEEN, wSIXTEEN_MUX, wSRA_EIGHT, wEIGHT_MUX, wSRA_FOUR, wFOUR_MUX, wSRA_TWO, wTWO_MUX, wSRA_ONE;

    sra_sixteen sra_sixteen(wSRA_SIXTEEN, data_operandA);
    mux_2 sixteen_mux(wSIXTEEN_MUX, ctrl_shiftamt[4], data_operandA, wSRA_SIXTEEN);

    sra_eight sra_eight(wSRA_EIGHT, wSIXTEEN_MUX);
    mux_2 eight_mux(wEIGHT_MUX, ctrl_shiftamt[3], wSIXTEEN_MUX, wSRA_EIGHT);

    sra_four sra_four(wSRA_FOUR, wEIGHT_MUX);
    mux_2 four_mux(wFOUR_MUX, ctrl_shiftamt[2], wEIGHT_MUX, wSRA_FOUR);

    sra_two sra_two(wSRA_TWO, wFOUR_MUX);
    mux_2 two_mux(wTWO_MUX, ctrl_shiftamt[1], wFOUR_MUX, wSRA_TWO);

    sra_one sra_one(wSRA_ONE, wTWO_MUX);
    mux_2 one_mux(data_result, ctrl_shiftamt[0], wTWO_MUX, wSRA_ONE);


endmodule
