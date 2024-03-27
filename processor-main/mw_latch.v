module mw_latch(pc_out, o_out, d_out, ir_out, clock, enable, reset, pc_in, o_in, d_in, ir_in);
    // Inputs
    input[31:0] pc_in, o_in, d_in, ir_in;
    input clock, enable, reset;

    // Outputs
    output[31:0] pc_out, o_out, d_out, ir_out;

    // Registers for each value needed to store
    register pc(clock, enable, reset, pc_in, pc_out);
    register o(clock, enable, reset, o_in, o_out);
    register d(clock, enable, reset, d_in, d_out);
    register ir(clock, enable, reset, ir_in, ir_out);

endmodule