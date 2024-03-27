nop
nop 	
nop
nop	
nop
addi $r31, $r0, 9		# r31 = 12
nop				# Avoid RAW hazard for jr
addi $r31, $r0, 13		# r31 = 13 (with RAW hazard)
jr $r31 				# PC = r31 = 16
addi $r20, $r20, 1		# r20 += 1 (Incorrect)
addi $r20, $r20, 1		# r20 += 1 (Incorrect)
addi $r20, $r20, 1		# r20 += 1 (Incorrect)
addi $r20, $r20, 1		# r20 += 1 (Incorrect)
addi $r10, $r10, 1		# r10 += 1 (Correct)
nop
nop
nop
nop
# Final: $r10 should be 1, $r20 should be 0