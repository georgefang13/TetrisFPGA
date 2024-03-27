module sll_two(data_result, data_operandA);

    input [31:0] data_operandA;
    output [31:0] data_result;

    assign data_result[31:2] = data_operandA[29:0];
    assign data_result[1:0] = 0;

endmodule