module sra_two65(data_result, data_operandA);

    input [64:0] data_operandA;
    output [64:0] data_result;

    assign data_result[62:0]= data_operandA[64:2];
    assign data_result[64:63] = {data_operandA[64], data_operandA[64]};

endmodule