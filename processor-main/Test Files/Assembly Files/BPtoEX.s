nop             # Values initialized using addi (positive only)
nop             # Author: Oliver Rodas
nop
nop
nop             # Exception Bypassing
addi $r1, $r0, 32767    # r1 = 32767
sll $r1, $r1, 16        # r1 = 2147418112
addi $r1, $r1, 65535    # r1 = 2147483647 (Max positive integer)
addi $r2, $r0, 2        # r2 = 2
addi $r3, $r0, 1        # r3 = 1
add $r5, $r1, $r3        # add ovfl --> rstatus = 1
add $r4, $r2, $r30        # r4 = r2 + rstatus = 3    (X->D)
