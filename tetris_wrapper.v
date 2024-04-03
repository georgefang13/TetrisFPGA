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
    output reg [15:0] LED);
    
    wire clock, reset;
    assign clock = clk_50mhz;
//    assign reset = JB[10]; 
    assign reset = 1'b0;
    
	wire rwe, mwe;
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
    

	// ADD YOUR MEMORY FILE HERE
	localparam INSTR_FILE = "timing";
	
assign cpu_regA = (rs1 != 27) ? regA : JB[9] ? 9 : JB[8] ? 8 : JB[7] ? 7 : JB[4] ? 4 : JB[3] ? 3 : JB[2] ? 2 : JB[1] ? 1 : 0;
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
		.data(memDataIn), .q_dmem(memDataOut)); 
	
	// Instruction Memory (ROM)
	ROM #(.MEMFILE({INSTR_FILE, ".mem"}))
	InstMem(.clk(clock), 
		.addr(instAddr[11:0]), 
		.dataOut(instData));
	
    
	// Register File
	regfile RegisterFile(.clock(clock), 
		.ctrl_writeEnable(rwe), .ctrl_reset(reset), 
		.ctrl_writeReg(rd),
		.ctrl_readRegA(rs1), .ctrl_readRegB(rs2), 
		.data_writeReg(rData), .data_readRegA(regA), .data_readRegB(regB));
						
	// Processor Memory (RAM)
	RAM ProcMem(.clk(clock), 
		.wEn(mwe), 
		.addr(memAddr[11:0]), 
		.dataIn(memDataIn), 
		.dataOut(memDataOut));

endmodule
