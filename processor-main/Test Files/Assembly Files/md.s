nop             # Values initialized using addi (positive only)
nop             # Author: Oliver Rodas
nop
nop             # Multdiv without Bypassing
nop 			# Multdiv Tests
addi $3, $0, 1	# r3 = 1
addi $4, $0, 35	# r4 = 35
addi $1, $0, 3	# r1 = 3
addi $2, $0, 21	# r2 = 21
sub $3, $0, $3	# r3 = -1
sub $4, $0, $4	# r4 = -35
nop
nop
mul $19, $2, $1	# r19 = r2 * r1 = 63
div $20, $2, $1	# r20 = r2 / r1 = 7
mul $21, $3, $1	# r21 = r3 * r1 = -3
div $22, $4, $1	# r22 = r4 / r1 = -11
