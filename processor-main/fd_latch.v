module fd_latch(pc_out, ir_out, clock, enable, reset, pc_in, ir_in);
    // Inputs
    input[31:0] pc_in, ir_in;
    input clock, enable, reset;

    // Outputs
    output[31:0] pc_out, ir_out;

    // Registers for each value needed to store
    register pc(clock, enable, reset, pc_in, pc_out);
    register ir(clock, enable, reset, ir_in, ir_out);

endmodule