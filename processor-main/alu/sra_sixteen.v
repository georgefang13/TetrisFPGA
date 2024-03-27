module sra_sixteen(data_result, data_operandA);

    input [31:0] data_operandA;
    output [31:0] data_result;

    assign data_result[15:0]= data_operandA[31:16];
    assign data_result[31:16] = {data_operandA[31], data_operandA[31], data_operandA[31], data_operandA[31], data_operandA[31], data_operandA[31], data_operandA[31], data_operandA[31], data_operandA[31], data_operandA[31], data_operandA[31], data_operandA[31], data_operandA[31], data_operandA[31], data_operandA[31], data_operandA[31]};

endmodule