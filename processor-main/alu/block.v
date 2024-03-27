module block(S, G, P, x, y, c0);

    input [7:0] x, y;
    input c0;

    output [7:0] S;
    output G, P;

    wire g0, p0, g1, p1, g2, p2, g3, p3, g4, p4, g5, p5, g6, p6, g7, p7, 
         p0c0, 
         p1g0, p10c0, 
         p2g1, p21g0, p210c0,
         p3g2, p32g1, p321g0, p3210c0,
         p4g3, p43g2, p432g1, p4321g0, p43210c0,
         p5g4, p54g3, p543g2, p5432g1, p54321g0, p543210c0,
         p6g5, p65g4, p654g3, p6543g2, p65432g1, p654321g0, p6543210c0,
         p7g6, p76g5, p765g4, p7654g3, p76543g2, p765432g1, p7654321g0, 
         c1, c2, c3, c4, c5, c6, c7;

    // Each p and g term
    and gt_g0(g0, x[0], y[0]);
    or  gt_p0(p0, x[0], y[0]);
    and gt_g1(g1, x[1], y[1]);
    or  gt_p1(p1, x[1], y[1]);
    and gt_g2(g2, x[2], y[2]);
    or  gt_p2(p2, x[2], y[2]);
    and gt_g3(g3, x[3], y[3]);
    or  gt_p3(p3, x[3], y[3]);
    and gt_g4(g4, x[4], y[4]);
    or  gt_p4(p4, x[4], y[4]);
    and gt_g5(g5, x[5], y[5]);
    or  gt_p5(p5, x[5], y[5]);
    and gt_g6(g6, x[6], y[6]);
    or  gt_p6(p6, x[6], y[6]);
    and gt_g7(g7, x[7], y[7]);
    or  gt_p7(p7, x[7], y[7]);

    // Calculating c1:
    and gt_p0c0(p0c0, p0, c0);
    or  gt_c1(c1, g0, p0c0);

    // Calculating c2:
    and gt_p1g0(p1g0, p1, g0);
    and gt_p10c0(p10c0, p1, p0c0);
    or  gt_c2(c2, g1, p1g0, p10c0);

    // Calculating c3:
    and gt_p2g1(p2g1, p2, g1);
    and gt_p21g0(p21g0, p2, p1g0);
    and gt_p210c0(p210c0, p2, p10c0);
    or  gt_c3(c3, g2, p2g1, p21g0, p210c0);

    // Calculating c4:
    and gt_p3g2(p3g2, p3, g2);
    and gt_p32g1(p32g1, p3, p2g1);
    and gt_p321g0(p321g0, p3, p21g0);
    and gt_p3210c0(p3210c0, p3, p210c0);
    or  gt_c4(c4, g3, p3g2, p32g1, p321g0, p3210c0);

    // Calculating c5:
    and gt_p4g3(p4g3, p4, g3);
    and gt_p43g2(p43g2, p4, p3g2);
    and gt_p432g1(p432g1, p4, p32g1);
    and gt_p4321g0(p4321g0, p4, p321g0);
    and gt_p43210c0(p43210c0, p4, p3210c0);
    or gt_c5(c5, g4, p4g3, p43g2, p432g1, p4321g0, p43210c0);

    // Calculating c6:
    and gt_p5g4(p5g4, p5, g4);
    and gt_p54g3(p54g3, p5, p4g3);
    and gt_p543g2(p543g2, p5, p43g2);
    and gt_p5432g1(p5432g1, p5, p432g1);
    and gt_p54321g0(p54321g0, p5, p4321g0);
    and gt_p543210c0(p543210c0, p5, p43210c0);
    or gt_c6(c6, g5, p5g4, p54g3, p543g2, p5432g1, p54321g0, p543210c0);

    // Calculating c7:
    and gt_p6g5(p6g5, p6, g5);
    and gt_p65g4(p65g4, p6, p5g4);
    and gt_p654g3(p654g3, p6, p54g3);
    and gt_p6543g2(p6543g2, p6, p543g2);
    and gt_p65432g1(p65432g1, p6, p5432g1);
    and gt_p654321g0(p654321g0, p6, p54321g0);
    and gt_p6543210c0(p6543210c0, p6, p543210c0);
    or gt_c7(c7, g6, p6g5, p65g4, p654g3, p6543g2, p65432g1, p654321g0, p6543210c0);

    // Calculating G:
    and gt_p7g6(p7g6, p7, g6);
    and gt_p76g5(p76g5, p7, p6g5);
    and gt_p765g4(p765g4, p7, p65g4);
    and gt_p7654g3(p7654g3, p7, p654g3);
    and gt_p76543g2(p76543g2, p7, p6543g2);
    and gt_p765432g1(p765432g1, p7, p65432g1);
    and gt_p7654321g0(p7654321g0, p7, p654321g0);
    or gt_G(G, g7, p7g6, p76g5, p765g4, p7654g3, p76543g2, p765432g1, p7654321g0);

    // Calculating P:
    and gt_P(P, p7, p6, p5, p4, p3, p2, p1, p0);

    // Calculating S[7:0]
    xor s0(S[0], x[0], y[0], c0);
    xor s1(S[1], x[1], y[1], c1);
    xor s2(S[2], x[2], y[2], c2);
    xor s3(S[3], x[3], y[3], c3);
    xor s4(S[4], x[4], y[4], c4);
    xor s5(S[5], x[5], y[5], c5);
    xor s6(S[6], x[6], y[6], c6);
    xor s7(S[7], x[7], y[7], c7);


endmodule