module adder(data_result, data_operandA, data_operandB, c0);
    input [31:0] data_operandA, data_operandB;
    input c0;

    output [31:0] data_result;

    wire G0, P0, G1, P1, G2, P2, G3, P3,
         P0c0,
         P1G0, P10c0,
         P2G1, P21G0, P210c0,
         P3G2, P32G1, P321G0, P3210c0,
         c8, c16, c24;


    // Calculating c8:
    block b0(data_result[7:0], G0, P0, data_operandA[7:0], data_operandB[7:0], c0);
    and gt_P0c0(P0c0, P0, c0);
    or gt_c8(c8, G0, P0c0);

    // Calculating c16:    
    block b1(data_result[15:8], G1, P1, data_operandA[15:8], data_operandB[15:8], c8);
    and gt_P1G0(P1G0, P1, G0);
    and gt_P10c0(P10c0, P1, P0c0);
    or gt_c16(c16, G1, P1G0, P10c0);

    // Calculating c24:
    block b2(data_result[23:16], G2, P2, data_operandA[23:16], data_operandB[23:16], c16);
    and gt_P2G1(P2G1, P2, G1);
    and gt_P21G0(P21G0, P2, P1G0);
    and gt_P210c0(P210c0, P2, P10c0);
    or gt_c24(c24, G2, P2G1, P21G0, P210c0);

    // Calculating c32:
    block b3(data_result[31:24], G3, P3, data_operandA[31:24], data_operandB[31:24], c24);

endmodule