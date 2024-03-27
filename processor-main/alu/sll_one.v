module sll_one(data_result, data_operandA);

    input [31:0] data_operandA;
    output [31:0] data_result;

    assign data_result[31:1] = data_operandA[30:0];
    assign data_result[0] = 0;

endmodule