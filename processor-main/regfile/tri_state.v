module tri_state(in, oe, out);

    // Inputs:
    input [31:0] in;
    input oe;

    // Outpouts:
    output [31:0] out;

    // Use 2 option mux to tristate
    assign out = oe ? in : 32'bz;

endmodule