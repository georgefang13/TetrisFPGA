module sll(data_result, data_operandA, ctrl_shiftamt);

    input [31:0] data_operandA;
    input [4:0] ctrl_shiftamt;

    output [31:0] data_result;
    

    wire [31:0] wSLL_SIXTEEN, wSIXTEEN_MUX, wSLL_EIGHT, wEIGHT_MUX, wSLL_FOUR, wFOUR_MUX, wSLL_TWO, wTWO_MUX, wSLL_ONE;

    sll_sixteen sll_sixteen(wSLL_SIXTEEN, data_operandA);
    mux_2 sixteen_mux(wSIXTEEN_MUX, ctrl_shiftamt[4], data_operandA, wSLL_SIXTEEN);

    sll_eight sll_eight(wSLL_EIGHT, wSIXTEEN_MUX);
    mux_2 eight_mux(wEIGHT_MUX, ctrl_shiftamt[3], wSIXTEEN_MUX, wSLL_EIGHT);

    sll_four sll_four(wSLL_FOUR, wEIGHT_MUX);
    mux_2 four_mux(wFOUR_MUX, ctrl_shiftamt[2], wEIGHT_MUX, wSLL_FOUR);

    sll_two sll_two(wSLL_TWO, wFOUR_MUX);
    mux_2 two_mux(wTWO_MUX, ctrl_shiftamt[1], wFOUR_MUX, wSLL_TWO);

    sll_one sll_one(wSLL_ONE, wTWO_MUX);
    mux_2 one_mux(data_result, ctrl_shiftamt[0], wTWO_MUX, wSLL_ONE);


endmodule