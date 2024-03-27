module sll_four(data_result, data_operandA);

    input [31:0] data_operandA;
    output [31:0] data_result;

    assign data_result[31:4] = data_operandA[27:0];
    assign data_result[3:0] = 0;

endmodule