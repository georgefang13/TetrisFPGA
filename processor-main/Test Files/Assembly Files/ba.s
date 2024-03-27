nop 			# Basic Arithmetic Test with no Hazards
nop 			# Values initialized using addi (positive only) and sub
nop 			# Author: Oliver Rodas
nop
nop
nop 			# Initialize Values
addi $3, $0, 1	# r3 = 1
addi $4, $0, 35	# r4 = 35
addi $1, $0, 3	# r1 = 3
addi $2, $0, 21	# r2 = 21
sub $3, $0, $3	# r3 = -1
sub $4, $0, $4	# r4 = -35
nop 
nop 			# Positive Value Tests
add $5, $2, $1	# r5 = r2 + r1 = 24
sub $6, $2, $1	# r6 = r2 - r1 = 18
and $7, $2, $1	# r7 = r2 & r1 = 1
or $8, $2, $1 	# r8 = r2 | r1 = 23
sll $9, $1, 4 	# r9 = r1 << 4 = 48
sra $10, $2, 2	# r10 = r2 >> 2 = 5