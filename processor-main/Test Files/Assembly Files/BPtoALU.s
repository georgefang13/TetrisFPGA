nop             # Values initialized using addi (positive only)
nop             # Author: Oliver Rodas
nop
nop
nop             # Basic Bypassing to ALU: X->D and M->D
addi $r1, $r0, 80        # r1 = 80
addi $r2, $r1, 22        # r2 = r1 + 22 = 102    (X->D)
addi $r3, $r1, 37        # r3 = r1 + 37 = 117    (M->D)
sub $r4, $r1, $r3        # r4 = r1 - r3 = -37    (X->D)
and $r5, $r1, $r3        # r5 = r1 & r3 = 80    (M->D)
sra $r6, $r4, 4         # r6 = r4 >> 4 = -3        (M->D)
sll $r7, $r6, 5         # r7 = r6 << 5 = -96    (X->D)