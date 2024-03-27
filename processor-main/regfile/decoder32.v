module decoder32(out, select, enable);

    // Inputs 
    input [4:0] select;
    input enable;

    // Outputs 
    output [31:0] out;

    // Shifting the enable bit by the select bit
    assign out = enable << select;
    
endmodule 