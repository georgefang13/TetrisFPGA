/**
 * READ THIS DESCRIPTION!
 *
 * This is your processor module that will contain the bulk of your code submission. You are to implement
 * a 5-stage pipelined processor in this module, accounting for hazards and implementing bypasses as
 * necessary.
 *
 * Ultimately, your processor will be tested by a master skeleton, so the
 * testbench can see which controls signal you active when. Therefore, there needs to be a way to
 * "inject" imem, dmem, and regfile interfaces from some external controller module. The skeleton
 * file, Wrapper.v, acts as a small wrapper around your processor for this purpose. Refer to Wrapper.v
 * for more details.
 *
 * As a result, this module will NOT contain the RegFile nor the memory modules. Study the inputs 
 * very carefully - the RegFile-related I/Os are merely signals to be sent to the RegFile instantiated
 * in your Wrapper module. This is the same for your memory elements. 
 *
 *
 */
module processor(
    // Control signals
    clock,                          // I: The master clock
    reset,                          // I: A reset signal

    // Imem
    address_imem,                   // O: The address of the data to get from imem
    q_imem,                         // I: The data from imem

    // Dmem
    address_dmem,                   // O: The address of the data to get or put from/to dmem
    data,                           // O: The data to write to dmem
    wren,                           // O: Write enable for dmem
    q_dmem,                         // I: The data from dmem

    // Regfile
    ctrl_writeEnable,               // O: Write enable for RegFile
    ctrl_writeReg,                  // O: Register to write to in RegFile
    ctrl_readRegA,                  // O: Register to read from port A of RegFile
    ctrl_readRegB,                  // O: Register to read from port B of RegFile
    data_writeReg,                  // O: Data to write to for RegFile
    data_readRegA,                  // I: Data from port A of RegFile
    data_readRegB                   // I: Data from port B of RegFile
	 
	);

	// Control signals
	input clock, reset;
	
	// Imem
    output [31:0] address_imem;
	input [31:0] q_imem;

	// Dmem
	output [31:0] address_dmem, data;
	output wren;
	input [31:0] q_dmem;

	// Regfile
	output ctrl_writeEnable;
	output [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
	output [31:0] data_writeReg;
	input [31:0] data_readRegA, data_readRegB;

    // Wires
    wire[31:0] next_pc, pc_plus_one, pc_plus_n,
               fd_ir_in,
               dx_ir_in, dx_a_in, dx_b_in,
               xm_ir_in,
               fd_pc_out, fd_ir_out,
               dx_pc_out, dx_a_out, dx_b_out, dx_ir_out,
               xm_pc_out, xm_o_out, xm_b_out, xm_ir_out,
               mw_pc_out, mw_o_out, mw_d_out, mw_ir_out,
               pw_p_out, pw_ir_out,
               md_p_out, 
               immed, immed_mux_in, target,
               alu_in_a, alu_in_b, alu_out, rstatus,
               d_decode, x_decode, m_decode, w_decode, md_decode;
    wire[4:0] alu_op_code, dx_rs2;
    wire[3:0] ctrl_alu_b; 
    wire[2:0] ctrl_alu_a, ctrl_jr;

    wire nClock,
         isBranch, isJump, isJr, isBex, isMult, isDiv, isMD, isRunning_MD, isHazard,
         pc_enable, fd_enable, dx_enable, xm_enable, mw_enable, pw_enable, pw_ir_enable, 
         fd_nop, dx_nop, xm_nop, mw_nop, pw_nop,
         md_data_ready_out, md_ex_out,
         pw_data_ready_out, pw_ex_out, 
         isImmed_D, isImmed_X, isB_Type_X,
         alu_lt, alu_neq, alu_ovf,
         isAddEx, isAddiEx, isSubEx, isMultEx, isDivEx,
         ctrl_mem_d;

    // Declare !clock for falling edge triggered components
    assign nClock = ~clock;

    // Enable and stall control
    assign pc_enable = ~isMD && ~isHazard;
    assign fd_enable = ~isMD && ~isHazard;
    assign dx_enable = ~isMD;
    assign pw_enable = isMult||isDiv||md_data_ready_out;
    assign pw_ir_enable = isMult||isDiv;

    assign fd_nop = isBranch || isJump || isJr || isBex;
    assign dx_nop = isBranch || isMD || isHazard;

    // Bypassing control
    // ALU bypassing
    assign ctrl_alu_a[2] = m_decode[21] && dx_ir_out[21:17] == 5'b11110;
    assign ctrl_alu_a[1] = (mw_ir_out[26:22] != 0 && (dx_ir_out[21:17] == mw_ir_out[26:22]) && ~w_decode[7]) || ((w_decode[21] || pw_ex_out) && dx_ir_out[21:17] == 5'b11110);
    assign ctrl_alu_a[0] = xm_ir_out[26:22] != 0 && (dx_ir_out[21:17] == xm_ir_out[26:22] && ~m_decode[7]);

    assign dx_rs2 = x_decode[22] ? 5'b11110 : (x_decode[2]||x_decode[4]||x_decode[6]||x_decode[7]||x_decode[8]) ? dx_ir_out[26:22] : dx_ir_out[16:12];
    assign ctrl_alu_b[3] = m_decode[21] && dx_rs2 == 5'b11110;
    assign ctrl_alu_b[2] = (mw_ir_out[26:22] != 0 && (dx_rs2 == mw_ir_out[26:22]) && ~(d_decode[4]||x_decode[7]||w_decode[2]||w_decode[6]||w_decode[7])) || ((w_decode[21] || pw_ex_out) && dx_ir_out[21:17] == 5'b11110) || (w_decode[3] && (dx_rs2 == 5'b11111));
    assign ctrl_alu_b[1] = xm_ir_out[26:22] != 0 && (dx_rs2 == xm_ir_out[26:22]) && ~(d_decode[4]||x_decode[7]||x_decode[8]||m_decode[2]||m_decode[6]||m_decode[7]||m_decode[8]);
    assign ctrl_alu_b[0] = xm_ir_out[26:22] != 0 && (dx_rs2 == xm_ir_out[26:22]) && m_decode[8] && ~(d_decode[4]||x_decode[7]||x_decode[8]||m_decode[2]||m_decode[6]||m_decode[7]);

    // JR bypassing
    assign ctrl_jr[2] = mw_ir_out[26:22] != 0 && isJr && (fd_ir_out[26:22] == mw_ir_out[26:22]); 
    assign ctrl_jr[1] = xm_ir_out[26:22] != 0 && isJr && (fd_ir_out[26:22] == xm_ir_out[26:22]); 
    assign ctrl_jr[0] = dx_ir_out[26:22] != 0 && isJr && (fd_ir_out[26:22] == dx_ir_out[26:22]) && ~x_decode[8];

    // Memory bypassing
    assign ctrl_mem_d = mw_ir_out[26:22] != 0 && (mw_ir_out[26:22] == xm_ir_out[26:22]);

    // Declaring each pipelining latch:
    fd_latch fd(fd_pc_out, fd_ir_out, nClock, fd_enable, reset, pc_plus_one, fd_ir_in);
    dx_latch dx(dx_pc_out, dx_a_out, dx_b_out, dx_ir_out, nClock, dx_enable, reset, fd_pc_out, dx_a_in, dx_b_in, dx_ir_in);
    xm_latch xm(xm_pc_out, xm_o_out, xm_b_out, xm_ir_out, nClock, 1'b1, reset, dx_pc_out, alu_out, immed_mux_in, xm_ir_in);
    mw_latch mw(mw_pc_out, mw_o_out, mw_d_out, mw_ir_out, nClock, 1'b1, reset, xm_pc_out, xm_o_out, q_dmem, xm_ir_out);

    // FETCH STAGE
    assign next_pc = isBranch ? pc_plus_n : (isJump||isBex) ? target : ctrl_jr[0] ? alu_out : ctrl_jr[1] ? xm_o_out : ctrl_jr[2] ? data_writeReg : isJr ? data_readRegB : pc_plus_one;
    assign fd_ir_in = fd_nop ? 32'b0 : q_imem;

    // PC counter and adder
    register pc(nClock, pc_enable, reset, next_pc, address_imem);
    adder pc_increment(pc_plus_one, address_imem, 32'b0, 1'b1);

    // DECODE STAGE
    decoder32 ddecode(d_decode, fd_ir_out[31:27], 1'b1);

    // Controls
    assign ctrl_readRegA = fd_ir_out[21:17];
    assign ctrl_readRegB = d_decode[22] ? 5'b11110 : isImmed_D||isJr? fd_ir_out[26:22] : fd_ir_out[16:12];
    assign isImmed_D = d_decode[2]||d_decode[5]||d_decode[6]||d_decode[7]||d_decode[8];
    assign isJump = d_decode[1] || d_decode[3];
    assign isJr = d_decode[4];
    assign isBex = d_decode[22] && data_readRegB!=0;
    assign isHazard = (x_decode[8] && ((fd_ir_out[21:17] == dx_ir_out[26:22]) || ((fd_ir_out[16:12] == dx_ir_out[26:22]) && ~d_decode[7]))) || (isJr && x_decode[8] && (fd_ir_out[26:22]==dx_ir_out[26:22])) || (isJr && m_decode[8] && (fd_ir_out[26:22]==xm_ir_out[26:22]));
    assign target = {5'b0, fd_ir_out[26:0]};
    
    // DX latch inputs
    assign dx_ir_in = dx_nop ? 32'b0 : fd_ir_out;
    assign dx_a_in = data_readRegA;
    assign dx_b_in = data_readRegB;

    // EXECUTION STAGE
    decoder32 xdecode(x_decode, dx_ir_out[31:27], 1'b1);

    // Branch adder
    adder pc_branch(pc_plus_n, dx_pc_out, immed, 1'b0);

    //Immediate construction
    assign immed[15:0] = dx_ir_out[15:0];
    assign immed[31:16] = {dx_ir_out[16], dx_ir_out[16], dx_ir_out[16], dx_ir_out[16], dx_ir_out[16], dx_ir_out[16], dx_ir_out[16], dx_ir_out[16], dx_ir_out[16], dx_ir_out[16], dx_ir_out[16], dx_ir_out[16], dx_ir_out[16], dx_ir_out[16], dx_ir_out[16], dx_ir_out[16]};

    // Controls
    assign isImmed_X = x_decode[5]||x_decode[7]||x_decode[8];
    assign isB_Type_X = x_decode[2]||x_decode[6];
    assign isBranch = (x_decode[2]&&alu_neq) || (x_decode[6]&&(~alu_lt)&&alu_neq);
    assign isMult = x_decode[0]&&~dx_ir_out[6]&&~dx_ir_out[5]&&dx_ir_out[4]&&dx_ir_out[3]&&~dx_ir_out[2];
    assign isDiv = x_decode[0]&&~dx_ir_out[6]&&~dx_ir_out[5]&&dx_ir_out[4]&&dx_ir_out[3]&&dx_ir_out[2];
    assign isRunning_MD = (pw_ir_out[4]&&pw_ir_out[3]);
    assign isMD = (isMult||isDiv)||isRunning_MD;

    // ALU/immed bypassing
    assign alu_in_a = ctrl_alu_a[0] ? xm_o_out : ctrl_alu_a[1] ? data_writeReg : ctrl_alu_a[2] ? {5'b0, xm_ir_out[26:0]} : dx_a_out;
    assign immed_mux_in = ctrl_alu_b[0] ? q_dmem : ctrl_alu_b[1] ? xm_o_out : ctrl_alu_b[2] ? data_writeReg : ctrl_alu_b[3] ? {5'b0, xm_ir_out[26:0]} : dx_b_out;
    assign alu_in_b = isImmed_X ? immed : immed_mux_in;
    
    // ALU declaration
    assign alu_op_code = isB_Type_X ? 5'b00001 : isImmed_X ? 5'b00000 : dx_ir_out[6:2];
    alu alu(alu_in_a, alu_in_b, alu_op_code, dx_ir_out[11:7], alu_out, alu_neq, alu_lt, alu_ovf);

    // Exception control
    assign isAddEx = alu_ovf && x_decode[0] && ~dx_ir_out[6]&&~dx_ir_out[5]&&~dx_ir_out[4]&&~dx_ir_out[3]&&~dx_ir_out[2] && (dx_ir_out!=0);
    assign isAddiEx = alu_ovf && x_decode[5];
    assign isSubEx = alu_ovf && x_decode[0] && ~dx_ir_out[6]&&~dx_ir_out[5]&&~dx_ir_out[4]&&~dx_ir_out[3]&&dx_ir_out[2];

    // XM latch inputs
    assign xm_ir_in = isAddEx ? {5'b10101, 26'b0, 1'b1} : isAddiEx ? {5'b10101, 25'b0, 2'b10} : isSubEx ? {5'b10101, 25'b0, 2'b11} : dx_ir_out;

    // Multdiv Handling
    multdiv md(alu_in_a, alu_in_b, isMult, isDiv, clock, isMD, md_p_out, md_ex_out, md_data_ready_out);
    pw_latch pw(pw_p_out, pw_ir_out, pw_data_ready_out, pw_ex_out, nClock, pw_enable, pw_ir_enable, pw_data_ready_out, md_p_out, dx_ir_out, md_data_ready_out, md_ex_out);
    
    // MEMORY STAGE
    decoder32 mdecode(m_decode, xm_ir_out[31:27], 1'b1);
    assign address_dmem = xm_o_out;
    assign data = ctrl_mem_d ? data_writeReg : xm_b_out;
    assign wren = m_decode[7];

    // WRITE STAGE
    decoder32 wdecode(w_decode, mw_ir_out[31:27], 1'b1);

    // MultDiv exception control
    assign isMultEx = ~pw_ir_out[2]&&pw_ex_out;
    assign isDivEx = pw_ir_out[2]&&pw_ex_out;

    // Writeback assingments 
    assign ctrl_writeEnable = w_decode[0]||w_decode[3]||w_decode[5]||w_decode[8]||w_decode[21];
    assign ctrl_writeReg = (w_decode[21] || pw_ex_out) ? 5'b11110 : pw_data_ready_out ? pw_ir_out[26:22] : w_decode[3] ? 5'b11111 : mw_ir_out[26:22];
    assign data_writeReg = isMultEx ? {29'b0, 3'b100} : isDivEx ? {29'b0, 3'b101} : pw_data_ready_out ? pw_p_out : w_decode[21] ? {5'b0, mw_ir_out[26:0]} : w_decode[3] ? mw_pc_out : w_decode[8] ? mw_d_out : mw_o_out;

endmodule

