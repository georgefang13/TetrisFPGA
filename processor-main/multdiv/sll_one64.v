module sll_one64(data_result, data_operandA);

    input [63:0] data_operandA;
    output [63:0] data_result;

    assign data_result[63:1] = data_operandA[62:0];
    assign data_result[0] = 0;

endmodule