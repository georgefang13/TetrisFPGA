module custom_tff(q, t, clk, clr);

    // Inputs:
    input t, clk, clr;

    // Outputs:
    output q;

    // Wires:
    wire wTnQ, wnTQ, wD;

    // Basic TFF implementation from lecture
    and and1(wTnQ, t, ~q);
    and and2(wnTQ, ~t, q);
    or or1(wD, wTnQ, wnTQ);
    custom_dff dff(q, wD, clk, 1'b1, clr);

endmodule