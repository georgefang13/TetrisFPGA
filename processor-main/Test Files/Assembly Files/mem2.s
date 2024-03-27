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
nop 			# Load/Store Tests
sw $1, 1($0) 		# mem[1] = r1 = 3
sw $2, 2($0) 		# mem[2] = r2 = 21
sw $3, 0($1) 		# mem[r1] = r3 = -1 (should be mem[3])
lw $16, 1($0) 	# r16 = mem[1] = 3
lw $17, 2($0) 	# r17 = mem[2] = 21
lw $18, 0($1) 	# r18 = mem[3] = -1