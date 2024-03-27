nop             # Values initialized using addi (positive only)
nop             # Author: Oliver Rodas
nop
nop             # Multdiv without Bypassing
nop 			# Multdiv Tests
addi $1, $0, 3	# r1 = 3
addi $2, $0, 21	# r2 = 21
nop
nop
mul $19, $2, $1	# r19 = r2 * r1 = 63
