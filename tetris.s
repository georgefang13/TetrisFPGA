# Tetris!

# set drop frequency:
addi $r26, $r0, 1220
sll $r26, $r26, 10  # build ~50,000,000

new_game:

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
sw $r1, 235($r0)
nop  # allow for more random generation
nop 
add $r2, $r28, $r0
sw $r2, 236($r0)
nop
nop
add $r3, $r28, $r0
sw $r3, 237($r0)
nop
nop
add $r4, $r28, $r0
sw $r4, 238($r0)
nop
nop
add $r5, $r28, $r0
sw $r5, 239($r0)


place_block:
# check for game over:
addi $r7, $r0, 7
addi $r8, $r0, 0
addi $r9, $r0, 1
addi $r10, $r0, 3

# check loop
check_end:
lw $r11, 0($r10)
bne $r11, $r0, new_game

addi $r10, $r10, 1
blt $r10, $r7, check_end

addi $r8, $r8, 1
bne $r8, $r9, board_good

addi $r10, $r0, 13
addi $r7, $r0, 16
j check_end

board_good:

# Get next piece
lw $r1, 235($r0)

# shift up next blocks and get new random block
lw $r2, 236($r0)
sw $r2, 235($r0)

lw $r3, 237($r0)
sw $r3, 236($r0)

lw $r4, 238($r0)
sw $r4, 237($r0)

lw $r5, 239($r0)
sw $r5, 238($r0)

add $r5, $r28, $r0
sw $r5, 239($r0)

spawn_hold:

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

addi $r2, $r0, 3
sw $r2, 219($r0) # x1
addi $r2, $r0, 0
sw $r2, 220($r0) # y1
addi $r2, $r0, 3
sw $r2, 221($r0) # x2
addi $r2, $r0, 1
sw $r2, 222($r0) # y2
addi $r2, $r0, 4
sw $r2, 223($r0) # x3
addi $r2, $r0, 1
sw $r2, 224($r0) # y3
addi $r2, $r0, 5
sw $r2, 225($r0) # x4
addi $r2, $r0, 1
sw $r2, 226($r0) # y4

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

addi $r2, $r0, 5
sw $r2, 219($r0) # x1
addi $r2, $r0, 0
sw $r2, 220($r0) # y1
addi $r2, $r0, 3
sw $r2, 221($r0) # x2
addi $r2, $r0, 1
sw $r2, 222($r0) # y2
addi $r2, $r0, 4
sw $r2, 223($r0) # x3
addi $r2, $r0, 1
sw $r2, 224($r0) # y3
addi $r2, $r0, 5
sw $r2, 225($r0) # x4
addi $r2, $r0, 1
sw $r2, 226($r0) # y4

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

addi $r2, $r0, 4
sw $r2, 219($r0) # x1
addi $r2, $r0, 0
sw $r2, 220($r0) # y1
addi $r2, $r0, 3
sw $r2, 221($r0) # x2
addi $r2, $r0, 1
sw $r2, 222($r0) # y2
addi $r2, $r0, 4
sw $r2, 223($r0) # x3
addi $r2, $r0, 1
sw $r2, 224($r0) # y3
addi $r2, $r0, 5
sw $r2, 225($r0) # x4
addi $r2, $r0, 1
sw $r2, 226($r0) # y4

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

addi $r2, $r0, 3
sw $r2, 219($r0) # x1
addi $r2, $r0, 0
sw $r2, 220($r0) # y1
addi $r2, $r0, 4
sw $r2, 221($r0) # x2
addi $r2, $r0, 0
sw $r2, 222($r0) # y2
addi $r2, $r0, 4
sw $r2, 223($r0) # x3
addi $r2, $r0, 1
sw $r2, 224($r0) # y3
addi $r2, $r0, 5
sw $r2, 225($r0) # x4
addi $r2, $r0, 1
sw $r2, 226($r0) # y4

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

addi $r2, $r0, 4
sw $r2, 219($r0) # x1
addi $r2, $r0, 0
sw $r2, 220($r0) # y1
addi $r2, $r0, 5
sw $r2, 221($r0) # x2
addi $r2, $r0, 0
sw $r2, 222($r0) # y2
addi $r2, $r0, 3
sw $r2, 223($r0) # x3
addi $r2, $r0, 1
sw $r2, 224($r0) # y3
addi $r2, $r0, 4
sw $r2, 225($r0) # x4
addi $r2, $r0, 1
sw $r2, 226($r0) # y4

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

addi $r2, $r0, 4
sw $r2, 219($r0) # x1
addi $r2, $r0, 0
sw $r2, 220($r0) # y1
addi $r2, $r0, 5
sw $r2, 221($r0) # x2
addi $r2, $r0, 0
sw $r2, 222($r0) # y2
addi $r2, $r0, 4
sw $r2, 223($r0) # x3
addi $r2, $r0, 1
sw $r2, 224($r0) # y3
addi $r2, $r0, 5
sw $r2, 225($r0) # x4
addi $r2, $r0, 1
sw $r2, 226($r0) # y4

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

addi $r2, $r0, 3
sw $r2, 219($r0) # x1
addi $r2, $r0, 0
sw $r2, 220($r0) # y1
addi $r2, $r0, 4
sw $r2, 221($r0) # x2
addi $r2, $r0, 0
sw $r2, 222($r0) # y2
addi $r2, $r0, 5
sw $r2, 223($r0) # x3
addi $r2, $r0, 0
sw $r2, 224($r0) # y3
addi $r2, $r0, 6
sw $r2, 225($r0) # x4
addi $r2, $r0, 0
sw $r2, 226($r0) # y4

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
j new_game

not_reset:
addi $r2, $r0, 9
bne $r1, $r2, not_hold
j hold

not_hold:
addi $r2, $r0, 8
bne $r1, $r2, not_RCW
j RCW

not_RCW:
addi $r2, $r0, 7
bne $r1, $r2, not_RCCW
j RCCW

not_RCCW:
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

# updating the X and Y coords
lw $r16, 219($r0)
sw $r16, 227($r0)

lw $r6, 220($r0)
addi $r6, $r6, 1
sw $r6, 228($r0)

lw $r17, 221($r0)
sw $r17, 229($r0)

lw $r7, 222($r0)
addi $r7, $r7, 1
sw $r7, 230($r0)

lw $r18, 223($r0)
sw $r18, 231($r0)

lw $r8, 224($r0)
addi $r8, $r8, 1
sw $r8, 232($r0)

lw $r18, 225($r0)
sw $r18, 233($r0)

lw $r9, 226($r0)
addi $r9, $r9, 1
sw $r9, 234($r0)

lw $r1, 201($r0)
sw $r1, 207($r0)

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

# reset hold 
addi $r1, $r0, 1
blt $r29, $r1, non_hold
addi $r29, $r0, 0

non_hold:
jal line_clear

j place_block

render_ns:
# load type and make active
lw $r1, 200($r0)
addi $r1, $r1, 8

# load and store rotation
lw $r16, 207($r0)
sw $r16, 201($r0)

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

# grab next X and Y and store in current
lw $r2, 227($r0)
lw $r3, 228($r0)
lw $r4, 229($r0)
lw $r5, 230($r0)
lw $r6, 231($r0)
lw $r7, 232($r0)
lw $r8, 233($r0)
lw $r9, 234($r0)

sw $r2, 219($r0)
sw $r3, 220($r0)
sw $r4, 221($r0)
sw $r5, 222($r0)
sw $r6, 223($r0)
sw $r7, 224($r0)
sw $r8, 225($r0)
sw $r9, 226($r0)

jal line_clear

j delay

hold:

# check if a hold has already been done
bne $r29, $r0, delay

# mark hold as done
addi $r29, $r0, 1

# load out the held block
lw $r1, 218($r0)

# store current piece
lw $r2, 200($r0)
sw $r2, 218($r0)

# wipe current piece 
lw $r12, 202($r0)
lw $r13, 203($r0)
lw $r14, 204($r0)
lw $r15, 205($r0)
sw $r0, 0($r12)
sw $r0, 0($r13)
sw $r0, 0($r14)
sw $r0, 0($r15)

# check if anyting is held
bne $r1, $r0, spawn_hold

j place_block

move_left:

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

# updating the X and Y coords
lw $r2, 219($r0)
lw $r12, 220($r0)
lw $r3, 221($r0)
lw $r13, 222($r0)
lw $r4, 223($r0)
lw $r14, 224($r0)
lw $r5, 225($r0)
lw $r15, 226($r0)

addi $r2, $r2, -1
addi $r3, $r3, -1
addi $r4, $r4, -1
addi $r5, $r5, -1

sw $r2, 227($r0)
sw $r12, 228($r0)
sw $r3, 229($r0)
sw $r13, 230($r0)
sw $r4, 231($r0)
sw $r14, 232($r0)
sw $r5, 233($r0)
sw $r15, 234($r0)

lw $r1, 201($r0)
sw $r1, 207($r0)

j collide_detect

move_right:

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

# updating the X and Y coords
lw $r2, 219($r0)
lw $r12, 220($r0)
lw $r3, 221($r0)
lw $r13, 222($r0)
lw $r4, 223($r0)
lw $r14, 224($r0)
lw $r5, 225($r0)
lw $r15, 226($r0)

addi $r2, $r2, 1
addi $r3, $r3, 1
addi $r4, $r4, 1
addi $r5, $r5, 1

sw $r2, 227($r0)
sw $r12, 228($r0)
sw $r3, 229($r0)
sw $r13, 230($r0)
sw $r4, 231($r0)
sw $r14, 232($r0)
sw $r5, 233($r0)
sw $r15, 234($r0)

lw $r1, 201($r0)
sw $r1, 207($r0)

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

# top check
blt $r2, $r0, delay
blt $r3, $r0, delay
blt $r4, $r0, delay
blt $r5, $r0, delay

# left and right check
lw $r2, 227($r0)
lw $r3, 229($r0)
lw $r4, 231($r0)
lw $r5, 233($r0)
blt $r2, $r0, delay
blt $r3, $r0, delay
blt $r4, $r0, delay
blt $r5, $r0, delay

addi $r1, $r0, 9
blt $r1, $r2, delay
blt $r1, $r3, delay
blt $r1, $r4, delay
blt $r1, $r5, delay

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

line_clear:

# set row counter and 8, 190
addi $r11, $r0, -10
addi $r18, $r0, 8 
addi $r19, $r0, 189
addi $r20, $r0, 9

# zero score increment
add $r14, $r0, $r0

lc_loop:
# increment RC and set column count
addi $r11, $r11, 10
addi $r12, $r0, -1
lc_row_loop:
# add to column, calculate mem address
addi $r12, $r12, 1
add $r13, $r11, $r12
# load value at address
lw $r1, 0($r13)
# check to see if its an inactive block
blt $r1, $r18, lc_zero_check
j end_lc_loop
lc_zero_check:
bne $r1, $r0, lc_end_check
j end_lc_loop

# see if were at end of the row
lc_end_check:
blt $r12, $r20, lc_row_loop

# increment line cleared counter
addi $r14, $r14, 1

add $r22, $r11, $r0

# clear current row
sw $r0, 0($r22)
sw $r0, 1($r22)
sw $r0, 2($r22)
sw $r0, 3($r22)
sw $r0, 4($r22)
sw $r0, 5($r22)
sw $r0, 6($r22)
sw $r0, 7($r22)
sw $r0, 8($r22)
sw $r0, 9($r22)

# shift everything above down
shift_down:
# row above
addi $r23, $r22, -10

# load row above
lw $r1, 0($r23)
lw $r2, 1($r23)
lw $r3, 2($r23)
lw $r4, 3($r23)
lw $r5, 4($r23)
lw $r6, 5($r23)
lw $r7, 6($r23)
lw $r8, 7($r23)
lw $r9, 8($r23)
lw $r10, 9($r23)

# store in row below
sw $r1, 0($r22)
sw $r2, 1($r22)
sw $r3, 2($r22)
sw $r4, 3($r22)
sw $r5, 4($r22)
sw $r6, 5($r22)
sw $r7, 6($r22)
sw $r8, 7($r22)
sw $r9, 8($r22)
sw $r10, 9($r22)

# move curr row up 
addi $r22, $r22, -10
# check if at the top
blt $r0, $r22, shift_down

# If checked the whole board, break
end_lc_loop:
blt $r11, $r19, lc_loop

addi $r15, $r0, 4
blt $r14, $r15, score_lt4
addi $r24, $r24, 800

score_lt4:
addi $r15, $r0, 3
blt $r14, $r15, score_lt3
addi $r24, $r24, 400
j score_done

score_lt3:
addi $r15, $r0, 2
blt $r14, $r15, score_lt2
addi $r24, $r24, 200
j score_done

score_lt2:
addi $r15, $r0, 1
blt $r14, $r15, score_done
addi $r24, $r24, 100

score_done:
jr $ra

RCW:

# Load Current Status:
lw $r1, 200($r0)

addi $r2, $r0, 1
bne $r1, $r2, RC_nI
j RC_I

RC_nI:
addi $r2, $r0, 2
bne $r1, $r2, RC_nO
j delay

RC_nO:
addi $r2, $r0, 3
bne $r1, $r2, RC_nS
j RC_S

RC_nS:
addi $r2, $r0, 4
bne $r1, $r2, RC_nZ
j RC_Z

RC_nZ:
addi $r2, $r0, 5
bne $r1, $r2, RC_nT
j RC_T

RC_nT:
addi $r2, $r0, 6
bne $r1, $r2, RC_nL
j RC_L

RC_nL:
addi $r2, $r0, 7
bne $r1, $r2, RC_nJ
j RC_J

RC_nJ: 
j delay

RC_I:
lw $r1, 201($r0)
addi $r2, $r0, 1
bne $r1, $r2, RC_I_n1

# rotate from 1 to 2 
lw $r2, 202($r0)
lw $r3, 203($r0)
lw $r4, 204($r0)
lw $r5, 205($r0)

addi $r2, $r2, 22
addi $r3, $r3, 11
addi $r4, $r4, 0
addi $r5, $r5, -11

# Update roation
addi $r1, $r0, 2
sw $r1, 207($r0)

sw $r2, 208($r0)
sw $r3, 209($r0)
sw $r4, 210($r0)
sw $r5, 211($r0)

# update x and ys
lw $r6, 219($r0) #x1
addi $r6, $r6, 2
sw $r6, 227($r0)

lw $r7, 220($r0) #y1
addi $r7, $r7, 2
sw $r7, 228($r0)

lw $r8, 221($r0) #x2
addi $r8, $r8, 1
sw $r8, 229($r0)

lw $r9, 222($r0) #y2
addi $r9, $r9, 1
sw $r9, 230($r0)

lw $r10, 223($r0) #x3
addi $r10, $r10, 0
sw $r10, 231($r0)

lw $r11, 224($r0) #y3
addi $r11, $r11, 0
sw $r11, 232($r0)

lw $r12, 225($r0) #x4
addi $r12, $r12, -1
sw $r12, 233($r0)

lw $r13, 226($r0) #y4
addi $r13, $r13, -1
sw $r13, 234($r0)

j collide_detect

RC_I_n1:
addi $r2, $r0, 2
bne $r1, $r2, RC_I_n2
# rotate from 2 to 3 
lw $r2, 202($r0)
lw $r3, 203($r0)
lw $r4, 204($r0)
lw $r5, 205($r0)

addi $r2, $r2, -9
addi $r3, $r3, 0
addi $r4, $r4, 9
addi $r5, $r5, 18

# Update roation
addi $r1, $r0, 3
sw $r1, 207($r0)

sw $r2, 208($r0)
sw $r3, 209($r0)
sw $r4, 210($r0)
sw $r5, 211($r0)

# update x and ys
lw $r6, 219($r0) #x1
addi $r6, $r6, 1
sw $r6, 227($r0)

lw $r7, 220($r0) #y1
addi $r7, $r7, -1
sw $r7, 228($r0)

lw $r8, 221($r0) #x2
addi $r8, $r8, 0
sw $r8, 229($r0)

lw $r9, 222($r0) #y2
addi $r9, $r9, 0
sw $r9, 230($r0)

lw $r10, 223($r0) #x3
addi $r10, $r10, -1
sw $r10, 231($r0)

lw $r11, 224($r0) #y3
addi $r11, $r11, 1
sw $r11, 232($r0)

lw $r12, 225($r0) #x4
addi $r12, $r12, -2
sw $r12, 233($r0)

lw $r13, 226($r0) #y4
addi $r13, $r13, 2
sw $r13, 234($r0)

j collide_detect

RC_I_n2:
addi $r2, $r0, 3
bne $r1, $r2, RC_I_n3

# rotate from 3 to 4
lw $r2, 202($r0)
lw $r3, 203($r0)
lw $r4, 204($r0)
lw $r5, 205($r0)

addi $r2, $r2, -22
addi $r3, $r3, -11
addi $r4, $r4, 0
addi $r5, $r5, 11

# Update roation
addi $r1, $r0, 4
sw $r1, 207($r0)

sw $r2, 208($r0)
sw $r3, 209($r0)
sw $r4, 210($r0)
sw $r5, 211($r0)

# update x and ys
lw $r6, 219($r0) #x1
addi $r6, $r6, -2
sw $r6, 227($r0)

lw $r7, 220($r0) #y1
addi $r7, $r7, -2
sw $r7, 228($r0)

lw $r8, 221($r0) #x2
addi $r8, $r8, -1
sw $r8, 229($r0)

lw $r9, 222($r0) #y2
addi $r9, $r9, -1
sw $r9, 230($r0)

lw $r10, 223($r0) #x3
addi $r10, $r10, 0
sw $r10, 231($r0)

lw $r11, 224($r0) #y3
addi $r11, $r11, 0
sw $r11, 232($r0)

lw $r12, 225($r0) #x4
addi $r12, $r12, 1
sw $r12, 233($r0)

lw $r13, 226($r0) #y4
addi $r13, $r13, 1
sw $r13, 234($r0)

j collide_detect

RC_I_n3:

# rotate from 4 to 1 
lw $r2, 202($r0)
lw $r3, 203($r0)
lw $r4, 204($r0)
lw $r5, 205($r0)

addi $r2, $r2, 9
addi $r3, $r3, 0
addi $r4, $r4, -9
addi $r5, $r5, -18

# Update roation
addi $r1, $r0, 1
sw $r1, 207($r0)

sw $r2, 208($r0)
sw $r3, 209($r0)
sw $r4, 210($r0)
sw $r5, 211($r0)

# update x and ys
lw $r6, 219($r0) #x1
addi $r6, $r6, -1
sw $r6, 227($r0)

lw $r7, 220($r0) #y1
addi $r7, $r7, 1
sw $r7, 228($r0)

lw $r8, 221($r0) #x2
addi $r8, $r8, 0
sw $r8, 229($r0)

lw $r9, 222($r0) #y2
addi $r9, $r9, 0
sw $r9, 230($r0)

lw $r10, 223($r0) #x3
addi $r10, $r10, 1
sw $r10, 231($r0)

lw $r11, 224($r0) #y3
addi $r11, $r11, -1
sw $r11, 232($r0)

lw $r12, 225($r0) #x4
addi $r12, $r12, 2
sw $r12, 233($r0)

lw $r13, 226($r0) #y4
addi $r13, $r13, -2
sw $r13, 234($r0)

j collide_detect

RC_S:
lw $r1, 201($r0)
addi $r2, $r0, 1
bne $r1, $r2, RC_S_n1

# rotate from 1 to 2 
lw $r2, 202($r0)
lw $r3, 203($r0)
lw $r4, 204($r0)
lw $r5, 205($r0)

addi $r2, $r2, 0
addi $r3, $r3, 10
addi $r4, $r4, 12
addi $r5, $r5, 0

# Update roation
addi $r1, $r0, 2
sw $r1, 207($r0)

sw $r2, 208($r0)
sw $r3, 209($r0)
sw $r4, 210($r0)
sw $r5, 211($r0)

# update x and ys
lw $r6, 219($r0) #x1
addi $r6, $r6, 0
sw $r6, 227($r0)

lw $r7, 220($r0) #y1
addi $r7, $r7, 0
sw $r7, 228($r0)

lw $r8, 221($r0) #x2
addi $r8, $r8, 0
sw $r8, 229($r0)

lw $r9, 222($r0) #y2
addi $r9, $r9, 1
sw $r9, 230($r0)

lw $r10, 223($r0) #x3
addi $r10, $r10, 2
sw $r10, 231($r0)

lw $r11, 224($r0) #y3
addi $r11, $r11, 1
sw $r11, 232($r0)

lw $r12, 225($r0) #x4
addi $r12, $r12, 0
sw $r12, 233($r0)

lw $r13, 226($r0) #y4
addi $r13, $r13, 0
sw $r13, 234($r0)

j collide_detect

RC_S_n1:
addi $r2, $r0, 2
bne $r1, $r2, RC_S_n2
# rotate from 2 to 3 
lw $r2, 202($r0)
lw $r3, 203($r0)
lw $r4, 204($r0)
lw $r5, 205($r0)

addi $r2, $r2, 20
addi $r3, $r3, 0
addi $r4, $r4, -2
addi $r5, $r5, 0

# Update roation
addi $r1, $r0, 3
sw $r1, 207($r0)

sw $r2, 208($r0)
sw $r3, 209($r0)
sw $r4, 210($r0)
sw $r5, 211($r0)

# update x and ys
lw $r6, 219($r0) #x1
addi $r6, $r6, 0
sw $r6, 227($r0)

lw $r7, 220($r0) #y1
addi $r7, $r7, 2
sw $r7, 228($r0)

lw $r8, 221($r0) #x2
addi $r8, $r8, 0
sw $r8, 229($r0)

lw $r9, 222($r0) #y2
addi $r9, $r9, 0
sw $r9, 230($r0)

lw $r10, 223($r0) #x3
addi $r10, $r10, -2
sw $r10, 231($r0)

lw $r11, 224($r0) #y3
addi $r11, $r11, 0
sw $r11, 232($r0)

lw $r12, 225($r0) #x4
addi $r12, $r12, 0
sw $r12, 233($r0)

lw $r13, 226($r0) #y4
addi $r13, $r13, 0
sw $r13, 234($r0)

j collide_detect

RC_S_n2:
addi $r2, $r0, 3
bne $r1, $r2, RC_S_n3

# rotate from 3 to 4
lw $r2, 202($r0)
lw $r3, 203($r0)
lw $r4, 204($r0)
lw $r5, 205($r0)

addi $r2, $r2, 0
addi $r3, $r3, -12
addi $r4, $r4, -10
addi $r5, $r5, 0

# Update roation
addi $r1, $r0, 4
sw $r1, 207($r0)

sw $r2, 208($r0)
sw $r3, 209($r0)
sw $r4, 210($r0)
sw $r5, 211($r0)

# update x and ys
lw $r6, 219($r0) #x1
addi $r6, $r6, 0
sw $r6, 227($r0)

lw $r7, 220($r0) #y1
addi $r7, $r7, 0
sw $r7, 228($r0)

lw $r8, 221($r0) #x2
addi $r8, $r8, -2
sw $r8, 229($r0)

lw $r9, 222($r0) #y2
addi $r9, $r9, -1
sw $r9, 230($r0)

lw $r10, 223($r0) #x3
addi $r10, $r10, 0
sw $r10, 231($r0)

lw $r11, 224($r0) #y3
addi $r11, $r11, -1
sw $r11, 232($r0)

lw $r12, 225($r0) #x4
addi $r12, $r12, 0
sw $r12, 233($r0)

lw $r13, 226($r0) #y4
addi $r13, $r13, 0
sw $r13, 234($r0)

j collide_detect

RC_S_n3:

# rotate from 4 to 1 
lw $r2, 202($r0)
lw $r3, 203($r0)
lw $r4, 204($r0)
lw $r5, 205($r0)

addi $r2, $r2, -20
addi $r3, $r3, 2
addi $r4, $r4, 0
addi $r5, $r5, 0

# Update roation
addi $r1, $r0, 1
sw $r1, 207($r0)

sw $r2, 208($r0)
sw $r3, 209($r0)
sw $r4, 210($r0)
sw $r5, 211($r0)

# update x and ys
lw $r6, 219($r0) #x1
addi $r6, $r6, 0
sw $r6, 227($r0)

lw $r7, 220($r0) #y1
addi $r7, $r7, -2
sw $r7, 228($r0)

lw $r8, 221($r0) #x2
addi $r8, $r8, 2
sw $r8, 229($r0)

lw $r9, 222($r0) #y2
addi $r9, $r9, 0
sw $r9, 230($r0)

lw $r10, 223($r0) #x3
addi $r10, $r10, 0
sw $r10, 231($r0)

lw $r11, 224($r0) #y3
addi $r11, $r11, 0
sw $r11, 232($r0)

lw $r12, 225($r0) #x4
addi $r12, $r12, 0
sw $r12, 233($r0)

lw $r13, 226($r0) #y4
addi $r13, $r13, 0
sw $r13, 234($r0)

j collide_detect

RC_Z:
lw $r1, 201($r0)
addi $r2, $r0, 1
bne $r1, $r2, RC_Z_n1

# rotate from 1 to 2 
lw $r2, 202($r0)
lw $r3, 203($r0)
lw $r4, 204($r0)
lw $r5, 205($r0)

addi $r2, $r2, 21
addi $r3, $r3, 1
addi $r4, $r4, 0
addi $r5, $r5, 0

# Update roation
addi $r1, $r0, 2
sw $r1, 207($r0)

sw $r2, 208($r0)
sw $r3, 209($r0)
sw $r4, 210($r0)
sw $r5, 211($r0)

# update x and ys
lw $r6, 219($r0) #x1
addi $r6, $r6, 1
sw $r6, 227($r0)

lw $r7, 220($r0) #y1
addi $r7, $r7, 2
sw $r7, 228($r0)

lw $r8, 221($r0) #x2
addi $r8, $r8, 1
sw $r8, 229($r0)

lw $r9, 222($r0) #y2
addi $r9, $r9, 0
sw $r9, 230($r0)

lw $r10, 223($r0) #x3
addi $r10, $r10, 0
sw $r10, 231($r0)

lw $r11, 224($r0) #y3
addi $r11, $r11, 0
sw $r11, 232($r0)

lw $r12, 225($r0) #x4
addi $r12, $r12, 0
sw $r12, 233($r0)

lw $r13, 226($r0) #y4
addi $r13, $r13, 0
sw $r13, 234($r0)

j collide_detect

RC_Z_n1:
addi $r2, $r0, 2
bne $r1, $r2, RC_Z_n2
# rotate from 2 to 3 
lw $r2, 202($r0)
lw $r3, 203($r0)
lw $r4, 204($r0)
lw $r5, 205($r0)

addi $r2, $r2, 0
addi $r3, $r3, 8
addi $r4, $r4, 0
addi $r5, $r5, 10

# Update roation
addi $r1, $r0, 3
sw $r1, 207($r0)

sw $r2, 208($r0)
sw $r3, 209($r0)
sw $r4, 210($r0)
sw $r5, 211($r0)

# update x and ys
lw $r6, 219($r0) #x1
addi $r6, $r6, 0
sw $r6, 227($r0)

lw $r7, 220($r0) #y1
addi $r7, $r7, 0
sw $r7, 228($r0)

lw $r8, 221($r0) #x2
addi $r8, $r8, -2
sw $r8, 229($r0)

lw $r9, 222($r0) #y2
addi $r9, $r9, 1
sw $r9, 230($r0)

lw $r10, 223($r0) #x3
addi $r10, $r10, 0
sw $r10, 231($r0)

lw $r11, 224($r0) #y3
addi $r11, $r11, 0
sw $r11, 232($r0)

lw $r12, 225($r0) #x4
addi $r12, $r12, 0
sw $r12, 233($r0)

lw $r13, 226($r0) #y4
addi $r13, $r13, 1
sw $r13, 234($r0)

j collide_detect

RC_Z_n2:
addi $r2, $r0, 3
bne $r1, $r2, RC_Z_n3

# rotate from 3 to 4
lw $r2, 202($r0)
lw $r3, 203($r0)
lw $r4, 204($r0)
lw $r5, 205($r0)

addi $r2, $r2, -1
addi $r3, $r3, 0
addi $r4, $r4, 0
addi $r5, $r5, -21

# Update roation
addi $r1, $r0, 4
sw $r1, 207($r0)

sw $r2, 208($r0)
sw $r3, 209($r0)
sw $r4, 210($r0)
sw $r5, 211($r0)

# update x and ys
lw $r6, 219($r0) #x1
addi $r6, $r6, -1
sw $r6, 227($r0)

lw $r7, 220($r0) #y1
addi $r7, $r7, 0
sw $r7, 228($r0)

lw $r8, 221($r0) #x2
addi $r8, $r8, 0
sw $r8, 229($r0)

lw $r9, 222($r0) #y2
addi $r9, $r9, 0
sw $r9, 230($r0)

lw $r10, 223($r0) #x3
addi $r10, $r10, 0
sw $r10, 231($r0)

lw $r11, 224($r0) #y3
addi $r11, $r11, 0
sw $r11, 232($r0)

lw $r12, 225($r0) #x4
addi $r12, $r12, -1
sw $r12, 233($r0)

lw $r13, 226($r0) #y4
addi $r13, $r13, -2
sw $r13, 234($r0)

j collide_detect

RC_Z_n3:

# rotate from 4 to 1 
lw $r2, 202($r0)
lw $r3, 203($r0)
lw $r4, 204($r0)
lw $r5, 205($r0)

addi $r2, $r2, -20
addi $r3, $r3, -9
addi $r4, $r4, 0
addi $r5, $r5, 11

# Update roation
addi $r1, $r0, 1
sw $r1, 207($r0)

sw $r2, 208($r0)
sw $r3, 209($r0)
sw $r4, 210($r0)
sw $r5, 211($r0)

# update x and ys
lw $r6, 219($r0) #x1
addi $r6, $r6, 0
sw $r6, 227($r0)

lw $r7, 220($r0) #y1
addi $r7, $r7, -2
sw $r7, 228($r0)

lw $r8, 221($r0) #x2
addi $r8, $r8, 1
sw $r8, 229($r0)

lw $r9, 222($r0) #y2
addi $r9, $r9, -1
sw $r9, 230($r0)

lw $r10, 223($r0) #x3
addi $r10, $r10, 0
sw $r10, 231($r0)

lw $r11, 224($r0) #y3
addi $r11, $r11, 0
sw $r11, 232($r0)

lw $r12, 225($r0) #x4
addi $r12, $r12, 1
sw $r12, 233($r0)

lw $r13, 226($r0) #y4
addi $r13, $r13, 1
sw $r13, 234($r0)

j collide_detect

RC_T:
lw $r1, 201($r0)
addi $r2, $r0, 1
bne $r1, $r2, RC_T_n1

# rotate from 1 to 2 
lw $r2, 202($r0)
lw $r3, 203($r0)
lw $r4, 204($r0)
lw $r5, 205($r0)

addi $r2, $r2, 0
addi $r3, $r3, 11
addi $r4, $r4, 0
addi $r5, $r5, 0

# Update roation
addi $r1, $r0, 2
sw $r1, 207($r0)

sw $r2, 208($r0)
sw $r3, 209($r0)
sw $r4, 210($r0)
sw $r5, 211($r0)

# update x and ys
lw $r6, 219($r0) #x1
addi $r6, $r6, 0
sw $r6, 227($r0)

lw $r7, 220($r0) #y1
addi $r7, $r7, 0
sw $r7, 228($r0)

lw $r8, 221($r0) #x2
addi $r8, $r8, 1
sw $r8, 229($r0)

lw $r9, 222($r0) #y2
addi $r9, $r9, 1
sw $r9, 230($r0)

lw $r10, 223($r0) #x3
addi $r10, $r10, 0
sw $r10, 231($r0)

lw $r11, 224($r0) #y3
addi $r11, $r11, 0
sw $r11, 232($r0)

lw $r12, 225($r0) #x4
addi $r12, $r12, 0
sw $r12, 233($r0)

lw $r13, 226($r0) #y4
addi $r13, $r13, 0
sw $r13, 234($r0)

j collide_detect

RC_T_n1:
addi $r2, $r0, 2
bne $r1, $r2, RC_T_n2
# rotate from 2 to 3 
lw $r2, 202($r0)
lw $r3, 203($r0)
lw $r4, 204($r0)
lw $r5, 205($r0)

addi $r2, $r2, 9
addi $r3, $r3, 0
addi $r4, $r4, 0
addi $r5, $r5, 0

# Update roation
addi $r1, $r0, 3
sw $r1, 207($r0)

sw $r2, 208($r0)
sw $r3, 209($r0)
sw $r4, 210($r0)
sw $r5, 211($r0)

# update x and ys
lw $r6, 219($r0) #x1
addi $r6, $r6, -1
sw $r6, 227($r0)

lw $r7, 220($r0) #y1
addi $r7, $r7, 1
sw $r7, 228($r0)

lw $r8, 221($r0) #x2
addi $r8, $r8, 0
sw $r8, 229($r0)

lw $r9, 222($r0) #y2
addi $r9, $r9, 0
sw $r9, 230($r0)

lw $r10, 223($r0) #x3
addi $r10, $r10, 0
sw $r10, 231($r0)

lw $r11, 224($r0) #y3
addi $r11, $r11, 0
sw $r11, 232($r0)

lw $r12, 225($r0) #x4
addi $r12, $r12, 0
sw $r12, 233($r0)

lw $r13, 226($r0) #y4
addi $r13, $r13, 0
sw $r13, 234($r0)

j collide_detect

RC_T_n2:
addi $r2, $r0, 3
bne $r1, $r2, RC_T_n3

# rotate from 3 to 4
lw $r2, 202($r0)
lw $r3, 203($r0)
lw $r4, 204($r0)
lw $r5, 205($r0)

addi $r2, $r2, 0
addi $r3, $r3, 0
addi $r4, $r4, 0
addi $r5, $r5, -11

# Update roation
addi $r1, $r0, 4
sw $r1, 207($r0)

sw $r2, 208($r0)
sw $r3, 209($r0)
sw $r4, 210($r0)
sw $r5, 211($r0)

# update x and ys
lw $r6, 219($r0) #x1
addi $r6, $r6, 0
sw $r6, 227($r0)

lw $r7, 220($r0) #y1
addi $r7, $r7, 0
sw $r7, 228($r0)

lw $r8, 221($r0) #x2
addi $r8, $r8, 0
sw $r8, 229($r0)

lw $r9, 222($r0) #y2
addi $r9, $r9, 0
sw $r9, 230($r0)

lw $r10, 223($r0) #x3
addi $r10, $r10, 0
sw $r10, 231($r0)

lw $r11, 224($r0) #y3
addi $r11, $r11, 0
sw $r11, 232($r0)

lw $r12, 225($r0) #x4
addi $r12, $r12, -1
sw $r12, 233($r0)

lw $r13, 226($r0) #y4
addi $r13, $r13, -1
sw $r13, 234($r0)

j collide_detect

RC_T_n3:

# rotate from 4 to 1 
lw $r2, 202($r0)
lw $r3, 203($r0)
lw $r4, 204($r0)
lw $r5, 205($r0)

addi $r2, $r2, -9
addi $r3, $r3, -11
addi $r4, $r4, 0
addi $r5, $r5, 11

# Update roation
addi $r1, $r0, 1
sw $r1, 207($r0)

sw $r2, 208($r0)
sw $r3, 209($r0)
sw $r4, 210($r0)
sw $r5, 211($r0)

# update x and ys
lw $r6, 219($r0) #x1
addi $r6, $r6, 1
sw $r6, 227($r0)

lw $r7, 220($r0) #y1
addi $r7, $r7, -1
sw $r7, 228($r0)

lw $r8, 221($r0) #x2
addi $r8, $r8, -1
sw $r8, 229($r0)

lw $r9, 222($r0) #y2
addi $r9, $r9, -1
sw $r9, 230($r0)

lw $r10, 223($r0) #x3
addi $r10, $r10, 0
sw $r10, 231($r0)

lw $r11, 224($r0) #y3
addi $r11, $r11, 0
sw $r11, 232($r0)

lw $r12, 225($r0) #x4
addi $r12, $r12, 1
sw $r12, 233($r0)

lw $r13, 226($r0) #y4
addi $r13, $r13, 1
sw $r13, 234($r0)

j collide_detect

RC_L:
lw $r1, 201($r0)
addi $r2, $r0, 1
bne $r1, $r2, RC_L_n1

# rotate from 1 to 2 
lw $r2, 202($r0)
lw $r3, 203($r0)
lw $r4, 204($r0)
lw $r5, 205($r0)

addi $r2, $r2, 20
addi $r3, $r3, -9
addi $r4, $r4, 0
addi $r5, $r5, 9

# Update roation
addi $r1, $r0, 2
sw $r1, 207($r0)

sw $r2, 208($r0)
sw $r3, 209($r0)
sw $r4, 210($r0)
sw $r5, 211($r0)

# update x and ys
lw $r6, 219($r0) #x1
addi $r6, $r6, 0
sw $r6, 227($r0)

lw $r7, 220($r0) #y1
addi $r7, $r7, 2
sw $r7, 228($r0)

lw $r8, 221($r0) #x2
addi $r8, $r8, 1
sw $r8, 229($r0)

lw $r9, 222($r0) #y2
addi $r9, $r9, -1
sw $r9, 230($r0)

lw $r10, 223($r0) #x3
addi $r10, $r10, 0
sw $r10, 231($r0)

lw $r11, 224($r0) #y3
addi $r11, $r11, 0
sw $r11, 232($r0)

lw $r12, 225($r0) #x4
addi $r12, $r12, -1
sw $r12, 233($r0)

lw $r13, 226($r0) #y4
addi $r13, $r13, 1
sw $r13, 234($r0)

j collide_detect

RC_L_n1:
addi $r2, $r0, 2
bne $r1, $r2, RC_L_n2
# rotate from 2 to 3 
lw $r2, 202($r0)
lw $r3, 203($r0)
lw $r4, 204($r0)
lw $r5, 205($r0)

addi $r2, $r2, -2
addi $r3, $r3, 11
addi $r4, $r4, 0
addi $r5, $r5, -11

# Update roation
addi $r1, $r0, 3
sw $r1, 207($r0)

sw $r2, 208($r0)
sw $r3, 209($r0)
sw $r4, 210($r0)
sw $r5, 211($r0)

# update x and ys
lw $r6, 219($r0) #x1
addi $r6, $r6, -2
sw $r6, 227($r0)

lw $r7, 220($r0) #y1
addi $r7, $r7, 0
sw $r7, 228($r0)

lw $r8, 221($r0) #x2
addi $r8, $r8, 1
sw $r8, 229($r0)

lw $r9, 222($r0) #y2
addi $r9, $r9, 1
sw $r9, 230($r0)

lw $r10, 223($r0) #x3
addi $r10, $r10, 0
sw $r10, 231($r0)

lw $r11, 224($r0) #y3
addi $r11, $r11, 0
sw $r11, 232($r0)

lw $r12, 225($r0) #x4
addi $r12, $r12, -1
sw $r12, 233($r0)

lw $r13, 226($r0) #y4
addi $r13, $r13, -1
sw $r13, 234($r0)

j collide_detect

RC_L_n2:
addi $r2, $r0, 3
bne $r1, $r2, RC_L_n3

# rotate from 3 to 4
lw $r2, 202($r0)
lw $r3, 203($r0)
lw $r4, 204($r0)
lw $r5, 205($r0)

addi $r2, $r2, -20
addi $r3, $r3, 9
addi $r4, $r4, 0
addi $r5, $r5, -9

# Update roation
addi $r1, $r0, 4
sw $r1, 207($r0)

sw $r2, 208($r0)
sw $r3, 209($r0)
sw $r4, 210($r0)
sw $r5, 211($r0)

# update x and ys
lw $r6, 219($r0) #x1
addi $r6, $r6, 0
sw $r6, 227($r0)

lw $r7, 220($r0) #y1
addi $r7, $r7, -2
sw $r7, 228($r0)

lw $r8, 221($r0) #x2
addi $r8, $r8, -1
sw $r8, 229($r0)

lw $r9, 222($r0) #y2
addi $r9, $r9, 1
sw $r9, 230($r0)

lw $r10, 223($r0) #x3
addi $r10, $r10, 0
sw $r10, 231($r0)

lw $r11, 224($r0) #y3
addi $r11, $r11, 0
sw $r11, 232($r0)

lw $r12, 225($r0) #x4
addi $r12, $r12, 1
sw $r12, 233($r0)

lw $r13, 226($r0) #y4
addi $r13, $r13, -1
sw $r13, 234($r0)

j collide_detect

RC_L_n3:

# rotate from 4 to 1 
lw $r2, 202($r0)
lw $r3, 203($r0)
lw $r4, 204($r0)
lw $r5, 205($r0)

addi $r2, $r2, 2
addi $r3, $r3, -11
addi $r4, $r4, 0
addi $r5, $r5, 11

# Update roation
addi $r1, $r0, 1
sw $r1, 207($r0)

sw $r2, 208($r0)
sw $r3, 209($r0)
sw $r4, 210($r0)
sw $r5, 211($r0)

# update x and ys
lw $r6, 219($r0) #x1
addi $r6, $r6, 2
sw $r6, 227($r0)

lw $r7, 220($r0) #y1
addi $r7, $r7, 0
sw $r7, 228($r0)

lw $r8, 221($r0) #x2
addi $r8, $r8, -1
sw $r8, 229($r0)

lw $r9, 222($r0) #y2
addi $r9, $r9, -1
sw $r9, 230($r0)

lw $r10, 223($r0) #x3
addi $r10, $r10, 0
sw $r10, 231($r0)

lw $r11, 224($r0) #y3
addi $r11, $r11, 0
sw $r11, 232($r0)

lw $r12, 225($r0) #x4
addi $r12, $r12, 1
sw $r12, 233($r0)

lw $r13, 226($r0) #y4
addi $r13, $r13, 1
sw $r13, 234($r0)

j collide_detect

RC_J:
lw $r1, 201($r0)
addi $r2, $r0, 1
bne $r1, $r2, RC_J_n1

# rotate from 1 to 2 
lw $r2, 202($r0)
lw $r3, 203($r0)
lw $r4, 204($r0)
lw $r5, 205($r0)

addi $r2, $r2, 2
addi $r3, $r3, -9
addi $r4, $r4, 0
addi $r5, $r5, 9

# Update roation
addi $r1, $r0, 2
sw $r1, 207($r0)

sw $r2, 208($r0)
sw $r3, 209($r0)
sw $r4, 210($r0)
sw $r5, 211($r0)

# update x and ys
lw $r6, 219($r0) #x1
addi $r6, $r6, 2
sw $r6, 227($r0)

lw $r7, 220($r0) #y1
addi $r7, $r7, 0
sw $r7, 228($r0)

lw $r8, 221($r0) #x2
addi $r8, $r8, 1
sw $r8, 229($r0)

lw $r9, 222($r0) #y2
addi $r9, $r9, -1
sw $r9, 230($r0)

lw $r10, 223($r0) #x3
addi $r10, $r10, 0
sw $r10, 231($r0)

lw $r11, 224($r0) #y3
addi $r11, $r11, 0
sw $r11, 232($r0)

lw $r12, 225($r0) #x4
addi $r12, $r12, -1
sw $r12, 233($r0)

lw $r13, 226($r0) #y4
addi $r13, $r13, 1
sw $r13, 234($r0)

j collide_detect

RC_J_n1:
addi $r2, $r0, 2
bne $r1, $r2, RC_J_n2
# rotate from 2 to 3 
lw $r2, 202($r0)
lw $r3, 203($r0)
lw $r4, 204($r0)
lw $r5, 205($r0)

addi $r2, $r2, 20
addi $r3, $r3, 11
addi $r4, $r4, 0
addi $r5, $r5, -11

# Update roation
addi $r1, $r0, 3
sw $r1, 207($r0)

sw $r2, 208($r0)
sw $r3, 209($r0)
sw $r4, 210($r0)
sw $r5, 211($r0)

# update x and ys
lw $r6, 219($r0) #x1
addi $r6, $r6, 0
sw $r6, 227($r0)

lw $r7, 220($r0) #y1
addi $r7, $r7, 2
sw $r7, 228($r0)

lw $r8, 221($r0) #x2
addi $r8, $r8, 1
sw $r8, 229($r0)

lw $r9, 222($r0) #y2
addi $r9, $r9, 1
sw $r9, 230($r0)

lw $r10, 223($r0) #x3
addi $r10, $r10, 0
sw $r10, 231($r0)

lw $r11, 224($r0) #y3
addi $r11, $r11, 0
sw $r11, 232($r0)

lw $r12, 225($r0) #x4
addi $r12, $r12, -1
sw $r12, 233($r0)

lw $r13, 226($r0) #y4
addi $r13, $r13, -1
sw $r13, 234($r0)

j collide_detect

RC_J_n2:
addi $r2, $r0, 3
bne $r1, $r2, RC_J_n3

# rotate from 3 to 4
lw $r2, 202($r0)
lw $r3, 203($r0)
lw $r4, 204($r0)
lw $r5, 205($r0)

addi $r2, $r2, -2
addi $r3, $r3, 9
addi $r4, $r4, 0
addi $r5, $r5, -9

# Update roation
addi $r1, $r0, 4
sw $r1, 207($r0)

sw $r2, 208($r0)
sw $r3, 209($r0)
sw $r4, 210($r0)
sw $r5, 211($r0)

# update x and ys
lw $r6, 219($r0) #x1
addi $r6, $r6, -2
sw $r6, 227($r0)

lw $r7, 220($r0) #y1
addi $r7, $r7, 0
sw $r7, 228($r0)

lw $r8, 221($r0) #x2
addi $r8, $r8, -1
sw $r8, 229($r0)

lw $r9, 222($r0) #y2
addi $r9, $r9, 1
sw $r9, 230($r0)

lw $r10, 223($r0) #x3
addi $r10, $r10, 0
sw $r10, 231($r0)

lw $r11, 224($r0) #y3
addi $r11, $r11, 0
sw $r11, 232($r0)

lw $r12, 225($r0) #x4
addi $r12, $r12, 1
sw $r12, 233($r0)

lw $r13, 226($r0) #y4
addi $r13, $r13, -1
sw $r13, 234($r0)

j collide_detect

RC_J_n3:

# rotate from 4 to 1 
lw $r2, 202($r0)
lw $r3, 203($r0)
lw $r4, 204($r0)
lw $r5, 205($r0)

addi $r2, $r2, -20
addi $r3, $r3, -11
addi $r4, $r4, 0
addi $r5, $r5, 11

# Update roation
addi $r1, $r0, 1
sw $r1, 207($r0)

sw $r2, 208($r0)
sw $r3, 209($r0)
sw $r4, 210($r0)
sw $r5, 211($r0)

# update x and ys
lw $r6, 219($r0) #x1
addi $r6, $r6, 0
sw $r6, 227($r0)

lw $r7, 220($r0) #y1
addi $r7, $r7, -2
sw $r7, 228($r0)

lw $r8, 221($r0) #x2
addi $r8, $r8, -1
sw $r8, 229($r0)

lw $r9, 222($r0) #y2
addi $r9, $r9, -1
sw $r9, 230($r0)

lw $r10, 223($r0) #x3
addi $r10, $r10, 0
sw $r10, 231($r0)

lw $r11, 224($r0) #y3
addi $r11, $r11, 0
sw $r11, 232($r0)

lw $r12, 225($r0) #x4
addi $r12, $r12, 1
sw $r12, 233($r0)

lw $r13, 226($r0) #y4
addi $r13, $r13, 1
sw $r13, 234($r0)

j collide_detect

RCCW:

# Load Current Status:
lw $r1, 200($r0)

addi $r2, $r0, 1
bne $r1, $r2, RCC_nI
j RCC_I

RCC_nI:
addi $r2, $r0, 2
bne $r1, $r2, RCC_nO
j delay

RCC_nO:
addi $r2, $r0, 3
bne $r1, $r2, RCC_nS
j RCC_S

RCC_nS:
addi $r2, $r0, 4
bne $r1, $r2, RCC_nZ
j RCC_Z

RCC_nZ:
addi $r2, $r0, 5
bne $r1, $r2, RCC_nT
j RCC_T

RCC_nT:
addi $r2, $r0, 6
bne $r1, $r2, RCC_nL
j RCC_L

RCC_nL:
addi $r2, $r0, 7
bne $r1, $r2, RCC_nJ
j RCC_J

RCC_nJ: 

j delay

RCC_I:
lw $r1, 201($r0)
addi $r2, $r0, 2
bne $r1, $r2, RCC_I_n2

# rotate from 1 to 2
lw $r2, 202($r0)
lw $r3, 203($r0)
lw $r4, 204($r0)
lw $r5, 205($r0)

addi $r2, $r2, -22
addi $r3, $r3, -11
addi $r4, $r4, 0
addi $r5, $r5, 11

# Update roation
addi $r1, $r0, 1
sw $r1, 207($r0)

sw $r2, 208($r0)
sw $r3, 209($r0)
sw $r4, 210($r0)
sw $r5, 211($r0)

# update x and ys
lw $r6, 219($r0) #x1
addi $r6, $r6, -2
sw $r6, 227($r0)

lw $r7, 220($r0) #y1
addi $r7, $r7, -2
sw $r7, 228($r0)

lw $r8, 221($r0) #x2
addi $r8, $r8, -1
sw $r8, 229($r0)

lw $r9, 222($r0) #y2
addi $r9, $r9, -1
sw $r9, 230($r0)

lw $r10, 223($r0) #x3
addi $r10, $r10, 0
sw $r10, 231($r0)

lw $r11, 224($r0) #y3
addi $r11, $r11, 0
sw $r11, 232($r0)

lw $r12, 225($r0) #x4
addi $r12, $r12, 1
sw $r12, 233($r0)

lw $r13, 226($r0) #y4
addi $r13, $r13, 1
sw $r13, 234($r0)

j collide_detect

RCC_I_n2:
addi $r2, $r0, 3
bne $r1, $r2, RCC_I_n3
# rotate from 3 to 2
lw $r2, 202($r0)
lw $r3, 203($r0)
lw $r4, 204($r0)
lw $r5, 205($r0)

addi $r2, $r2, 9
addi $r3, $r3, 0
addi $r4, $r4, -9
addi $r5, $r5, -18

# Update roation
addi $r1, $r0, 2
sw $r1, 207($r0)

sw $r2, 208($r0)
sw $r3, 209($r0)
sw $r4, 210($r0)
sw $r5, 211($r0)

# update x and ys
lw $r6, 219($r0) #x1
addi $r6, $r6, -1
sw $r6, 227($r0)

lw $r7, 220($r0) #y1
addi $r7, $r7, 1
sw $r7, 228($r0)

lw $r8, 221($r0) #x2
addi $r8, $r8, 0
sw $r8, 229($r0)

lw $r9, 222($r0) #y2
addi $r9, $r9, 0
sw $r9, 230($r0)

lw $r10, 223($r0) #x3
addi $r10, $r10, 1
sw $r10, 231($r0)

lw $r11, 224($r0) #y3
addi $r11, $r11, -1
sw $r11, 232($r0)

lw $r12, 225($r0) #x4
addi $r12, $r12, 2
sw $r12, 233($r0)

lw $r13, 226($r0) #y4
addi $r13, $r13, -2
sw $r13, 234($r0)

j collide_detect

RCC_I_n3:
addi $r2, $r0, 4
bne $r1, $r2, RCC_I_n4

# rotate from 4 to 3
lw $r2, 202($r0)
lw $r3, 203($r0)
lw $r4, 204($r0)
lw $r5, 205($r0)

addi $r2, $r2, 22
addi $r3, $r3, 11
addi $r4, $r4, 0
addi $r5, $r5, -11

# Update roation
addi $r1, $r0, 3
sw $r1, 207($r0)

sw $r2, 208($r0)
sw $r3, 209($r0)
sw $r4, 210($r0)
sw $r5, 211($r0)

# update x and ys
lw $r6, 219($r0) #x1
addi $r6, $r6, 2
sw $r6, 227($r0)

lw $r7, 220($r0) #y1
addi $r7, $r7, 2
sw $r7, 228($r0)

lw $r8, 221($r0) #x2
addi $r8, $r8, 1
sw $r8, 229($r0)

lw $r9, 222($r0) #y2
addi $r9, $r9, 1
sw $r9, 230($r0)

lw $r10, 223($r0) #x3
addi $r10, $r10, 0
sw $r10, 231($r0)

lw $r11, 224($r0) #y3
addi $r11, $r11, 0
sw $r11, 232($r0)

lw $r12, 225($r0) #x4
addi $r12, $r12, -1
sw $r12, 233($r0)

lw $r13, 226($r0) #y4
addi $r13, $r13, -1
sw $r13, 234($r0)

j collide_detect

RCC_I_n4:

# rotate from 1 to 4 
lw $r2, 202($r0)
lw $r3, 203($r0)
lw $r4, 204($r0)
lw $r5, 205($r0)

addi $r2, $r2, -9
addi $r3, $r3, 0
addi $r4, $r4, 9
addi $r5, $r5, 18

# Update roation
addi $r1, $r0, 4
sw $r1, 207($r0)

sw $r2, 208($r0)
sw $r3, 209($r0)
sw $r4, 210($r0)
sw $r5, 211($r0)

# update x and ys
lw $r6, 219($r0) #x1
addi $r6, $r6, 1
sw $r6, 227($r0)

lw $r7, 220($r0) #y1
addi $r7, $r7, -1
sw $r7, 228($r0)

lw $r8, 221($r0) #x2
addi $r8, $r8, 0
sw $r8, 229($r0)

lw $r9, 222($r0) #y2
addi $r9, $r9, 0
sw $r9, 230($r0)

lw $r10, 223($r0) #x3
addi $r10, $r10, -1
sw $r10, 231($r0)

lw $r11, 224($r0) #y3
addi $r11, $r11, 1
sw $r11, 232($r0)

lw $r12, 225($r0) #x4
addi $r12, $r12, -2
sw $r12, 233($r0)

lw $r13, 226($r0) #y4
addi $r13, $r13, 2
sw $r13, 234($r0)

j collide_detect

RCC_S:
lw $r1, 201($r0)
addi $r2, $r0, 2
bne $r1, $r2, RCC_S_n2

# rotate from 2 to 21
lw $r2, 202($r0)
lw $r3, 203($r0)
lw $r4, 204($r0)
lw $r5, 205($r0)

addi $r2, $r2, 0
addi $r3, $r3, -10
addi $r4, $r4, -12
addi $r5, $r5, 0

# Update roation
addi $r1, $r0, 1
sw $r1, 207($r0)

sw $r2, 208($r0)
sw $r3, 209($r0)
sw $r4, 210($r0)
sw $r5, 211($r0)

# update x and ys
lw $r6, 219($r0) #x1
addi $r6, $r6, 0
sw $r6, 227($r0)

lw $r7, 220($r0) #y1
addi $r7, $r7, 0
sw $r7, 228($r0)

lw $r8, 221($r0) #x2
addi $r8, $r8, 0
sw $r8, 229($r0)

lw $r9, 222($r0) #y2
addi $r9, $r9, -1
sw $r9, 230($r0)

lw $r10, 223($r0) #x3
addi $r10, $r10, -2
sw $r10, 231($r0)

lw $r11, 224($r0) #y3
addi $r11, $r11, -1
sw $r11, 232($r0)

lw $r12, 225($r0) #x4
addi $r12, $r12, 0
sw $r12, 233($r0)

lw $r13, 226($r0) #y4
addi $r13, $r13, 0
sw $r13, 234($r0)

j collide_detect

RCC_S_n2:
addi $r2, $r0, 3
bne $r1, $r2, RCC_S_n3
# rotate from 3 to 2
lw $r2, 202($r0)
lw $r3, 203($r0)
lw $r4, 204($r0)
lw $r5, 205($r0)

addi $r2, $r2, -20
addi $r3, $r3, 0
addi $r4, $r4, 2
addi $r5, $r5, 0

# Update roation
addi $r1, $r0, 2
sw $r1, 207($r0)

sw $r2, 208($r0)
sw $r3, 209($r0)
sw $r4, 210($r0)
sw $r5, 211($r0)

# update x and ys
lw $r6, 219($r0) #x1
addi $r6, $r6, 0
sw $r6, 227($r0)

lw $r7, 220($r0) #y1
addi $r7, $r7, -2
sw $r7, 228($r0)

lw $r8, 221($r0) #x2
addi $r8, $r8, 0
sw $r8, 229($r0)

lw $r9, 222($r0) #y2
addi $r9, $r9, 0
sw $r9, 230($r0)

lw $r10, 223($r0) #x3
addi $r10, $r10, 2
sw $r10, 231($r0)

lw $r11, 224($r0) #y3
addi $r11, $r11, 0
sw $r11, 232($r0)

lw $r12, 225($r0) #x4
addi $r12, $r12, 0
sw $r12, 233($r0)

lw $r13, 226($r0) #y4
addi $r13, $r13, 0
sw $r13, 234($r0)

j collide_detect

RCC_S_n3:
addi $r2, $r0, 4
bne $r1, $r2, RCC_S_n4

# rotate from 4 to 3
lw $r2, 202($r0)
lw $r3, 203($r0)
lw $r4, 204($r0)
lw $r5, 205($r0)

addi $r2, $r2, 0
addi $r3, $r3, 12
addi $r4, $r4, 10
addi $r5, $r5, 0

# Update roation
addi $r1, $r0, 3
sw $r1, 207($r0)

sw $r2, 208($r0)
sw $r3, 209($r0)
sw $r4, 210($r0)
sw $r5, 211($r0)

# update x and ys
lw $r6, 219($r0) #x1
addi $r6, $r6, 0
sw $r6, 227($r0)

lw $r7, 220($r0) #y1
addi $r7, $r7, 0
sw $r7, 228($r0)

lw $r8, 221($r0) #x2
addi $r8, $r8, 2
sw $r8, 229($r0)

lw $r9, 222($r0) #y2
addi $r9, $r9, 1
sw $r9, 230($r0)

lw $r10, 223($r0) #x3
addi $r10, $r10, 0
sw $r10, 231($r0)

lw $r11, 224($r0) #y3
addi $r11, $r11, 1
sw $r11, 232($r0)

lw $r12, 225($r0) #x4
addi $r12, $r12, 0
sw $r12, 233($r0)

lw $r13, 226($r0) #y4
addi $r13, $r13, 0
sw $r13, 234($r0)

j collide_detect

RCC_S_n4:

# rotate from 1 to 4
lw $r2, 202($r0)
lw $r3, 203($r0)
lw $r4, 204($r0)
lw $r5, 205($r0)

addi $r2, $r2, 20
addi $r3, $r3, -2
addi $r4, $r4, 0
addi $r5, $r5, 0

# Update roation
addi $r1, $r0, 4
sw $r1, 207($r0)

sw $r2, 208($r0)
sw $r3, 209($r0)
sw $r4, 210($r0)
sw $r5, 211($r0)

# update x and ys
lw $r6, 219($r0) #x1
addi $r6, $r6, 0
sw $r6, 227($r0)

lw $r7, 220($r0) #y1
addi $r7, $r7, 2
sw $r7, 228($r0)

lw $r8, 221($r0) #x2
addi $r8, $r8, -2
sw $r8, 229($r0)

lw $r9, 222($r0) #y2
addi $r9, $r9, 0
sw $r9, 230($r0)

lw $r10, 223($r0) #x3
addi $r10, $r10, 0
sw $r10, 231($r0)

lw $r11, 224($r0) #y3
addi $r11, $r11, 0
sw $r11, 232($r0)

lw $r12, 225($r0) #x4
addi $r12, $r12, 0
sw $r12, 233($r0)

lw $r13, 226($r0) #y4
addi $r13, $r13, 0
sw $r13, 234($r0)

j collide_detect

RCC_Z:
lw $r1, 201($r0)
addi $r2, $r0, 2
bne $r1, $r2, RCC_Z_n2

# rotate from 1 to 2 
lw $r2, 202($r0)
lw $r3, 203($r0)
lw $r4, 204($r0)
lw $r5, 205($r0)

addi $r2, $r2, -21
addi $r3, $r3, -1
addi $r4, $r4, 0
addi $r5, $r5, 0

# Update roation
addi $r1, $r0, 1
sw $r1, 207($r0)

sw $r2, 208($r0)
sw $r3, 209($r0)
sw $r4, 210($r0)
sw $r5, 211($r0)

# update x and ys
lw $r6, 219($r0) #x1
addi $r6, $r6, -1
sw $r6, 227($r0)

lw $r7, 220($r0) #y1
addi $r7, $r7, -2
sw $r7, 228($r0)

lw $r8, 221($r0) #x2
addi $r8, $r8, -1
sw $r8, 229($r0)

lw $r9, 222($r0) #y2
addi $r9, $r9, 0
sw $r9, 230($r0)

lw $r10, 223($r0) #x3
addi $r10, $r10, 0
sw $r10, 231($r0)

lw $r11, 224($r0) #y3
addi $r11, $r11, 0
sw $r11, 232($r0)

lw $r12, 225($r0) #x4
addi $r12, $r12, 0
sw $r12, 233($r0)

lw $r13, 226($r0) #y4
addi $r13, $r13, 0
sw $r13, 234($r0)

j collide_detect

RCC_Z_n2:
addi $r2, $r0, 3
bne $r1, $r2, RCC_Z_n3
# rotate from 3 to 2 
lw $r2, 202($r0)
lw $r3, 203($r0)
lw $r4, 204($r0)
lw $r5, 205($r0)

addi $r2, $r2, 0
addi $r3, $r3, -8
addi $r4, $r4, 0
addi $r5, $r5, -10

# Update roation
addi $r1, $r0, 2
sw $r1, 207($r0)

sw $r2, 208($r0)
sw $r3, 209($r0)
sw $r4, 210($r0)
sw $r5, 211($r0)

# update x and ys
lw $r6, 219($r0) #x1
addi $r6, $r6, 0
sw $r6, 227($r0)

lw $r7, 220($r0) #y1
addi $r7, $r7, 0
sw $r7, 228($r0)

lw $r8, 221($r0) #x2
addi $r8, $r8, 2
sw $r8, 229($r0)

lw $r9, 222($r0) #y2
addi $r9, $r9, -1
sw $r9, 230($r0)

lw $r10, 223($r0) #x3
addi $r10, $r10, 0
sw $r10, 231($r0)

lw $r11, 224($r0) #y3
addi $r11, $r11, 0
sw $r11, 232($r0)

lw $r12, 225($r0) #x4
addi $r12, $r12, 0
sw $r12, 233($r0)

lw $r13, 226($r0) #y4
addi $r13, $r13, -1
sw $r13, 234($r0)

j collide_detect

RCC_Z_n3:
addi $r2, $r0, 4
bne $r1, $r2, RCC_Z_n4

# rotate from 4 to 3
lw $r2, 202($r0)
lw $r3, 203($r0)
lw $r4, 204($r0)
lw $r5, 205($r0)

addi $r2, $r2, 1
addi $r3, $r3, 0
addi $r4, $r4, 0
addi $r5, $r5, 21

# Update roation
addi $r1, $r0, 3
sw $r1, 207($r0)

sw $r2, 208($r0)
sw $r3, 209($r0)
sw $r4, 210($r0)
sw $r5, 211($r0)

# update x and ys
lw $r6, 219($r0) #x1
addi $r6, $r6, 1
sw $r6, 227($r0)

lw $r7, 220($r0) #y1
addi $r7, $r7, 0
sw $r7, 228($r0)

lw $r8, 221($r0) #x2
addi $r8, $r8, 0
sw $r8, 229($r0)

lw $r9, 222($r0) #y2
addi $r9, $r9, 0
sw $r9, 230($r0)

lw $r10, 223($r0) #x3
addi $r10, $r10, 0
sw $r10, 231($r0)

lw $r11, 224($r0) #y3
addi $r11, $r11, 0
sw $r11, 232($r0)

lw $r12, 225($r0) #x4
addi $r12, $r12, 1
sw $r12, 233($r0)

lw $r13, 226($r0) #y4
addi $r13, $r13, 2
sw $r13, 234($r0)

j collide_detect

RCC_Z_n4:

# rotate from 1 to 4
lw $r2, 202($r0)
lw $r3, 203($r0)
lw $r4, 204($r0)
lw $r5, 205($r0)

addi $r2, $r2, 20
addi $r3, $r3, 9
addi $r4, $r4, 0
addi $r5, $r5, -11

# Update roation
addi $r1, $r0, 4
sw $r1, 207($r0)

sw $r2, 208($r0)
sw $r3, 209($r0)
sw $r4, 210($r0)
sw $r5, 211($r0)

# update x and ys
lw $r6, 219($r0) #x1
addi $r6, $r6, 0
sw $r6, 227($r0)

lw $r7, 220($r0) #y1
addi $r7, $r7, 2
sw $r7, 228($r0)

lw $r8, 221($r0) #x2
addi $r8, $r8, -1
sw $r8, 229($r0)

lw $r9, 222($r0) #y2
addi $r9, $r9, 1
sw $r9, 230($r0)

lw $r10, 223($r0) #x3
addi $r10, $r10, 0
sw $r10, 231($r0)

lw $r11, 224($r0) #y3
addi $r11, $r11, 0
sw $r11, 232($r0)

lw $r12, 225($r0) #x4
addi $r12, $r12, -1
sw $r12, 233($r0)

lw $r13, 226($r0) #y4
addi $r13, $r13, -1
sw $r13, 234($r0)

j collide_detect

RCC_T:
lw $r1, 201($r0)
addi $r2, $r0, 2
bne $r1, $r2, RCC_T_n2

# rotate from 2 to 1 
lw $r2, 202($r0)
lw $r3, 203($r0)
lw $r4, 204($r0)
lw $r5, 205($r0)

addi $r2, $r2, 0
addi $r3, $r3, -11
addi $r4, $r4, 0
addi $r5, $r5, 0

# Update roation
addi $r1, $r0, 1
sw $r1, 207($r0)

sw $r2, 208($r0)
sw $r3, 209($r0)
sw $r4, 210($r0)
sw $r5, 211($r0)

# update x and ys
lw $r6, 219($r0) #x1
addi $r6, $r6, 0
sw $r6, 227($r0)

lw $r7, 220($r0) #y1
addi $r7, $r7, 0
sw $r7, 228($r0)

lw $r8, 221($r0) #x2
addi $r8, $r8, -1
sw $r8, 229($r0)

lw $r9, 222($r0) #y2
addi $r9, $r9, -1
sw $r9, 230($r0)

lw $r10, 223($r0) #x3
addi $r10, $r10, 0
sw $r10, 231($r0)

lw $r11, 224($r0) #y3
addi $r11, $r11, 0
sw $r11, 232($r0)

lw $r12, 225($r0) #x4
addi $r12, $r12, 0
sw $r12, 233($r0)

lw $r13, 226($r0) #y4
addi $r13, $r13, 0
sw $r13, 234($r0)

j collide_detect

RCC_T_n2:
addi $r2, $r0, 3
bne $r1, $r2, RCC_T_n3
# rotate from 3 to 2
lw $r2, 202($r0)
lw $r3, 203($r0)
lw $r4, 204($r0)
lw $r5, 205($r0)

addi $r2, $r2, -9
addi $r3, $r3, 0
addi $r4, $r4, 0
addi $r5, $r5, 0

# Update roation
addi $r1, $r0, 2
sw $r1, 207($r0)

sw $r2, 208($r0)
sw $r3, 209($r0)
sw $r4, 210($r0)
sw $r5, 211($r0)

# update x and ys
lw $r6, 219($r0) #x1
addi $r6, $r6, 1
sw $r6, 227($r0)

lw $r7, 220($r0) #y1
addi $r7, $r7, -1
sw $r7, 228($r0)

lw $r8, 221($r0) #x2
addi $r8, $r8, 0
sw $r8, 229($r0)

lw $r9, 222($r0) #y2
addi $r9, $r9, 0
sw $r9, 230($r0)

lw $r10, 223($r0) #x3
addi $r10, $r10, 0
sw $r10, 231($r0)

lw $r11, 224($r0) #y3
addi $r11, $r11, 0
sw $r11, 232($r0)

lw $r12, 225($r0) #x4
addi $r12, $r12, 0
sw $r12, 233($r0)

lw $r13, 226($r0) #y4
addi $r13, $r13, 0
sw $r13, 234($r0)

j collide_detect

RCC_T_n3:
addi $r2, $r0, 4
bne $r1, $r2, RCC_T_n4

# rotate from 4 to 3
lw $r2, 202($r0)
lw $r3, 203($r0)
lw $r4, 204($r0)
lw $r5, 205($r0)

addi $r2, $r2, 0
addi $r3, $r3, 0
addi $r4, $r4, 0
addi $r5, $r5, 11

# Update roation
addi $r1, $r0, 3
sw $r1, 207($r0)

sw $r2, 208($r0)
sw $r3, 209($r0)
sw $r4, 210($r0)
sw $r5, 211($r0)

# update x and ys
lw $r6, 219($r0) #x1
addi $r6, $r6, 0
sw $r6, 227($r0)

lw $r7, 220($r0) #y1
addi $r7, $r7, 0
sw $r7, 228($r0)

lw $r8, 221($r0) #x2
addi $r8, $r8, 0
sw $r8, 229($r0)

lw $r9, 222($r0) #y2
addi $r9, $r9, 0
sw $r9, 230($r0)

lw $r10, 223($r0) #x3
addi $r10, $r10, 0
sw $r10, 231($r0)

lw $r11, 224($r0) #y3
addi $r11, $r11, 0
sw $r11, 232($r0)

lw $r12, 225($r0) #x4
addi $r12, $r12, 1
sw $r12, 233($r0)

lw $r13, 226($r0) #y4
addi $r13, $r13, 1
sw $r13, 234($r0)

j collide_detect

RCC_T_n4:

# rotate from 1 to 4
lw $r2, 202($r0)
lw $r3, 203($r0)
lw $r4, 204($r0)
lw $r5, 205($r0)

addi $r2, $r2, 9
addi $r3, $r3, 11
addi $r4, $r4, 0
addi $r5, $r5, -11

# Update roation
addi $r1, $r0, 4
sw $r1, 207($r0)

sw $r2, 208($r0)
sw $r3, 209($r0)
sw $r4, 210($r0)
sw $r5, 211($r0)

# update x and ys
lw $r6, 219($r0) #x1
addi $r6, $r6, -1
sw $r6, 227($r0)

lw $r7, 220($r0) #y1
addi $r7, $r7, 1
sw $r7, 228($r0)

lw $r8, 221($r0) #x2
addi $r8, $r8, 1
sw $r8, 229($r0)

lw $r9, 222($r0) #y2
addi $r9, $r9, 1
sw $r9, 230($r0)

lw $r10, 223($r0) #x3
addi $r10, $r10, 0
sw $r10, 231($r0)

lw $r11, 224($r0) #y3
addi $r11, $r11, 0
sw $r11, 232($r0)

lw $r12, 225($r0) #x4
addi $r12, $r12, -1
sw $r12, 233($r0)

lw $r13, 226($r0) #y4
addi $r13, $r13, -1
sw $r13, 234($r0)

j collide_detect

RCC_L:
lw $r1, 201($r0)
addi $r2, $r0, 2
bne $r1, $r2, RCC_L_n2

# rotate from 2 to 1
lw $r2, 202($r0)
lw $r3, 203($r0)
lw $r4, 204($r0)
lw $r5, 205($r0)

addi $r2, $r2, -20
addi $r3, $r3, 9
addi $r4, $r4, 0
addi $r5, $r5, -9

# Update roation
addi $r1, $r0, 1
sw $r1, 207($r0)

sw $r2, 208($r0)
sw $r3, 209($r0)
sw $r4, 210($r0)
sw $r5, 211($r0)

# update x and ys
lw $r6, 219($r0) #x1
addi $r6, $r6, 0
sw $r6, 227($r0)

lw $r7, 220($r0) #y1
addi $r7, $r7, -2
sw $r7, 228($r0)

lw $r8, 221($r0) #x2
addi $r8, $r8, -1
sw $r8, 229($r0)

lw $r9, 222($r0) #y2
addi $r9, $r9, 1
sw $r9, 230($r0)

lw $r10, 223($r0) #x3
addi $r10, $r10, 0
sw $r10, 231($r0)

lw $r11, 224($r0) #y3
addi $r11, $r11, 0
sw $r11, 232($r0)

lw $r12, 225($r0) #x4
addi $r12, $r12, 1
sw $r12, 233($r0)

lw $r13, 226($r0) #y4
addi $r13, $r13, -1
sw $r13, 234($r0)

j collide_detect

RCC_L_n2:
addi $r2, $r0, 3
bne $r1, $r2, RCC_L_n3
# rotate from 3 to 2
lw $r2, 202($r0)
lw $r3, 203($r0)
lw $r4, 204($r0)
lw $r5, 205($r0)

addi $r2, $r2, 2
addi $r3, $r3, -11
addi $r4, $r4, 0
addi $r5, $r5, 11

# Update roation
addi $r1, $r0, 2
sw $r1, 207($r0)

sw $r2, 208($r0)
sw $r3, 209($r0)
sw $r4, 210($r0)
sw $r5, 211($r0)

# update x and ys
lw $r6, 219($r0) #x1
addi $r6, $r6, 2
sw $r6, 227($r0)

lw $r7, 220($r0) #y1
addi $r7, $r7, 0
sw $r7, 228($r0)

lw $r8, 221($r0) #x2
addi $r8, $r8, -1
sw $r8, 229($r0)

lw $r9, 222($r0) #y2
addi $r9, $r9, -1
sw $r9, 230($r0)

lw $r10, 223($r0) #x3
addi $r10, $r10, 0
sw $r10, 231($r0)

lw $r11, 224($r0) #y3
addi $r11, $r11, 0
sw $r11, 232($r0)

lw $r12, 225($r0) #x4
addi $r12, $r12, 1
sw $r12, 233($r0)

lw $r13, 226($r0) #y4
addi $r13, $r13, 1
sw $r13, 234($r0)

j collide_detect

RCC_L_n3:
addi $r2, $r0, 4
bne $r1, $r2, RCC_L_n4

# rotate from 4 to 3
lw $r2, 202($r0)
lw $r3, 203($r0)
lw $r4, 204($r0)
lw $r5, 205($r0)

addi $r2, $r2, 20
addi $r3, $r3, -9
addi $r4, $r4, 0
addi $r5, $r5, 9

# Update roation
addi $r1, $r0, 3
sw $r1, 207($r0)

sw $r2, 208($r0)
sw $r3, 209($r0)
sw $r4, 210($r0)
sw $r5, 211($r0)

# update x and ys
lw $r6, 219($r0) #x1
addi $r6, $r6, 0
sw $r6, 227($r0)

lw $r7, 220($r0) #y1
addi $r7, $r7, 2
sw $r7, 228($r0)

lw $r8, 221($r0) #x2
addi $r8, $r8, 1
sw $r8, 229($r0)

lw $r9, 222($r0) #y2
addi $r9, $r9, -1
sw $r9, 230($r0)

lw $r10, 223($r0) #x3
addi $r10, $r10, 0
sw $r10, 231($r0)

lw $r11, 224($r0) #y3
addi $r11, $r11, 0
sw $r11, 232($r0)

lw $r12, 225($r0) #x4
addi $r12, $r12, -1
sw $r12, 233($r0)

lw $r13, 226($r0) #y4
addi $r13, $r13, 1
sw $r13, 234($r0)

j collide_detect

RCC_L_n4:

# rotate from 1 to 4
lw $r2, 202($r0)
lw $r3, 203($r0)
lw $r4, 204($r0)
lw $r5, 205($r0)

addi $r2, $r2, -2
addi $r3, $r3, 11
addi $r4, $r4, 0
addi $r5, $r5, -11

# Update roation
addi $r1, $r0, 4
sw $r1, 207($r0)

sw $r2, 208($r0)
sw $r3, 209($r0)
sw $r4, 210($r0)
sw $r5, 211($r0)

# update x and ys
lw $r6, 219($r0) #x1
addi $r6, $r6, -2
sw $r6, 227($r0)

lw $r7, 220($r0) #y1
addi $r7, $r7, 0
sw $r7, 228($r0)

lw $r8, 221($r0) #x2
addi $r8, $r8, 1
sw $r8, 229($r0)

lw $r9, 222($r0) #y2
addi $r9, $r9, 1
sw $r9, 230($r0)

lw $r10, 223($r0) #x3
addi $r10, $r10, 0
sw $r10, 231($r0)

lw $r11, 224($r0) #y3
addi $r11, $r11, 0
sw $r11, 232($r0)

lw $r12, 225($r0) #x4
addi $r12, $r12, -1
sw $r12, 233($r0)

lw $r13, 226($r0) #y4
addi $r13, $r13, -1
sw $r13, 234($r0)

j collide_detect

RCC_J:
lw $r1, 201($r0)
addi $r2, $r0, 2
bne $r1, $r2, RCC_J_n2

# rotate from 1 to 2 
lw $r2, 202($r0)
lw $r3, 203($r0)
lw $r4, 204($r0)
lw $r5, 205($r0)

addi $r2, $r2, -2
addi $r3, $r3, 9
addi $r4, $r4, 0
addi $r5, $r5, -9

# Update roation
addi $r1, $r0, 1
sw $r1, 207($r0)

sw $r2, 208($r0)
sw $r3, 209($r0)
sw $r4, 210($r0)
sw $r5, 211($r0)

# update x and ys
lw $r6, 219($r0) #x1
addi $r6, $r6, -2
sw $r6, 227($r0)

lw $r7, 220($r0) #y1
addi $r7, $r7, 0
sw $r7, 228($r0)

lw $r8, 221($r0) #x2
addi $r8, $r8, -1
sw $r8, 229($r0)

lw $r9, 222($r0) #y2
addi $r9, $r9, 1
sw $r9, 230($r0)

lw $r10, 223($r0) #x3
addi $r10, $r10, 0
sw $r10, 231($r0)

lw $r11, 224($r0) #y3
addi $r11, $r11, 0
sw $r11, 232($r0)

lw $r12, 225($r0) #x4
addi $r12, $r12, 1
sw $r12, 233($r0)

lw $r13, 226($r0) #y4
addi $r13, $r13, -1
sw $r13, 234($r0)

j collide_detect

RCC_J_n2:
addi $r2, $r0, 3
bne $r1, $r2, RCC_J_n3
# rotate from 3 to 2
lw $r2, 202($r0)
lw $r3, 203($r0)
lw $r4, 204($r0)
lw $r5, 205($r0)

addi $r2, $r2, -20
addi $r3, $r3, -11
addi $r4, $r4, 0
addi $r5, $r5, 11

# Update roation
addi $r1, $r0, 2
sw $r1, 207($r0)

sw $r2, 208($r0)
sw $r3, 209($r0)
sw $r4, 210($r0)
sw $r5, 211($r0)

# update x and ys
lw $r6, 219($r0) #x1
addi $r6, $r6, 0
sw $r6, 227($r0)

lw $r7, 220($r0) #y1
addi $r7, $r7, -2
sw $r7, 228($r0)

lw $r8, 221($r0) #x2
addi $r8, $r8, -1
sw $r8, 229($r0)

lw $r9, 222($r0) #y2
addi $r9, $r9, -1
sw $r9, 230($r0)

lw $r10, 223($r0) #x3
addi $r10, $r10, 0
sw $r10, 231($r0)

lw $r11, 224($r0) #y3
addi $r11, $r11, 0
sw $r11, 232($r0)

lw $r12, 225($r0) #x4
addi $r12, $r12, 1
sw $r12, 233($r0)

lw $r13, 226($r0) #y4
addi $r13, $r13, 1
sw $r13, 234($r0)

j collide_detect

RCC_J_n3:
addi $r2, $r0, 4
bne $r1, $r2, RCC_J_n4

# rotate from 4 to 3
lw $r2, 202($r0)
lw $r3, 203($r0)
lw $r4, 204($r0)
lw $r5, 205($r0)

addi $r2, $r2, 2
addi $r3, $r3, -9
addi $r4, $r4, 0
addi $r5, $r5, 9

# Update roation
addi $r1, $r0, 3
sw $r1, 207($r0)

sw $r2, 208($r0)
sw $r3, 209($r0)
sw $r4, 210($r0)
sw $r5, 211($r0)

# update x and ys
lw $r6, 219($r0) #x1
addi $r6, $r6, 2
sw $r6, 227($r0)

lw $r7, 220($r0) #y1
addi $r7, $r7, 0
sw $r7, 228($r0)

lw $r8, 221($r0) #x2
addi $r8, $r8, 1
sw $r8, 229($r0)

lw $r9, 222($r0) #y2
addi $r9, $r9, -1
sw $r9, 230($r0)

lw $r10, 223($r0) #x3
addi $r10, $r10, 0
sw $r10, 231($r0)

lw $r11, 224($r0) #y3
addi $r11, $r11, 0
sw $r11, 232($r0)

lw $r12, 225($r0) #x4
addi $r12, $r12, -1
sw $r12, 233($r0)

lw $r13, 226($r0) #y4
addi $r13, $r13, 1
sw $r13, 234($r0)

j collide_detect

RCC_J_n4:

# rotate from 1 to 4 
lw $r2, 202($r0)
lw $r3, 203($r0)
lw $r4, 204($r0)
lw $r5, 205($r0)

addi $r2, $r2, 20
addi $r3, $r3, 11
addi $r4, $r4, 0
addi $r5, $r5, -11

# Update roation
addi $r1, $r0, 4
sw $r1, 207($r0)

sw $r2, 208($r0)
sw $r3, 209($r0)
sw $r4, 210($r0)
sw $r5, 211($r0)

# update x and ys
lw $r6, 219($r0) #x1
addi $r6, $r6, 0
sw $r6, 227($r0)

lw $r7, 220($r0) #y1
addi $r7, $r7, 2
sw $r7, 228($r0)

lw $r8, 221($r0) #x2
addi $r8, $r8, 1
sw $r8, 229($r0)

lw $r9, 222($r0) #y2
addi $r9, $r9, 1
sw $r9, 230($r0)

lw $r10, 223($r0) #x3
addi $r10, $r10, 0
sw $r10, 231($r0)

lw $r11, 224($r0) #y3
addi $r11, $r11, 0
sw $r11, 232($r0)

lw $r12, 225($r0) #x4
addi $r12, $r12, -1
sw $r12, 233($r0)

lw $r13, 226($r0) #y4
addi $r13, $r13, -1
sw $r13, 234($r0)

j collide_detect

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


