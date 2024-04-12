# Tetris!

# set drop frequency:
addi $r26, $r0, 1220
sll $r26, $r26, 10  # build ~50,000,000

# set stack pointer:
addi $r29, $r0, 225

# wait for start/reset
addi $r2, $r0, 10
check_start:
add $r1, $r27, $r0
nop
nop
nop
bne $r1, $r2, check_start

start_game:

#clear the board:
addi $r5, $r0, 0
addi $r6, $r0, 200

clear:
sw $r0, 0($r5)
addi $r5, $r5, 1
blt $r5, $r6, clear

# get 5 random numbers and store them
add $r1, $r28, $r0
sw $r1, 218($r0)
nop  # allow for more random generation
nop 
add $r2, $r28, $r0
sw $r2, 219($r0)
nop
nop
add $r3, $r28, $r0
sw $r3, 220($r0)
nop
nop
add $r4, $r28, $r0
sw $r4, 221($r0)
nop
nop
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

addi $r20, $r0, 0

wait:
addi $r20, $r20, 1
blt $r20, $r26, wait

update_game:

addi $r25, $r25, 1
addi $r10, $r0, 10
bne $r10, $r25, not_fall
add $r25, $r0, $r0
j fall

not_fall:

add $r1, $r27, $r0

addi $r2, $r0, 10
bne $r1, $r2, not_reset
j start_game

not_reset:
addi $r2, $r0, 4
bne $r1, $r2, not_left
j move_left

not_left:
addi $r2, $r0, 3
bne $r1, $r2, not_down
j fall

not_down:

addi $r2, $r0, 2
bne $r1, $r2, not_right
j move_right

not_right:

j delay


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
lw $r2, 202($r0)
lw $r3, 203($r0)
lw $r4, 204($r0)
lw $r5, 205($r0)
lw $r12, 208($r0)
lw $r13, 209($r0)
lw $r14, 210($r0)
lw $r15, 211($r0)
# store next in current
sw $r12, 202($r0)
sw $r13, 203($r0)
sw $r14, 204($r0)
sw $r15, 205($r0)
# clear current state
sw $r0, 0($r2)
sw $r0, 0($r3)
sw $r0, 0($r4)
sw $r0, 0($r5)
# store active state
sw $r1, 0($r12)
sw $r1, 0($r13)
sw $r1, 0($r14)
sw $r1, 0($r15)

j delay

move_left:
addi $r5, $r0, 191
addi $r4, $r0, -10
lw $r1, 202($r0)
left_check1:
addi $r4, $r4, 10
blt $r5, $r4, left_check2_setup
bne $r4, $r1, left_check1
j delay

left_check2_setup:
addi $r5, $r0, 191
addi $r4, $r0, -10
lw $r1, 203($r0)
left_check2:
addi $r4, $r4, 10
blt $r5, $r4, left_check3_setup
bne $r4, $r1, left_check2
j delay

left_check3_setup:
addi $r5, $r0, 191
addi $r4, $r0, -10
lw $r1, 204($r0)
left_check3:
addi $r4, $r4, 10
blt $r5, $r4, left_check4_setup
bne $r4, $r1, left_check3
j delay

left_check4_setup:
addi $r5, $r0, 191
addi $r4, $r0, -10
lw $r1, 205($r0)
left_check4:
addi $r4, $r4, 10
blt $r5, $r4, set_left
bne $r4, $r1, left_check4
j delay

set_left:
lw $r2, 202($r0)
lw $r3, 203($r0)
lw $r4, 204($r0)
lw $r5, 205($r0)

addi $r2, $r2, -1
addi $r3, $r3, -1
addi $r4, $r4, -1
addi $r5, $r5, -1

sw $r2, 208($r0)
sw $r3, 209($r0)
sw $r4, 210($r0)
sw $r5, 211($r0)

j collide_detect

move_right:
addi $r5, $r0, 200
addi $r4, $r0, -1
lw $r1, 202($r0)
right_check1:
addi $r4, $r4, 10
blt $r5, $r4, right_check2_setup
bne $r4, $r1, right_check1
j delay

right_check2_setup:
addi $r5, $r0, 200
addi $r4, $r0, -1
lw $r1, 203($r0)
right_check2:
addi $r4, $r4, 10
blt $r5, $r4, right_check3_setup
bne $r4, $r1, right_check2
j delay

right_check3_setup:
addi $r5, $r0, 200
addi $r4, $r0, -1
lw $r1, 204($r0)
right_check3:
addi $r4, $r4, 10
blt $r5, $r4, right_check4_setup
bne $r4, $r1, right_check3
j delay

right_check4_setup:
addi $r5, $r0, 200
addi $r4, $r0, -1
lw $r1, 205($r0)
right_check4:
addi $r4, $r4, 10
blt $r5, $r4, set_right
bne $r4, $r1, right_check4
j delay

set_right:
lw $r1, 200($r0)
lw $r2, 202($r0)
lw $r3, 203($r0)
lw $r4, 204($r0)
lw $r5, 205($r0)

addi $r2, $r2, 1
addi $r3, $r3, 1
addi $r4, $r4, 1
addi $r5, $r5, 1

sw $r1, 206($r0)
sw $r2, 208($r0)
sw $r3, 209($r0)
sw $r4, 210($r0)
sw $r5, 211($r0)

j collide_detect

collide_detect:

# load next state
lw $r2, 208($r0)
lw $r3, 209($r0)
lw $r4, 210($r0)
lw $r5, 211($r0)
#check for collisions:

#load game board slots
lw $r12, 0($r2)
lw $r13, 0($r3)
lw $r14, 0($r4)
lw $r15, 0($r5)

# check to see if colliding with any non-active pieces
addi $r8, $r0, 8
blt $r12, $r8, gen_empty_check1
gen_fall_check2:
blt $r13, $r8, gen_empty_check2
gen_fall_check3:
blt $r14, $r8, gen_empty_check3
gen_fall_check4:
blt $r15, $r8, gen_empty_check4

# check to see if colliding with out of bounds
gen_bottom_check:
addi $r8, $r0, 199
blt $r8, $r2, delay
blt $r8, $r3, delay
blt $r8, $r4, delay
blt $r8, $r5, delay

j render_ns

gen_empty_check1:
bne $r12, $r0, delay
j gen_fall_check2

gen_empty_check2:
bne $r13, $r0, delay
j gen_fall_check3

gen_empty_check3:
bne $r14, $r0, delay
j gen_fall_check4

gen_empty_check4:
bne $r15, $r0, delay
j gen_bottom_check


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


