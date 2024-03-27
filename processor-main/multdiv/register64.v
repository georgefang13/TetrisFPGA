module register64(clk, in_enable, ctrl_reset, data_in, data_out);

    // Inputs:
    input clk, ctrl_reset, in_enable;
    input [63:0] data_in;

    // Outputs:
    output [63:0] data_out;

    // Generate 64 d-flip flops
    genvar i;
    generate
        for (i = 0; i < 64; i = i+1) begin: dff_loop
            custom_dff dff(.q(data_out[i]), .d(data_in[i]), .clk(clk), .en(in_enable), .clr(ctrl_reset));
        end
    endgenerate


endmodule 