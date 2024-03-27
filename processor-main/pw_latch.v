module pw_latch(p_out, ir_out, data_ready_out, ex_out, clock, enable, ir_enable, reset, p_in, ir_in, data_ready_in, ex_in);
    // Inputs
    input[31:0] p_in, ir_in;
    input clock, enable, ir_enable, reset, data_ready_in, ex_in;

    // Outputs
    output[31:0] p_out, ir_out;
    output data_ready_out, ex_out;

    wire reset_offset;
    
    register ir(clock, ir_enable, reset_offset, ir_in, ir_out);
    custom_dff r(reset_offset, reset, ~clock, 1'b1, 1'b0);
    register p(clock, enable, reset_offset, p_in, p_out);
    custom_dff data_ready(data_ready_out, data_ready_in, clock, enable, reset_offset);
    custom_dff ex(ex_out, ex_in, clock, enable, reset_offset);

endmodule