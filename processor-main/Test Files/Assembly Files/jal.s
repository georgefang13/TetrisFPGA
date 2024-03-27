nop 	                    # Simple jal test case
nop                         # Author: Unknown, Modified by Will Denton
nop 
nop 
nop
nop
addi    $r1, $r0, 4         # $r1 = 4
addi    $r2, $r0, 5         # $r2 = 5
nop
nop
sub     $r3, $r0, $r1       # $r3 = -4
sub     $r4, $r0, $r2       # $r4 = -5
nop
nop
nop 	
addi	$r31, $r0, 100	    # $r31 = 100
nop                         # Avoid bypassing
nop
nop
jal 	j2		            # jump to j2, $r31 = PC + 1 = 20
nop			                # flushed instruction
nop			                # flushed instruction
addi 	$r20, $r20, 1	    # r20 += 1 (Incorrect)
addi 	$r21, $r21, 1	    # r21 += 1 (Incorrect)
addi 	$r22, $r22, 1	    # r22 += 1 (Incorrect)
j2:
addi	$r10, $r10, 1	    # r10 += 1 (Correct)
nop
nop
nop
nop