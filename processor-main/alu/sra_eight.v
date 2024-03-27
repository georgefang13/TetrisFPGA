module sra_eight(data_result, data_operandA);

    input [31:0] data_operandA;
    output [31:0] data_result;

    assign data_result[23:0]= data_operandA[31:8];
    assign data_result[31:24] = {data_operandA[31], data_operandA[31], data_operandA[31], data_operandA[31], data_operandA[31], data_operandA[31], data_operandA[31], data_operandA[31]};

endmodule