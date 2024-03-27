module sra_four(data_result, data_operandA);

    input [31:0] data_operandA;
    output [31:0] data_result;

    assign data_result[27:0]= data_operandA[31:4];
    assign data_result[31:28] = {data_operandA[31], data_operandA[31], data_operandA[31], data_operandA[31]};

endmodule