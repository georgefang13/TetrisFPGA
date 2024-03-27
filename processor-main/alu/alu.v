module alu(data_operandA, data_operandB, ctrl_ALUopcode, ctrl_shiftamt, data_result, isNotEqual, isLessThan, overflow);
        
    input [31:0] data_operandA, data_operandB;
    input [4:0] ctrl_ALUopcode, ctrl_shiftamt;

    output [31:0] data_result;
    output isNotEqual, isLessThan, overflow;

    wire [31:0] notData_operandB, wDB, wAdd, wAnd, wOr, wSLL, wSRA;
    wire nA, nB, nO,            // nand wires
         ABnO, norAB, OnorAB,   // overflow wires
         nABO, AnBO, AB;        // lt wires


    // Prep incase of subtraction
    bw_not bw_not(notData_operandB, data_operandB);

    // Decide if adding or subtracting B
    mux_2 add_sub(wDB, ctrl_ALUopcode[0], data_operandB, notData_operandB);

    // Add A and B 
    adder adder(wAdd, data_operandA, wDB, ctrl_ALUopcode[0]);

    // For caluclating ne and lt:
    not gt_nA(nA, data_operandA[31]);
    not gt_nB(nB, wDB[31]);
    not gt_nO(nO, wAdd[31]);

    // Calculating overflow:
    and gt_ABnO(ABnO, data_operandA[31], wDB[31], nO);
    nor gt_norAB(norAB, data_operandA[31], wDB[31]);
    and gt_OnorAB(OnorAB, norAB, wAdd[31]);
    or ovf(overflow, OnorAB, ABnO);

    // Calculating NE:
    or ne(isNotEqual, wAdd[0],
                      wAdd[1],
                      wAdd[2],
                      wAdd[3],
                      wAdd[4],
                      wAdd[5],
                      wAdd[6],
                      wAdd[7],
                      wAdd[8],
                      wAdd[9],
                      wAdd[10],
                      wAdd[11],
                      wAdd[12],
                      wAdd[13],
                      wAdd[14],
                      wAdd[15],
                      wAdd[16],
                      wAdd[17],
                      wAdd[18],
                      wAdd[19],
                      wAdd[20],
                      wAdd[21],
                      wAdd[22],
                      wAdd[23],
                      wAdd[24],
                      wAdd[25],
                      wAdd[26],
                      wAdd[27],
                      wAdd[28],
                      wAdd[29],
                      wAdd[30],
                      wAdd[31]);

    // Caluclating lt:
    and gt_nABO(nABO, nA, wDB[31], wAdd[31]);
    and gt_AnBO(AnBO, data_operandA[31], nB, wAdd[31]);
    and gt_AB(AB, data_operandA[31], wDB[31]);
    or lt(isLessThan, nABO, AnBO, AB);
    
    // Calculatinng bw_and and or:
    bw_and bw_and(wAnd, data_operandA, data_operandB);
    bw_or bw_or(wOr, data_operandA, data_operandB);

    // Calculating shifts:
    sll sll(wSLL, data_operandA, ctrl_shiftamt);
    sra sra(wSRA, data_operandA, ctrl_shiftamt);

    // Decide which function to output
    mux_8 output_mux(data_result, ctrl_ALUopcode[2:0], wAdd, wAdd, wAnd, wOr, wSLL, wSRA, 0, 0);

endmodule