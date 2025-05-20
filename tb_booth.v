`timescale 1ns / 1ps

module tb_booths_multiplier;

    // Inputs
    reg clk;
    reg reset;
    reg start;
    reg signed [3:0] multiplicand;
    reg signed [3:0] multiplier;

    // Outputs
    wire signed [7:0] product;
    wire done;

    // Instantiate the Unit Under Test (UUT)
    booths_multiplier uut (
        .clk(clk),
        .reset(reset),
        .start(start),
        .multiplicand(multiplicand),
        .multiplier(multiplier),
        .product(product),
        .done(done)
    );

    // Clock generation: 10 ns period
    always #5 clk = ~clk;

    // Test Procedure
    initial begin
        // Initialize inputs
        clk = 0;
        reset = 1;
        start = 0;
        multiplicand = 0;
        multiplier = 0;

        // Apply reset
        #10;
        reset = 0;

        // Test Case 1: 3 * 2
        multiplicand = 4'sd3;
        multiplier = 4'sd2;
        start = 1;
        #10 start = 0;

        wait (done);
        #10;

        $display("Test 1: 3 * 2 = %d", product);

        // Test Case 2: -4 * 3
        multiplicand = -4;
        multiplier = 3;
        start = 1;
        #10 start = 0;

        wait (done);
        #10;

        $display("Test 2: -4 * 3 = %d", product);

        // Test Case 3: -3 * -2
        multiplicand = -3;
        multiplier = -2;
        start = 1;
        #10 start = 0;

        wait (done);
        #10;

        $display("Test 3: -3 * -2 = %d", product);

        // Test Case 4: 0 * -3
        multiplicand = 0;
        multiplier = -3;
        start = 1;
        #10 start = 0;

        wait (done);
        #10;

        $display("Test 4: 0 * -3 = %d", product);

        // Finish simulation
        #20;
        $finish;
    end

endmodule
