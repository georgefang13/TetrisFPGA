# store example block:
addi $r1, $0, 1
sw $r1, 3($0)
sw $r1, 4($0)
sw $r1, 5($0)
sw $r1, 6($0)

lw $r2, 3($0)
lw $r3, 4($0)
lw $r4, 5($0)
lw $r5, 5($0)


