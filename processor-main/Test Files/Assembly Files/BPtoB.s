				# Efficiency Test 3: Bypassing into Branch (with loops)
nop
nop 	
nop
nop	
nop
addi $r1, $r0, 5		# r1 = 5
b1: addi $r2, $r2, 1		# r2 += 1
blt $r2, $r1, b1		# if r2 < r1 take branch (5 times)
b2: addi $r1, $r1, 1		# r1 += 1
addi $r3, $r3, 2		# r3 += 2
blt $r3, $r1, b2		# if r3 < r1 take branch (4 times)
add $r10, $r2, $r3		# r10 = r2 + r3
nop
nop
nop
nop
# Final: $r10 should be 15