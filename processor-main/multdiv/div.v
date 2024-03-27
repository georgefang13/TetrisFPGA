module div(data_operandA, data_operandB, 
    ctrl_DIV, 
	clock, div_enable,
	data_result, data_exception);

    // Declare inputs:
    input [31:0] data_operandA, data_operandB;
    input ctrl_DIV, div_enable, clock;

    // Declare outputs:
    output [31:0] data_result;
    output data_exception;

    // Declare wires:
    wire [63:0] wRQ_in, wRQ, wPost_Cycle, wSLL_RQ;
    wire [31:0] wDivisor, wN_divisor, wAdd_out, wAdd_V;
    wire wCin, wBreakout, wLSB;

    // Declare register to hold divisor and a wire to hold its inverted form
    register r_divisor(clock, ctrl_DIV, 1'b0, data_operandB, wDivisor);
    bw_not bw_not0(wN_divisor, wDivisor);

    // Declare registers to hold RQ anf a wire to hold its SLL by one version of RQ
    register64 r_RQ(clock, ctrl_DIV||div_enable, 1'b0, wRQ_in, wRQ);
    sll_one64 sll(wSLL_RQ, wRQ);

    // Add or Subtract V depending on the MSB of R
    assign wCin = ~wSLL_RQ[63];
    assign wAdd_V = wSLL_RQ[63] ? wDivisor : wN_divisor;
    adder div_adder(wAdd_out, wSLL_RQ[63:32], wAdd_V, wCin);

    // Set the LSB of Q depending on the MSB of R and compile the new RQ
    assign wPost_Cycle = {wAdd_out, wSLL_RQ[31:1], ~wSLL_RQ[63]};
    // Set RQ to the new RQ if not ctrl_DIV, otherwise set to the starting case 
    assign wRQ_in = ctrl_DIV ? {32'b0, data_operandA} : wPost_Cycle;

    // Check for a data_exception when division by 0
    nor execption(data_exception, wDivisor[31],
                                  wDivisor[30],
                                  wDivisor[29],
                                  wDivisor[28],
                                  wDivisor[27],
                                  wDivisor[26],
                                  wDivisor[25],
                                  wDivisor[24],
                                  wDivisor[23],
                                  wDivisor[22],
                                  wDivisor[21],
                                  wDivisor[20],
                                  wDivisor[19],
                                  wDivisor[18],
                                  wDivisor[17],
                                  wDivisor[16],
                                  wDivisor[15],
                                  wDivisor[14],
                                  wDivisor[13],
                                  wDivisor[12],
                                  wDivisor[11],
                                  wDivisor[10],
                                  wDivisor[9],
                                  wDivisor[8],
                                  wDivisor[7],
                                  wDivisor[6],
                                  wDivisor[5],
                                  wDivisor[4],
                                  wDivisor[3],
                                  wDivisor[2],
                                  wDivisor[1],
                                  wDivisor[0]);

    // Assign data_result to 0 if division by 0, Q otherwise
    assign data_result = data_exception ? 32'b0 : wRQ[31:0];

endmodule