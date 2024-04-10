`timescale 1ns / 1ps
module RAM #( parameter DATA_WIDTH = 32, ADDRESS_WIDTH = 12, DEPTH = 4096, MEMFILE = "") (
    input wire                     clk,
    input wire                     wEn,
    input wire [ADDRESS_WIDTH-1:0] addr,
    input wire [DATA_WIDTH-1:0]    dataIn,
    output reg [DATA_WIDTH-1:0]    dataOut = 0,
    output wire [6399 : 0]          curr_grid);
    
    reg[DATA_WIDTH-1:0] MemoryArray[0:DEPTH-1];
    assign curr_grid = {
    MemoryArray[0], MemoryArray[1], MemoryArray[2], MemoryArray[3], MemoryArray[4], MemoryArray[5], MemoryArray[6], MemoryArray[7], MemoryArray[8], MemoryArray[9],
    MemoryArray[10], MemoryArray[11], MemoryArray[12], MemoryArray[13], MemoryArray[14], MemoryArray[15], MemoryArray[16], MemoryArray[17], MemoryArray[18], MemoryArray[19],
    MemoryArray[20], MemoryArray[21], MemoryArray[22], MemoryArray[23], MemoryArray[24], MemoryArray[25], MemoryArray[26], MemoryArray[27], MemoryArray[28], MemoryArray[29],
    MemoryArray[30], MemoryArray[31], MemoryArray[32], MemoryArray[33], MemoryArray[34], MemoryArray[35], MemoryArray[36], MemoryArray[37], MemoryArray[38], MemoryArray[39],
    MemoryArray[40], MemoryArray[41], MemoryArray[42], MemoryArray[43], MemoryArray[44], MemoryArray[45], MemoryArray[46], MemoryArray[47], MemoryArray[48], MemoryArray[49],
    MemoryArray[50], MemoryArray[51], MemoryArray[52], MemoryArray[53], MemoryArray[54], MemoryArray[55], MemoryArray[56], MemoryArray[57], MemoryArray[58], MemoryArray[59],
    MemoryArray[60], MemoryArray[61], MemoryArray[62], MemoryArray[63], MemoryArray[64], MemoryArray[65], MemoryArray[66], MemoryArray[67], MemoryArray[68], MemoryArray[69],
    MemoryArray[70], MemoryArray[71], MemoryArray[72], MemoryArray[73], MemoryArray[74], MemoryArray[75], MemoryArray[76], MemoryArray[77], MemoryArray[78], MemoryArray[79],
    MemoryArray[80], MemoryArray[81], MemoryArray[82], MemoryArray[83], MemoryArray[84], MemoryArray[85], MemoryArray[86], MemoryArray[87], MemoryArray[88], MemoryArray[89],
    MemoryArray[90], MemoryArray[91], MemoryArray[92], MemoryArray[93], MemoryArray[94], MemoryArray[95], MemoryArray[96], MemoryArray[97], MemoryArray[98], MemoryArray[99],
    MemoryArray[100], MemoryArray[101], MemoryArray[102], MemoryArray[103], MemoryArray[104], MemoryArray[105], MemoryArray[106], MemoryArray[107], MemoryArray[108], MemoryArray[109],
    MemoryArray[110], MemoryArray[111], MemoryArray[112], MemoryArray[113], MemoryArray[114], MemoryArray[115], MemoryArray[116], MemoryArray[117], MemoryArray[118], MemoryArray[119],
    MemoryArray[120], MemoryArray[121], MemoryArray[122], MemoryArray[123], MemoryArray[124], MemoryArray[125], MemoryArray[126], MemoryArray[127], MemoryArray[128], MemoryArray[129],
    MemoryArray[130], MemoryArray[131], MemoryArray[132], MemoryArray[133], MemoryArray[134], MemoryArray[135], MemoryArray[136], MemoryArray[137], MemoryArray[138], MemoryArray[139],
    MemoryArray[140], MemoryArray[141], MemoryArray[142], MemoryArray[143], MemoryArray[144], MemoryArray[145], MemoryArray[146], MemoryArray[147], MemoryArray[148], MemoryArray[149],
    MemoryArray[150], MemoryArray[151], MemoryArray[152], MemoryArray[153], MemoryArray[154], MemoryArray[155], MemoryArray[156], MemoryArray[157], MemoryArray[158], MemoryArray[159],
    MemoryArray[160], MemoryArray[161], MemoryArray[162], MemoryArray[163], MemoryArray[164], MemoryArray[165], MemoryArray[166], MemoryArray[167], MemoryArray[168], MemoryArray[169],
    MemoryArray[170], MemoryArray[171], MemoryArray[172], MemoryArray[173], MemoryArray[174], MemoryArray[175], MemoryArray[176], MemoryArray[177], MemoryArray[178], MemoryArray[179],
    MemoryArray[180], MemoryArray[181], MemoryArray[182], MemoryArray[183], MemoryArray[184], MemoryArray[185], MemoryArray[186], MemoryArray[187], MemoryArray[188], MemoryArray[189],
    MemoryArray[190], MemoryArray[191], MemoryArray[192], MemoryArray[193], MemoryArray[194], MemoryArray[195], MemoryArray[196], MemoryArray[197], MemoryArray[198], MemoryArray[199]
};
    integer i;
    initial begin
        for (i = 0; i < DEPTH; i = i + 1) begin
            MemoryArray[i] <= 0;
        end
         if(MEMFILE > 0) begin
             $readmemh(MEMFILE, MemoryArray);
         end
    end
    
    always @(posedge clk) begin
        if(wEn) begin
            MemoryArray[addr] <= dataIn;
        end else begin
            dataOut <= MemoryArray[addr];
        end
    end
endmodule
