nop 	# simple jr test case
nop 
nop 
nop
nop
nop
addi    $r1, $r0, 4     # $r1 = 4
addi    $r2, $r0, 5     # $r2 = 5
nop
nop
sub     $r3, $r0, $r1   # $r3 = -4
sub     $r4, $r0, $r2   # $r4 = -5
nop
nop
nop 	
addi	$r31, $r0, 20	# $r31 = 20
jr	$r31		# go to j2
addi 	$r20, $r20, 1	# r20 += 1 (Incorrect)
addi 	$r20, $r20, 1	# r20 += 1 (Incorrect)
addi 	$r20, $r20, 1	# r20 += 1 (Incorrect)
j2:
addi	$r10, $r10, 1	# r10 += 1 (Correct)
nop
nop
nop
nop
# Final: $r10 should be 1, $r20 should be 0
