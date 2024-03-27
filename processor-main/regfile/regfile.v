module regfile (
	clock,
	ctrl_writeEnable, ctrl_reset, ctrl_writeReg,
	ctrl_readRegA, ctrl_readRegB, data_writeReg,
	data_readRegA, data_readRegB
);

	// Inputs
	input clock, ctrl_writeEnable, ctrl_reset;
	input [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
	input [31:0] data_writeReg;

	// Outputs
	output [31:0] data_readRegA, data_readRegB;

	// Register outputs grouped as one wire for ease of genvar
	wire [1023:0] reg_outs;

	// Decoder outputs
	wire [31:0] decoded_RD, decoded_RS1, decoded_RS2;

	// Write Destination decoder
	decoder32 RDdecoder(decoded_RD, ctrl_writeReg, ctrl_writeEnable);

	// Register0: always set to 0
	register reg0(.clk(clock), .in_enable(decoded_RD[0]), .ctrl_reset(ctrl_reset), .data_in(32'b0), .data_out(reg_outs[31:0]));
	
	// Generate 32 registers
	genvar i;
	generate
			for(i = 1; i < 32; i = i+1) begin: reg_loop
				register reg1(.clk(clock), .in_enable(decoded_RD[i]), .ctrl_reset(ctrl_reset), .data_in(data_writeReg), .data_out(reg_outs[32*i+31:32*i]));
			end
			
	endgenerate

	// Decode read destinations
	decoder32 RS1decoder(decoded_RS1, ctrl_readRegA, 1'b1);
	decoder32 RS2decoder(decoded_RS2, ctrl_readRegB, 1'b1);

	// Generate Tristates for RS1 and RS2 outputs
	genvar t;
    generate
        for (t = 0; t < 32; t = t+1) begin: tri_loop1
			tri_state triRS1(.in(reg_outs[32*t+31:32*t]), .oe(decoded_RS1[t]), .out(data_readRegA));
        end
    endgenerate

	genvar r;
    generate
        for (r = 0; r < 32; r = r+1) begin: tri_loop2
            tri_state triRS2(.in(reg_outs[32*r+31:32*r]), .oe(decoded_RS2[r]), .out(data_readRegB));
        end
    endgenerate

endmodule
