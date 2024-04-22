module BinaryToDecimal32(
    input [31:0] binaryInput,  // 32-bit binary input
    output reg [3:0] billions,
    output reg [3:0] hundred_millions,
    output reg [3:0] ten_millions,
    output reg [3:0] millions,
    output reg [3:0] hundred_thousands,
    output reg [3:0] ten_thousands,
    output reg [3:0] thousands,  // Each output digit from 0 to 9
    output reg [3:0] hundreds,
    output reg [3:0] tens,
    output reg [3:0] units,
    input clk,  // Clock input for synchronous operation
    input reset  // Reset input to initialize the outputs
);

// Internal variables to handle the conversion
integer i;
reg [31:0] temp;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        billions <= 0;
        hundred_millions <= 0;
        ten_millions <= 0;
        millions <= 0;
        hundred_thousands <= 0;
        ten_thousands <= 0;
        thousands <= 0;
        hundreds <= 0;
        tens <= 0;
        units <= 0;
    end else begin
        // Initialize temporary variables
        temp = binaryInput;
        billions = 0;
        hundred_millions = 0;
        ten_millions = 0;
        millions = 0;
        hundred_thousands = 0;
        ten_thousands = 0;
        thousands = 0;
        hundreds = 0;
        tens = 0;
        units = 0;

        // Loop to convert binary to decimal (Double Dabble Algorithm)
        for (i = 0; i < 32; i = i + 1) begin
            // Add 3 to columns that would have a carry
            if (billions >= 5)
                billions = billions + 3;
            if (hundred_millions >= 5)
                hundred_millions = hundred_millions + 3;
            if (ten_millions >= 5)
                ten_millions = ten_millions + 3;
            if (millions >= 5)
                millions = millions + 3;
            if (hundred_thousands >= 5)
                hundred_thousands = hundred_thousands + 3;
            if (ten_thousands >= 5)
                ten_thousands = ten_thousands + 3;
            if (thousands >= 5)
                thousands = thousands + 3;
            if (hundreds >= 5)
                hundreds = hundreds + 3;
            if (tens >= 5)
                tens = tens + 3;
            if (units >= 5)
                units = units + 3;

            // Shift left by 1
            billions = billions << 1;
            billions[0] = hundred_millions[3];
            hundred_millions = hundred_millions << 1;
            hundred_millions[0] = ten_millions[3];
            ten_millions = ten_millions << 1;
            ten_millions[0] = millions[3];
            millions = millions << 1;
            millions[0] = hundred_thousands[3];
            hundred_thousands = hundred_thousands << 1;
            hundred_thousands[0] = ten_thousands[3];
            ten_thousands = ten_thousands << 1;
            ten_thousands[0] = thousands[3];
            thousands = thousands << 1;
            thousands[0] = hundreds[3];
            hundreds = hundreds << 1;
            hundreds[0] = tens[3];
            tens = tens << 1;
            tens[0] = units[3];
            units = units << 1;
            units[0] = temp[31];

            temp = temp << 1;  // Shift the binary input left
        end
    end
end

endmodule
