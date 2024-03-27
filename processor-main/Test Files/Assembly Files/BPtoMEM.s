nop             # Values initialized using addi (positive only)
nop             # Author: Oliver Rodas
nop
nop
nop             # Bypassing from lw to sw (M->X)
addi $1, $0, 830        # r1 = 830
nop            # Avoid RAW hazard to test only lw/sw
nop            # Avoid RAW hazard to test only lw/sw
sw $1, 2($0)         # mem[2] = r1 = 830
nop            # Avoid RAW hazard to test only lw/sw
nop            # Avoid RAW hazard to test only lw/sw
lw $2, 2($0)         # r2 = mem[2] = 830
sw $2, 3($0)         # mem[3] = r2 = 830        (M->X)
lw $3, 3($0)         # r3 = mem[3] = 830
 