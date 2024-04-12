# Tetris!




# set drop frequency:
addi $r26, $r0, 12207
sll $r26, $r26, 10  # build ~50,000,000




# set stack pointer:
addi $r29, $r0, 225




nop




start_game:
# get 5 random numbers and store them
add $r1, $r28, $r0
sw $r1, 218($r0)
add $r2, $r28, $r0
sw $r2, 219($r0)
add $r3, $r28, $r0
sw $r3, 220($r0)
add $r4, $r28, $r0
sw $r4, 221($r0)
add $r5, $r28, $r0
sw $r5, 222($r0)




place_block:
# Get next piece
lw $r1, 218($r0)




# shift up next blocks and get new random block
lw $r2, 219($r0)
sw $r2, 218($r0)




lw $r3, 220($r0)
sw $r3, 219($r0)




lw $r4, 221($r0)
sw $r4, 220($r0)




lw $r5, 222($r0)
sw $r5, 221($r0)




add $r5, $r28, $r0
sw $r5, 222($r0)




# Store rotation
addi $r2, $r0, 1
sw $r2, 201($r0)




# decode which block to place
addi $r6, $r0, 7
blt $r1, $r6, lt7
nop
nop
nop


#place J block
#store type
sw $r1, 200($r0) # type
# locaitons of each block
addi $r2, $r0, 3
sw $r2, 202($r0)
addi $r2, $r2, 10
sw $r2, 203($r0)
addi $r2, $r2, 1
sw $r2, 204($r0)
addi $r2, $r2, 1
sw $r2, 205($r0)
j decode_done




lt7:
addi $r6, $r0, 6
blt $r1, $r6, lt6
nop
nop
nop


#place L block
#store type
sw $r1, 200($r0) # type
# locaitons of each block
addi $r2, $r0, 5
sw $r2, 202($r0)
addi $r2, $r0, 13
sw $r2, 203($r0)
addi $r2, $r2, 1
sw $r2, 204($r0)
addi $r2, $r2, 1
sw $r2, 205($r0)
j decode_done




lt6:
addi $r6, $r0, 5
blt $r1, $r6, lt5
nop
nop
nop


#place T block
#store type
sw $r1, 200($r0) # type
# locaitons of each block
addi $r2, $r0, 4
sw $r2, 202($r0)
addi $r2, $r0, 13
sw $r2, 203($r0)
addi $r2, $r2, 1
sw $r2, 204($r0)
addi $r2, $r2, 1
sw $r2, 205($r0)
j decode_done




lt5:
addi $r6, $r0, 4
blt $r1, $r6, lt4
nop
nop
nop


#place Z block
#store type
sw $r1, 200($r0) # type
# locaitons of each block
addi $r2, $r0, 3
sw $r2, 202($r0)
addi $r2, $r2, 1
sw $r2, 203($r0)
addi $r2, $r2, 10
sw $r2, 204($r0)
addi $r2, $r2, 1
sw $r2, 205($r0)
j decode_done




lt4:
addi $r6, $r0, 3
blt $r1, $r6, lt3
nop
nop
nop


#place S block
#store type
sw $r1, 200($r0) # type
# locaitons of each block
addi $r2, $r0, 4
sw $r2, 202($r0)
addi $r2, $r2, 1
sw $r2, 203($r0)
addi $r2, $r0, 13
sw $r2, 204($r0)
addi $r2, $r2, 1
sw $r2, 205($r0)
j decode_done




lt3:
addi $r6, $r0, 2
blt $r1, $r6, lt2
nop
nop
nop




#place O block
#store type
sw $r1, 200($r0) # type
# locaitons of each block
addi $r2, $r0, 4
sw $r2, 202($r0)
addi $r2, $r2, 1
sw $r2, 203($r0)
addi $r2, $r0, 14
sw $r2, 204($r0)
addi $r2, $r2, 1
sw $r2, 205($r0)
j decode_done




lt2:




#place I block
#store type
addi $r1, $r0, 1
sw $r1, 200($r0) # type
# locaitons of each block
addi $r2, $r0, 3
sw $r2, 202($r0)
addi $r2, $r2, 1
sw $r2, 203($r0)
addi $r2, $r2, 1
sw $r2, 204($r0)
addi $r2, $r2, 1
sw $r2, 205($r0)




decode_done:




# render out the blocks
lw $r1, 200($r0) # type
addi $r1, $r1, 8 # make active
lw $r2, 202($r0)
sw $r1, 0($r2)
lw $r3, 203($r0)
sw $r1, 0($r3)
lw $r4, 204($r0)
sw $r1, 0($r4)
lw $r5, 205($r0)
sw $r1, 0($r5)


delay:




addi $r25, $r0, 0




wait:
addi $r25, $r25, 1
blt $r25, $r26, wait




fall:




# calculate next block position and store in next state
lw $r2, 202($r0)
addi $r2, $r2, 10
sw $r2, 208($r0)




lw $r3, 203($r0)
addi $r3, $r3, 10
sw $r3, 209($r0)




lw $r4, 204($r0)
addi $r4, $r4, 10
sw $r4, 210($r0)




lw $r5, 205($r0)
addi $r5, $r5, 10
sw $r5, 211($r0)




#check for collisions:




#load game board slots
lw $r12, 0($r2)
lw $r13, 0($r3)
lw $r14, 0($r4)
lw $r15, 0($r5)




# check to see if colliding with any non-active pieces
addi $r8, $r0, 8
blt $r12, $r8, empty_check1
fall_check2:
blt $r13, $r8, empty_check2
fall_check3:
blt $r14, $r8, empty_check3
fall_check4:
blt $r15, $r8, empty_check4


# check to see if colliding with out of bounds
bottom_check:
addi $r8, $r0, 199
blt $r8, $r2, fall_fail
blt $r8, $r3, fall_fail
blt $r8, $r4, fall_fail
blt $r8, $r5, fall_fail


j render_ns


empty_check1:
bne $r12, $r0, fall_fail
j fall_check2


empty_check2:
bne $r13, $r0, fall_fail
j fall_check3


empty_check3:
bne $r14, $r0, fall_fail
j fall_check4


empty_check4:
bne $r15, $r0, fall_fail
j bottom_check


fall_fail:
# load type
lw $r1, 200($r0)
# grab current state location
lw $r2, 202($r0)
# store non-active state
sw $r1, 0($r2)
lw $r3, 203($r0)
sw $r1, 0($r3)
lw $r4, 204($r0)
sw $r1, 0($r4)
lw $r5, 205($r0)
sw $r1, 0($r5)




j place_block




render_ns:




# load type and make active
lw $r1, 200($r0)
addi $r1, $r1, 8


# grab current and next state
lw $r2, 205($r0)
lw $r3, 211($r0)
# store next in current
sw $r3, 205($r0)
# clear current state
sw $r0, 0($r2)
# store active state
sw $r1, 0($r3)


lw $r2, 204($r0)
lw $r3, 210($r0)
sw $r3, 204($r0)
sw $r0, 0($r2)
sw $r1, 0($r3)


lw $r2, 203($r0)
lw $r3, 209($r0)
sw $r3, 203($r0)
sw $r0, 0($r2)
sw $r1, 0($r3)


lw $r2, 202($r0)
lw $r3, 208($r0)
sw $r3, 202($r0)
sw $r0, 0($r2)
sw $r1, 0($r3)




j delay




die:
nop
nop
nop
nop
nop
nop
nop
nop
j die




























