**Tetris**

**Overview**

Tetris is a puzzle video game created in 1985 by Alexey Pajitnov, a Soviet software engineer. In Tetris, players complete lines by moving differently shaped pieces (tetrominoes), which descend onto the playing field. The completed lines disappear and grant the player points, and the player can proceed to fill the vacated spaces. The game ends when the uncleared lines reach the top of the playing field. 

In the project, the goal was to create an arcade style Tetris game in MIPS and Verilog code using the processor that I spent the first half of the semester building. The minimum viable product (MVP) was to create a functioning 1-player Tetris with scoring but without special features like piece lookahead, piece holding, or an illustration of where the block will fall. By the end of the project, I was able to achieve this and more. The final game is a fully functioning 1-player version of Tetris with scoring, piece lookahead, piece holding, and speed ramping. On the hardware side of things, the project resembles an old arcade machine made entirely out of acrylic that can fully encapsulate all hardware components including the FPGA, monitor, buttons, and wiring, with a small hole out the back for the power cords to connect to outlets. To play the game, users simply upload the bitstream and press the small green play button. Users can move their piece with a joystick left and right, as well as soft down (which will speed up the rate at which the block falls) by moving the joystick down, and hard down (which will instantly drop the block to the bottom) by moving the joystick up. Users can rotate left and rotate right with two separate buttons, as well as hold a piece with a third button. If users want to restart the game, they simply press the play/reset button and start again.

**Final Product**

Below is a picture of the final product. As shown, scoring is tracked in the top left of the screen, the next 5 pieces are shown on the right side, the hold piece area is located in the bottom left, and the playing area is in the center. 

**I/O**

_Inputs:_

The 8 inputs for the project include the joystick (up, down, left, right), start/reset button, rotate clockwise button, rotate counterclockwise button, and hold button. Up on the joystick represented “hard down” and down on the joystick represented “soft down”. This lined up perfectly for the FPGA board’s JB pins as shown in the image below sourced from the [FPGA reference manual](https://digilent.com/reference/programmable-logic/nexys-a7/reference-manual). Pins 1-4 on the top row held up, right, down, and left respectively. Pins 7-10 on the bottom row held rotate clockwise, rotate counterclockwise, hold, and reset/play respectively.![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXckTa05sA7Ixz9KKZM3wg0yfvr6-IT5ylNN_YUZBcS66RVYEBm0QLk1ilM5euACKUpn9_Ba8cS04d_Z_1d2gnMi81nePBF1URe9aqYy_fNWUDeaQGcYqnZNpZTeRiUFBIArP5nuvFpuvZ5JrV2PyU4s5jp8?key=-tiBekxC8hwLrxlwoHnHNQ)

_Outputs:_ 

The only functional output was the TOGUARD Monitor, though I did use the FPGA onboard LEDs throughout the project for testing.

**Hardware**

_Materials_

- 1 Nexys-A7 FPGA Board

- 1 TOGUARD D701 7" Monitor Display

- 6 1’x2’ sheets of 1.5mm thick acrylic

- 3 large buttons with LEDs

- 1 small button with LEDs

- 1 eight directional joystick

- 1 protoboard

- 8 10kΩ resistors

- 3 100Ω resistors

- Several solid-core wires

In regards to the arcade machine, I knew it needed to be machined in some regard so the build would be perfectly precise, so I first planned everything out on an iPad to determine the exact lengths and angles at which the pieces would be cut so they would all fit together. ![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXd9S9yU_LlWmHfeHEoMXgjcqqHMrzhIPQJr9UojX4hqF9L3cj9GwfbkGNNLqo55TG1UzIQWM-Ho90iRMY7sb9Nqd_ZriBpdCv1ArRbHnvGQYllB6NTfK6GiCNsAWDUvi657Ln2sAiiWDnz367uXjC8mYldV?key=-tiBekxC8hwLrxlwoHnHNQ)![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXdDZ5yRQ5jhbRaISh1t0bh6bVflHPqf3lbZZ2KfCvkcbAmD4eRZhneFiyBrw3LcsMEw2GWl8cx_ylAOr-r1r5Q9TRFu8Ho8IKfDBaihV3nfeoHHA5FMV7z0X6Bw-OhAg3sCnm8qg_l722VYRlcBaDHfpw_I?key=-tiBekxC8hwLrxlwoHnHNQ)

The original idea was to 3D print the box, but I quickly realized no printer bed was large enough to print many of the surfaces in one continuous piece, so designing pieces to ensure they would fit together became too complex. The next idea was to laser cut the pieces out of acrylic. This would provide strength, durability, waterproof ability, and large enough sheets to print each surface continuously. 

Before beginning, I did an initial prototype out of cardboard to double check the measurements, and get a feel for how it would look. 

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXdGViYtxUJxX2AE5QzA9NNhm9yUajAG7fvCt--5JAxOF3TFQCTTEmCT9dtbjTkfcYHuq2oP1Q0I9-3-GmxUW-v1sTsXLA5ngKf-24WVPBQk76v22kMq6ogzfhEoIPDapcxGBpPYsCJeNq1j21Oni8RR1CWO?key=-tiBekxC8hwLrxlwoHnHNQ)![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXcPjiq39v-1DkerCMgrKfPH5q0wPS5k0tcppFtoMPJusXJL4cFS31nfIlaQS2PuE0sqCdmp9KXzJ3HQBo443HqHOqI_oXF_kxW1g4kbDClm6me3vnwvGIcMSNgX0i7q55HQZDJn2A_lwmYNMk4dc7eU0l3z?key=-tiBekxC8hwLrxlwoHnHNQ)![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXfmKBxKCGbYubiq-jnnhJL6xTK7M_hZBUGto9lw62i2WtLS2T7iQIYpSvlmUDMVqb6hEuJXgVC9InnkKrxivxCRaTApt2knbLiW8ooT6IcKDsaP2yYoYEfkhkP3dyxtuXhzkHOPn_6ghVJAIKrxhKpv_2_q?key=-tiBekxC8hwLrxlwoHnHNQ)

→                                                        →  __

After creating the box, I realized that I hadn’t factored in the width of the material into the length of the dimensions. This was an important discovery and helped fix the designs before sending it to the laser cutter to make the final prints out of acrylic. I initially planned for 3mm thick side lengths, but since the lab only had 1.5mm thick sheets, I cut double of every piece needed and glued them together with acrylic glue to form a double thick piece. This resulted in much sturdier components, and also some cool fractal patterns formed by the air bubbles left behind in the unprofessionally done glue job. 

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXesgVm-ltABaWYNJpbTmf2fM9y4N7bsIrn34MY6OOYoq4kt4TIwMTsERu4jMuPVxl4zkJ3NzN-ntYa6AkojsIP9awThXdyxJZiEUTiUc9ajj4CoONiL-sbq2QOclR4GGHmdn1EzXa98U3MQdPpCvfLEpybV?key=-tiBekxC8hwLrxlwoHnHNQ)![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXfvM3SguUXJkjMX61SoJTelNqNJTVLyy0G9ixIDih7JAI0I_RuXYCJMWsS63NfGjWqiTrSsv8gsMzlBuG6h2DRfisNvILYKOt8SSQkRtzKEYd7g0Ph1z5YZpyMPfH0-UOUKp_xyYCP3VUhL9GjAsadM60As?key=-tiBekxC8hwLrxlwoHnHNQ)

Along the way numerous challenges were encountered. The first one was how to support the control panel, as it was likely to hold most of the weight of the users hands resting on it as they used the controls, pressed in buttons, and moved around the joystick. I thought about hot gluing angle brackets to the bottom of the panel so it could be supported by the side panel, but after using the acrylic weld glue, I found it was extremely strong. As a solvent-based glue, it works by softening and weakening the surfaces of the two acrylic plastic pieces to form a chemical bond between the two surfaces. Another challenge I faced was how to fasten the joystick to the control panel. In order for easy operation of the relatively heavy joystick, it needed to be securely fastened. Instead of recutting a new control panel to fit screws in, I was able to throw it back into the laser cutter, align it with the on-board camera, and cut 4 evenly spaced holes allowing me to put screws fastened with wing nuts in to secure the joystick. 

_Circuitry_

The project contained two circuits, one for inputs and one for LEDs.

As seen above, the first circuit was each of the eight inputs (being four limit switches in the joystick and four push buttons) connected to a pulldown network of 10 kΩ resistors. 3.3V were run from one of the onboard Nexys A7 Pmod ports to a rail and into one end of each of the switches and buttons. The other end of each button and switch were connected to a ground rail through a 10 kΩ resistor, which came from one of the ground pins of the Pmod port. Then, to actually get inputs, another wire was connected to the resistor side of each switch and button that connected to one of the 8 input pins on the Pmod port. I first tested this circuit on a lab breadboard, before soldering it together on a protoboard for better durability.

****

********The second circuit was much more straightforward and was used to provide power to the embedded LEDs in the four push buttons. I chained three 100 Ω resistors in series into each of the positive sides of the LEDs before connecting the negative sides to ground. In this circuit though, voltage and ground were supplied to the circuit from a 5V AC/DC wall adapter, and this proved to be a simple solution.

********

**Software**

All code, both Verilog and MIPS, can be accessed in this repository: 

<https://github.com/georgefang13/TetrisFPGA> 

_Verilog:_

____In addition to all processor and helper modules, the highest-level Verilog file for the project is called “[tetris\_wrapper.v](https://gitlab.oit.duke.edu/lja26/tetris/-/blob/main/tetris_wrapper.v?ref_type=heads)” in the repository. 

I used the wrapper file to import both user inputs and random numbers into the processor. To do this, the wrapper uses a ternary operator to control the “regA” inputs into the processor. When the processor requests $r27, the wrapper will manually insert the current input state based on a hierarchy of inputs. When the processor requests $r28, the wrapper will manually insert a random number from a fibonacci LFSR (seen left), seeded with input OxACE1 for the maximum length of the random sequence before it repeats. The game score was also processed this way, where when the processor would write to $r24, the wrapper would grab that value and store it in an external register for easy access. To display the score, I built a module that uses the Double Dabble Algorithm to convert the score register to many registers that correspond to the each place value in decimal. ![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXfaajwWP5diVBWNcAUhLdgpw3LC69ZXgbi6XImV66wGgyd5xwkbD0TScuG2zBsvQ7kAmMCzM8T0U7pC1UirUMyiEpyb2ixrHJGe_PJ-KV8DEbv6PBgJcd1OEu9xPh_e33HMTe1yGs9f6nq7AL_rJiYsueUZ?key=-tiBekxC8hwLrxlwoHnHNQ)

Below is the software implementation of the user inputs, random numbers, and the game score.

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXfmDTNW1l1etn7yxInhI-dhk9Ph6JSOhLRUYnpPqt1JvLaDgdvXJHP2yYeNhWvfusnLRKmZxOgOfKyOEZ1fXVlcVbRg1i4FQR59771hydM9oDs9PKSozinK04jrBIDq-VYw7IiSITF8tx6o_xjm2hcVY-c?key=-tiBekxC8hwLrxlwoHnHNQ)

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXcyB8M4y_nAT0u5JYz-k0cJJqGbg3-YZr1gJbjbeFFaAlzq60pq3gR4P-lOguEt9Frmz3AFrBBdZvxCcSzghMSskZEoikbQTsmgdzIBt9QgHT_QsMWF5x53zDvCQb-dWgHcJ5sIn8kKKYWTgtbBIXEJl04H?key=-tiBekxC8hwLrxlwoHnHNQ)

The game uses memory to track and display the game state. Memory addresses 0-199 correspond to the 200 slots on the game board, where the memory address can be calculated with ten times the y-coordinate plus the x-coordinate of the game slot. On the wrapper side, as the VGA timing generator sweeps the screen, the wrapper uses the x and y-coordinates of the pixel to check if it is in the game board, and, if so, it calculates which game slot the current pixel corresponds to. Then, as long as the processor is not currently loading from or storing to memory, the wrapper accesses that location in memory and grabs the first 3 bits of the word. Each number 1-7 maps to a specific color, representing a tetris piece, and 0 represents black, or an empty slot. I used an identical approach for implementing the next and hold boxes on the screen, treating each like a mini-game board at specific locations in memory. 

_MIPS:_

The MIPS file that runs the game is called “[tetris.s](https://gitlab.oit.duke.edu/lja26/tetris/-/blob/main/tetris.s?ref_type=heads)” in the repository. The first step taken with the MIPS was to ensure it was correctly receiving user inputs and random numbers from the wrapper. In code, this simply looks like adding the value of register 27/28 to register 0 and storing it in a different register for analysis. 

To turn a random number into a random piece on the board, the code parses the random number, with each value 1-7 corresponding to one of the 7 pieces (I also mapped the 0 value to an “I” piece, as this increased the odds of the piece spawning for more fun gameplay). The game will then add 8 to the random value, or 9 in the 0 case, and store this value in each of the four locations in memory corresponding to the piece’s spawn location (the reasoning for this will be described below). 

To update the game, the processor will wait for 100 milliseconds before checking for inputs. If there are no inputs, the game simply waits for another cycle. Based on the score of the game, the game will also make the piece fall every _n_ cycles, starting at 10 and reaching 1 at extremely high scores. To track the current piece, the processor stores, in memory, the “active” piece’s type, rotation state, all four memory addresses, and the x and y-coordinates of each of the four blocks. To implement falls and allow for all movement, the game also has a space in memory for the “next” state that holds all the same values that the current state does. 

For a fall, the game will simply add 1 to each stored y-coordinate and 10 to each memory location and store these values, along with the other unedited values like rotation and x-coordinates, in the next state. Falling has its own collision detection function: I load out the intended next state, first ensure that the memory address is still on the board, then load out each of the next intended game slots from the game board. If this value is 0, then the square is empty and good to be moved into. If the value is greater than 7, then I know that this is the active piece itself and thus it is not a collision. This is why 8 is added to the piece value, as it allows the code to detect if a piece is stationary or active while the wrapper is none the wiser, as it uses only the first 3 bits of the piece value to determine color. 

If the fall check succeeds, the game renders out the new state, writing the next state to the current state, wiping the old state from the game board and writing the new state over it. If the check fails, the current state is re-stored exactly where it currently is, but with each piece value subtracted by 8 to indicate that the piece is now dead, and then spawns a new piece. 

For a move left or right, the game adds or subtracts one to both the x-coordinates and the memory address and stores it in the next state. For the rotations, the bulk of the code, the code will parse what the active piece is and what its rotation state is. Once this is known, the processor will jump to the corresponding CCW or CW rotation function for this piece in this rotation state. These are simply calculated updates to each x-coordinate, y-coordinate, and memory address, which are stored in the next state with the new rotation value. Once each of these user movements are stored in the next state, they all call the general collision detection function. 

This function simply checks to ensure that none of the new x or y-coordinates are outside of their bounds of \[0, 9] and \[0, 19] respectively, before checking the game board to ensure that the movement is not colliding with a stationary piece on the board as described above. If any of these fail, the next state is not used and the processor simply waits for a new input. If all checks pass, then the next state is rendered as described above in the fall section. 

Lastly, I made small but important features like checking for a failed game and line clearing. The game will stop when there is an inactive piece in the spawn region and will stay frozen in its final state until the reset button is pressed. To check for line clearance, each row on the board is scanned before a new piece is spawned, and if there are no empty squares in the row, a counter will be incremented and all pieces above this line are shifted down one row. Once at the bottom of the board, the counter value (between 0 and 4) is converted to a value to be added to the score. 

**Processor Changes**

There was only one processor change implemented. Early on, I found that successive load-word and store-word instructions on the same register would trigger an incorrect bypass. This was a simple fix, as there was just an extraneous bypass condition that was incorrect. Once this condition was taken out, the processor was working as intended. 

Later on in the project, I found that loading a word from memory before parsing it with a branch-not-equal instruction also caused an incorrect bypass. However, this sequence of instructions only came up once in the MIPS, and I decided to just put 3 NOPs between these instructions rather than meddling with the processor at such a late stage of the project.

**Testing** ![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXf3uIkKpDFULqO8WUh58eFdcoAcQYV9fnrnoyYwKP0WLkXy-3QZwws18PbqXvQqeNrHQBGXz7zD5yuBcdSNx3_Rz_k9PQJA4BmNBhg2pQ_Es_NZRPQmamN2QEvNLSFLMkuHHiOwa9Z0Zdby61KA6QV0xqcu?key=-tiBekxC8hwLrxlwoHnHNQ)

In order to test, I employed a few different methods. The easiest method was to simply play the game and see if I could identify any recurring/reproducible problems. For example, 

when rotation for the cyan piece was first implemented, I saw the piece would split in diagonals as shown in the image to the right, instead of oscillating between a vertical line and horizontal line in the correct implementation. In the implementation, when a user rotates, the rotation state (1 through 4) is updated/incremented, and the correct math is applied to each block based on the current rotation state moving each block to the correct memory location. What I didn’t realize, is that during a failed rotation (if it is against a wall and a rotation isn’t valid), the user’s press still updated the rotation state incrementing it when the block didn’t actually rotate, so the next time the user rotated, if it was valid, the math being applied to each block would be for the wrong rotation state. Through game play and by looking at the piece, I were able to see what math was being applied and determine the error. 

Another method I employed was assigning the onboard FPGA LEDs to user inputs. This was especially helpful in the beginning when I wanted to determine if an error was due to a hardware or software issue. An example of this was when I first implemented left and right movement, I wanted to make sure the joystick was receiving inputs, and the lack of block movement wasn’t because of a wiring issue. While this method doesn’t identify the issue all the time, it helped narrow down where to look for the issue. As time progressed, I learned to proactively assign LEDs to certain registers so I could narrow down issues without having to rerun the code twice in the event that errors occurred (this saved a lot of time as each upload would take \~5-10 minutes). 

In general, I became more systematic with testing, being careful to upload tests concurrently with uploading coding changes. I also tried my best to upload in small chunks so if something went wrong, I could point to the last 10-20 lines of code that was just written and isolate where the problem could possibly stem from. I also made sure to commit and push changes after each major breakthrough so if anything in the future went wildly wrong, I had a good checkpoint to revert back to. 

**Conclusion and Future Work**

Overall, I am very proud of how the final project turned out and feel almost all of the goals that were initially set were met. One feature I thought I was going to include but ended up not including was the illustration of where the block would fall. All of the logic needed to implement this feature is pretty much done since hard drop works, but I decided that the game might be too easy with this feature. Also in the spirit of replicating the oldest version of tetris I didn’t include this feature. If I find ways to make the game harder to play in the future like ramping up the speed sooner in the game, I may consider adding this feature. 

While the game is almost perfectly functioning as is, there are a few known bugs that tend to happen the longer you play the game. If a user rotates a piece and then quickly moves it over a solid piece, at high game speeds there is a small chance it falls through the block, wiping out all blocks until it hits the bottom. In some cases, it goes through the bottom and the “disappeared” pieces may spawn on other random parts of the screen. If they spawn in or near the new piece spawn zone, the game will end. I also noticed that this has a higher likelihood of happening to cyan pieces, though I am not entirely sure why.

There are also several things I didn’t get to that given more time in the future I would love to add. I play a lot of two player tetris online together, so in the future I would love to implement a two player version. The simplest way of doing this looks like building a duplicate box with another FPGA and monitor, and simply connecting some input on the two FPGA boards to each other with a wire. Then, when another player clears a line, it would send a line to the other player’s screen like an “attack”. This could be developed further to create combo attacks where multiple lines cleared in succession, or an all clear on the screen would send multiple lines and even more “attacks”. Another thing I wished to implement was sound effects. This would be a great challenge for future work that is very doable, and would add another layer of sophistication to the project.
