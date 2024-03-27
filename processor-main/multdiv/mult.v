module mult(
	data_operandA, data_operandB, 
	ctrl_MULT, 
	clock, mult_enable,
	data_result, data_exception);

    // Declare inputs:
    input [31:0] data_operandA, data_operandB;
    input ctrl_MULT, mult_enable, clock;

    // Declare outputs:
    output [31:0] data_result;
    output data_exception;

    // Declare wires:
    wire wSOP, wCin, wPositive_ovf, wNegative_ovf, wOVF, wSign_check;
    wire [31:0] wMultand, wSLL_multand, wN_multand, wN_sll_multand, wAdd_A, wAdd_out, wNhigh32;
    wire [64:0] wProduct, wProd_in, wSRA_prod;

    // Declare registers to hold both multiplicant and product
    register r_multand(clock, ctrl_MULT, 1'b0, data_operandA, wMultand);
    register65 r_product(clock, ctrl_MULT||mult_enable, 1'b0, wProd_in, wProduct);

    // Produce each possible adder input according to modified booths 
    sll_one sll(wSLL_multand, wMultand);
    bw_not bw_not0(wN_multand, wMultand);
    bw_not bw_not1(wN_sll_multand, wSLL_multand);

    // Decide which booths operation to perform
    mux_8 booth_mux(wAdd_A, wProduct[2:0], 32'b0, wMultand, wMultand, wSLL_multand, wN_sll_multand, wN_multand, wN_multand, 32'b0);

    // Use simplified sop to calculate carryin 
    or sub(wSOP, ~wProduct[1]&~wProduct[0], wProduct[1]&~wProduct[0], ~wProduct[1]&wProduct[0]);
    and cin(wCin, wSOP, wProduct[2]);

    // Perform the booths operation
    adder mult_adder(wAdd_out, wAdd_A, wProduct[64:33], wCin);

    // Append output to the lower product reg and SRA by 2 
    sra_two65 sra(wSRA_prod, {wAdd_out, wProduct[32:0]});

    // Assign our product input to starting case of ctrl_MULT, the shifter result otherwise
    assign wProd_in = ctrl_MULT ? {32'b0, data_operandB, 1'b0} : wSRA_prod;

    // Check for overflow by confirming that the padding bits match the high result bit or that 2 negatives made a negative
    assign data_result = wProduct[32:1];
    or pos_overflow(wPositive_ovf, wProduct[64],
                                 wProduct[63],
                                 wProduct[62],
                                 wProduct[61],
                                 wProduct[60],
                                 wProduct[59],
                                 wProduct[58],
                                 wProduct[57],
                                 wProduct[56],
                                 wProduct[55],
                                 wProduct[54],
                                 wProduct[53],
                                 wProduct[52],
                                 wProduct[51],
                                 wProduct[50],
                                 wProduct[49],
                                 wProduct[48],
                                 wProduct[47],
                                 wProduct[46],
                                 wProduct[45],
                                 wProduct[44],
                                 wProduct[43],
                                 wProduct[42],
                                 wProduct[41],
                                 wProduct[40],
                                 wProduct[39],
                                 wProduct[38],
                                 wProduct[37],
                                 wProduct[36],
                                 wProduct[35],
                                 wProduct[34],
                                 wProduct[33],
                                 wProduct[32]);
    bw_not bw_not2(wNhigh32, wProduct[64:33]);
    or neg_overflow(wNegative_ovf, wNhigh32[31],
                                   wNhigh32[30],
                                   wNhigh32[29],
                                   wNhigh32[28],
                                   wNhigh32[27],
                                   wNhigh32[26],
                                   wNhigh32[25],
                                   wNhigh32[24],
                                   wNhigh32[23],
                                   wNhigh32[22],
                                   wNhigh32[21],
                                   wNhigh32[20],
                                   wNhigh32[19],
                                   wNhigh32[18],
                                   wNhigh32[17],
                                   wNhigh32[16],
                                   wNhigh32[15],
                                   wNhigh32[14],
                                   wNhigh32[13],
                                   wNhigh32[12],
                                   wNhigh32[11],
                                   wNhigh32[10],
                                   wNhigh32[9],
                                   wNhigh32[8],
                                   wNhigh32[7],
                                   wNhigh32[6],
                                   wNhigh32[5],
                                   wNhigh32[4],
                                   wNhigh32[3],
                                   wNhigh32[2],
                                   wNhigh32[1],
                                   wNhigh32[0],
                                   ~wProduct[32]);  
    xnor highovf(wOVF, wPositive_ovf, wNegative_ovf);
    and sign_check(wSign_check, data_operandA[31], data_operandB[31], data_result[31]);
    or ovf(data_exception, wOVF, wSign_check);


endmodule