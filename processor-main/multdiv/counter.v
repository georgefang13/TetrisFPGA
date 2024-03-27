module counter(Q, clk, en, clr);

    // Declare inputs:
    input clk, en, clr;

    // Declare outputs:
    output [5:0] Q;

    // Declare wires: 
    wire w01, w012, w0123, w01234;


    // And each previous TFF to create the input for the next
    and and01(w01, Q[0], Q[1]);
    and and012(w012, w01, Q[2]);
    and and0123(w0123, w012, Q[3]);
    and and01234(w01234, w0123, Q[4]);

    // Declare each TFF
    custom_tff t0(Q[0], en, clk, clr);
    custom_tff t1(Q[1], Q[0], clk, clr);
    custom_tff t2(Q[2], w01, clk, clr);
    custom_tff t3(Q[3], w012, clk, clr);
    custom_tff t4(Q[4], w0123, clk, clr);
    custom_tff t5(Q[5], w01234, clk, clr);

endmodule