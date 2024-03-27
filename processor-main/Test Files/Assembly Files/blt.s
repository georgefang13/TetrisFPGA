nop 	                # Simple blt test case without bypassing
nop                     # Author: Unknown, Modified by Will Denton
nop 
nop
nop
nop                     # Setup
addi    $r1, $r0, 4     # $r1 = 4
addi    $r2, $r0, 5     # $r2 = 5
nop
sub     $r3, $r0, $r1   # $r3 = -4
sub     $r4, $r0, $r2   # $r4 = -5
nop
nop
nop 	
blt 	$r1, $r2, b3	# r1 < r2 --> taken
nop			            # flushed instruction
nop			            # flushed instruction
addi 	$r20, $r20, 1	# r20 += 1 (Incorrect) #20, 21, and 22 determine which ins was jumped incorrectly to
addi 	$r21, $r21, 1	# r20 += 1 (Incorrect)
addi 	$r22, $r22, 1	# r20 += 1 (Incorrect)
b3: 
addi $r10, $r10, 1	    # r10 += 1 (Correct)
blt $r2, $r2, b4	    # r2 == r2 --> not taken
nop			            # nop in case of flush
nop			            # nop in case of flush
nop			            # Spacer 
addi $r10, $r10, 1	    # r10 += 1 (Correct) 
b4: 			        # Landing pad for branch
nop			
blt $r4, $r1, b5	    # r4 < r1 --> taken
nop			            # flushed instruction
nop			            # flushed instruction
addi $r20, $r20, 1	    # r20 += 1 (Incorrect)
addi $r21, $r21, 1	    # r21 += 1 (Incorrect)
addi $r22, $r22, 1	    # r22 += 1 (Incorrect)
b5: 
addi $r10, $r10, 1	    # r10 += 1 (Correct)
blt $r2, $r1, b6	    # r2 > r1 --> not taken
nop			            # nop in case of flush
nop			            # nop in case of flush
nop			            # Spacer
addi $r10, $r10, 1	    # r10 += 1 (Correct) 
b6: 
nop			
blt $r4, $r3, b7	    # r4 < r3 --> taken
nop			            # flushed instruction
nop			            # flushed instruction
addi $r20, $r20, 1	    # r20 += 1 (Incorrect)
addi $r21, $r21, 1	    # r21 += 1 (Incorrect)
addi $r22, $r22, 1	    # r22 += 1 (Incorrect)
b7: 
addi $r10, $r10, 1	    # r10 += 1 (Correct)
blt $r3, $r4, b8	    # r3 > r4 --> not taken
nop			            # nop in case of flush
nop			            # nop in case of flush
nop			            # Spacer
addi $r10, $r10, 1	    # r10 += 1 (Correct) 
b8: 
nop			            # Landing pad for branch
nop			            # Avoid add RAW hazard
nop			
# Final: $r10 should be 6, $r20, $r21, and $r22 should be 0
