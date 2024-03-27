module sll_eight(data_result, data_operandA);

    input [31:0] data_operandA;
    output [31:0] data_result;

    assign data_result[31:8] = data_operandA[23:0];
    assign data_result[7:0] = 0;

endmodule