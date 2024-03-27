module dx_latch(pc_out, a_out, b_out, ir_out, clock, enable, reset, pc_in, a_in, b_in, ir_in);
    // Inputs
    input[31:0] pc_in, a_in, b_in, ir_in;
    input clock, enable, reset;

    // Outputs
    output[31:0] pc_out, a_out, b_out, ir_out;

    // Registers for each value needed to store
    register pc(clock, enable, reset, pc_in, pc_out);
    register a(clock, enable, reset, a_in, a_out);
    register b(clock, enable, reset, b_in, b_out);
    register ir(clock, 1'b1, reset, ir_in, ir_out);

endmodule