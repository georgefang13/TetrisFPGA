nop 			    # Simple bex and setx test case without bypassing
nop                 # Author: Unknown, Modified by Will Denton
nop 
nop
nop
setx 0			    # r30 = 0
nop			        # Avoid setx RAW hazard
nop			        # Avoid setx RAW hazard
nop                 # Avoid setx RAW hazard
bex e1			    # r30 == 0 --> not taken
nop			        # nop in case of flush
nop			        # nop in case of flush
nop			        # Spacer
addi $r10, $r10, 1	# r10 += 1 (Correct)
e1: nop			    # Landing pad for branch
setx 10			    # r30 = 10
nop			        # Avoid setx RAW hazard
nop			        # Avoid setx RAW hazard
nop
bex e2			    # r30 != 0 --> taken
nop			        # flushed instruction
nop			        # flushed instruction
addi $r20, $r20, 1	# r20 += 1 (Incorrect)
addi $r21, $r21, 1	# r21 += 1 (Incorrect)
addi $r22, $r22, 1	# r22 += 1 (Incorrect)
e2:                 # correct branch
addi $r10, $r10, 1	# r10 += 1 (Correct)
nop			        # Avoid add RAW hazard
nop			        # Avoid add RAW hazard
nop
# Final: $r10 should be 2, $r20, $r21, $r22 should be 0