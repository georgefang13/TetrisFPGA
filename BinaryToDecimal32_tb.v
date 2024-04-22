`timescale 1ns / 1ps

module BinaryToDecimal32_tb;

    // Inputs
    reg [31:0] binaryInput;
    reg clk;
    reg reset;

    // Outputs
    wire [3:0] billions;
    wire [3:0] hundred_millions;
    wire [3:0] ten_millions;
    wire [3:0] millions;
    wire [3:0] hundred_thousands;
    wire [3:0] ten_thousands;
    wire [3:0] thousands;
    wire [3:0] hundreds;
    wire [3:0] tens;
    wire [3:0] units;

    // Instantiate the Unit Under Test (UUT)
    BinaryToDecimal32 uut (
        .binaryInput(binaryInput),
        .billions(billions),
        .hundred_millions(hundred_millions),
        .ten_millions(ten_millions),
        .millions(millions),
        .hundred_thousands(hundred_thousands),
        .ten_thousands(ten_thousands),
        .thousands(thousands),
        .hundreds(hundreds),
        .tens(tens),
        .units(units),
        .clk(clk),
        .reset(reset)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #10 clk = ~clk;  // Clock with a period of 20ns
    end

    // Test stimuli
    initial begin
        // Initialize Inputs
        binaryInput = 0;
        reset = 1;

        // Wait 100 ns for global reset to finish
        #100;
        reset = 0;

        // Apply test values
        binaryInput = 32'd123456789; // Test a large number
        #200;  // Wait for 200ns to see the outputs
        $display("Input: %d, Output: %d%d%d%d%d%d%d%d%d%d", binaryInput, billions, hundred_millions, ten_millions, millions, hundred_thousands, ten_thousands, thousands, hundreds, tens, units);

        binaryInput = 32'd4294967295; // Test maximum 32-bit unsigned value
        #200;
        $display("Input: %d, Output: %d%d%d%d%d%d%d%d%d%d", binaryInput, billions, hundred_millions, ten_millions, millions, hundred_thousands, ten_thousands, thousands, hundreds, tens, units);

        binaryInput = 32'd20220421; // Test an arbitrary number
        #200;
        $display("Input: %d, Output: %d%d%d%d%d%d%d%d%d%d", binaryInput, billions, hundred_millions, ten_millions, millions, hundred_thousands, ten_thousands, thousands, hundreds, tens, units);

        binaryInput = 0;  // Test zero
        #200;
        $display("Input: %d, Output: %d%d%d%d%d%d%d%d%d%d", binaryInput, billions, hundred_millions, ten_millions, millions, hundred_thousands, ten_thousands, thousands, hundreds, tens, units);

        // Finish simulation
        $finish;
    end

endmodule
