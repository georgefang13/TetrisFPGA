module sra_two(data_result, data_operandA);

    input [31:0] data_operandA;
    output [31:0] data_result;

    assign data_result[29:0]= data_operandA[31:2];
    assign data_result[31:30] = {data_operandA[31], data_operandA[31]};

endmodule