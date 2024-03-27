nop
nop 	
nop
nop	
nop
addi $r4, $r0, 1		# r4 = 1
nop				# Avoid RAW hazard
bne $r4, $r0, rgood		# Branch racing (should branch)
j rbad				# Jump racing (should not jump)
nop				# Spacer
nop				# Spacer
nop				# Spacer
nop				# Spacer
rbad: nop			# Landing pad for jump
addi $r20, $r20, 1		# r20 += 1 (Incorrect)
addi $r20, $r20, 1		# r20 += 1 (Incorrect)
j end2				# Jump to test cleanup
nop				# Spacer
rgood: nop			# Landing pad for branch
addi $r10, $r10, 1		# r10 += 1 (Correct)
addi $r10, $r10, 1		# r10 += 1 (Correct)
end2: nop			# Landing pad for jump
nop				
nop
nop
nop
nop
# Final: $r10 should be 2, $r20 should be 0