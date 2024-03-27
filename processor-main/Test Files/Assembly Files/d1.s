nop             # Values initialized using addi (positive only)
nop             # Author: Oliver Rodas
nop
nop             # Multdiv without Bypassing
nop 			# Multdiv Tests
addi $1, $0, 3	# r1 = 3
addi $2, $0, 21	# r2 = 21
nop
nop
div $20, $2, $1	# r20 = r2 / r1 = 7
