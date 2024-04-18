`timescale 1ns / 1ps
/**
 * 
 * READ THIS DESCRIPTION:
 *
 * This is the Wrapper module that will serve as the header file combining your processor, 
 * RegFile and Memory elements together.
 *
 * This file will be used to generate the bitstream to upload to the FPGA.
 * We have provided a sibling file, Wrapper_tb.v so that you can test your processor's functionality.
 * 
 * We will be using our own separate Wrapper_tb.v to test your code. You are allowed to make changes to the Wrapper files 
 * for your own individual testing, but we expect your final processor.v and memory modules to work with the 
 * provided Wrapper interface.
 * 
 * Refer to Lab 5 documents for detailed instructions on how to interface 
 * with the memory elements. Each imem and dmem modules will take 12-bit 
 * addresses and will allow for storing of 32-bit values at each address. 
 * Each memory module should receive a single clock. At which edges, is 
 * purely a design choice (and thereby up to you). 
 * 
 * You must change line 36 to add the memory file of the test you created using the assembler
 * For example, you would add sample inside of the quotes on line 38 after assembling sample.s
 *
 **/

module Wrapper (
    input clk_100mhz,
    input [10:1] JB,
    input BTNL,
    output reg [15:0] LED,
    output hSync, 		// H Sync Signal
	output vSync, 		// Veritcal Sync Signal
	output[3:0] VGA_R,  // Red Signal Bits
	output[3:0] VGA_G,  // Green Signal Bits
	output[3:0] VGA_B  // Blue Signal clk_50mhz
	);
    
    wire clock, reset;
    assign clock = clk_50mhz;
//    assign clock = BTNL;
//    assign reset = JB[10]; 
    assign reset = 1'b0;
   
	wire rwe, mwe, isLWSW;
	wire[4:0] rd, rs1, rs2;
	wire[31:0] instAddr, instData, 
		rData, regA, regB,
		memAddr, memDataIn, memDataOut,
		cpu_regA, cpu_regB;
		
    // 50 MHz clock
    wire clk_50mhz, locked;
    clk_wiz_0 pll(
        // Clock out ports
        .clk_out1(clk_50mhz),
        // Status and control signals
        .reset(1'b0),
        .locked(locked),
        // Clock in ports
        .clk_in1(clk_100mhz)
    );
    
    // Input Indicators
   always @(posedge clock) begin
       LED[0] <= JB[1]; // Up
       LED[1] <= JB[2]; // Right
       LED[2] <= JB[3]; // Down
       LED[3] <= JB[4]; // Left
       LED[4] <= JB[7]; // SL
       LED[5] <= JB[8]; // SR
       LED[6] <= JB[9]; // Hold
       LED[7] <= JB[10]; // Reset      
   end
//     always @(posedge clock) begin
// //        LED[2:0] <= state[2:0];   
//         LED[2:0] <= block_color;
//         LED[15:8] <= regA[7:0];
        
//     end
   

//        always @(posedge clock) begin
//                LED[0] <= memDataOut[0];
//            end
            
    // Fibonacci LSFR Random Number 
    reg [15:0] state = 16'hACE1; // best seed for 16 bit LSFR
    wire next_msb;
    assign next_msb = ((state[0] ^ state[2]) ^ state[3]) ^ state[5];
    
    always @(posedge clock)
    begin
        state <= (state >> 1);
        state[15] <= next_msb;
    end
             
        
	// ADD YOUR MEMORY FILE HERE
	localparam INSTR_FILE = "tetris";
	localparam FILES_PATH = "C:/Users/lja26/Desktop/tetris/";
	
	//    assign cpu_regA = ((rs1 != 27) && (rs1 != 28)) ? regA : (rs1 == 28) ? {29'b0, state[2:0]} : JB[10] ? 10 : JB[9] ? 9 : JB[8] ? 8 : JB[7] ? 7 : JB[4] ? 4 : JB[3] ? 3 : JB[2] ? 2 : JB[1] ? 1 : 0;
    assign cpu_regA = ((rs1 != 27) && (rs1 != 28)) ? regA : (rs1 == 28) ? {29'b0, state[2:0]} : JB[10] ? 10 : JB[8] ? 8 : JB[4] ? 4 : JB[3] ? 3 : JB[2] ? 2 : 0;
    
    
    
	// Main Processing Unit
	processor CPU(.clock(clock), .reset(reset), 
								
		// ROM
		.address_imem(instAddr), .q_imem(instData),
									
		// Regfile
		.ctrl_writeEnable(rwe),     .ctrl_writeReg(rd),
		.ctrl_readRegA(rs1),     .ctrl_readRegB(rs2), 
		.data_writeReg(rData), .data_readRegA(cpu_regA), .data_readRegB(regB),
									
		// RAM
		.wren(mwe), .address_dmem(memAddr), 
		.data(memDataIn), .q_dmem(memDataOut),
		.isLWSW(isLWSW)); 
	
	// Instruction Memory (ROM)
	ROM #(.MEMFILE({FILES_PATH, INSTR_FILE, ".mem"}))
	InstMem(.clk(clock), 
		.addr(instAddr[11:0]), 
		.dataOut(instData));
	
    
	// Register File
	regfile RegisterFile(.clock(clock), 
		.ctrl_writeEnable(rwe), .ctrl_reset(reset), 
		.ctrl_writeReg(rd),
		.ctrl_readRegA(rs1), .ctrl_readRegB(rs2), 
		.data_writeReg(rData), .data_readRegA(regA), .data_readRegB(regB));
				
//    wire [6399:0] curr_grid;
    wire[11:0] mem_addr;
    wire[11:0] block_addr;
    
    assign mem_addr = isLWSW ? memAddr[11:0] : block_addr;
	// Processor Memory (RAM)
	RAM ProcMem(.clk(clock), 
		.wEn(mwe), 
		.addr(mem_addr), 
		.dataIn(memDataIn), 
		.dataOut(memDataOut)
//		.curr_grid(curr_grid)
		);
		
		
    // VGA 
		
	wire clk25; // 25MHz clock

	reg[1:0] pixCounter = 0;      // Pixel counter to divide the clock
    assign clk25 = pixCounter[1]; // Set the clock high whenever the second bit (2) is high
	always @(posedge clk_100mhz) begin
		pixCounter <= pixCounter + 1; // Since the reg is only 3 bits, it will reset every 8 cycles
	end
	
    localparam 
		VIDEO_WIDTH = 640,  // Standard VGA Width
		VIDEO_HEIGHT = 480; // Standard VGA Height
  

	wire active, screenEnd;
	wire[9:0] x;
	wire[8:0] y;
	
	VGATimingGenerator #(
		.HEIGHT(VIDEO_HEIGHT), // Use the standard VGA Values
		.WIDTH(VIDEO_WIDTH))
		
	Display( 
		.clk25(clk25),  	   // 25MHz Pixel Clock
		.reset(reset),		   // Reset Signal
		.screenEnd(screenEnd), // High for one cycle when between two frames
		.active(active),	   // High when drawing pixels
		.hSync(hSync),  	   // Set Generated H Signal
		.vSync(vSync),		   // Set Generated V Signal
		.x(x), 				   // X Coordinate (from left)
		.y(y)); 			   // Y Coordinate (from top)	   

	// Image Data to Map Pixel Location to Color Address
	localparam 
		PIXEL_COUNT = VIDEO_WIDTH*VIDEO_HEIGHT, 	             // Number of pixels on the screen
		PIXEL_ADDRESS_WIDTH = $clog2(PIXEL_COUNT) + 1,           // Use built in log2 command
		BITS_PER_COLOR = 12, 	  								 // Nexys A7 uses 12 bits/color
		PALETTE_COLOR_COUNT = 256, 								 // Number of Colors available
		PALETTE_ADDRESS_WIDTH = $clog2(PALETTE_COLOR_COUNT) + 1; // Use built in log2 Command

	wire[PIXEL_ADDRESS_WIDTH-1:0] imgAddress;  	 // Image address for the image data
	wire[PALETTE_ADDRESS_WIDTH-1:0] colorAddr; 	 // Color address for the color palette
	wire[BITS_PER_COLOR-1:0] colorData; // 12-bit color data at current pixel
	
	RAM #(
		.DEPTH(PALETTE_COLOR_COUNT), 		       // Set depth to contain every color		
		.DATA_WIDTH(BITS_PER_COLOR), 		       // Set data width according to the bits per color
		.ADDRESS_WIDTH(PALETTE_ADDRESS_WIDTH),     // Set address width according to the color count
		.MEMFILE({FILES_PATH, "colors.mem"}))  // Memory initialization
	ColorPalette(
		.clk(clk), 							   	   // Rising edge of the 100 MHz clk
		.addr(colorAddr),					       // Address from the ImageData RAM
		.dataOut(colorData),				       // Color at current pixel
		.wEn(1'b0)); 						       // We're always reading
		
	wire[11:0] black, white, cyan, blue, orange, yellow, green, purple, red;
	assign black = 12'b0;
	assign white = 12'hFFF;
	assign cyan = 12'h0FF;
	assign blue = 12'h02F;
	assign orange = 12'hE80;
	assign yellow = 12'hFF0;
	assign green = 12'h4F0;
	assign purple = 12'hA0F;
	assign red = 12'hF00;
	

    wire[BITS_PER_COLOR-1:0] colorBack; 			  // Output color 
	wire[BITS_PER_COLOR-1:0] colorOut; 			  // Output color 
	assign colorBack = black; // When not active, output black
	
	wire [4:0] block_x, block_y;
    assign block_x = 
        ((x - 220) < 20)  ? 0  : 
        ((x - 220) < 40)  ? 1  : 
        ((x - 220) < 60)  ? 2  : 
        ((x - 220) < 80)  ? 3  : 
        ((x - 220) < 100) ? 4  :
        ((x - 220) < 120) ? 5  :
        ((x - 220) < 140) ? 6  :
        ((x - 220) < 160) ? 7  :
        ((x - 220) < 180) ? 8  :
        9; // Default value for cases beyond 180
    assign block_y = 
        ((y - 40) < 20)  ? 0  : 
        ((y - 40) < 40)  ? 1  : 
        ((y - 40) < 60)  ? 2  : 
        ((y - 40) < 80)  ? 3  : 
        ((y - 40) < 100) ? 4  :
        ((y - 40) < 120) ? 5  :
        ((y - 40) < 140) ? 6  :
        ((y - 40) < 160) ? 7  :
        ((y - 40) < 180) ? 8  :
        ((y - 40) < 200) ? 9  :
        ((y - 40) < 220) ? 10 :
        ((y - 40) < 240) ? 11 :
        ((y - 40) < 260) ? 12 :
        ((y - 40) < 280) ? 13 :
        ((y - 40) < 300) ? 14 :
        ((y - 40) < 320) ? 15 :
        ((y - 40) < 340) ? 16 :
        ((y - 40) < 360) ? 17 :
        ((y - 40) < 380) ? 18 :
        19; // Default value for cases beyond 380	
//    assign block_addr = //(((y-40)/20) * 10) + ((x-220)/20);
	assign block_addr = (10 * block_y) + block_x;
	wire [2:0] block_color;
	assign block_color = memDataOut[2:0];
	
    wire isGameBoard, isGrid;
	assign isGameBoard = (x >= 220) && (x < 420) && (y >= 40) && (y < 440);
	assign isGrid = ((((x - 220) % 20) == 0) || (((x - 220) % 20) == 19) || (((y - 40) % 20) == 0) || (((y - 40) % 20) == 19)) && isGameBoard; // later we can make the grid fainter and the border solid white
	assign colorOut = isGrid ? white : ~isGameBoard ? colorBack : (block_color == 3'b0) ? black : (block_color == 3'b001) ? cyan : (block_color == 3'b111) ? blue : (block_color == 3'b110) ? orange : (block_color == 3'b010) ? yellow : (block_color == 3'b011) ? green : (block_color == 3'b101) ? purple : (block_color == 3'b100) ? red : red;
    
    assign {VGA_R, VGA_G, VGA_B} = colorOut;
    
endmodule
