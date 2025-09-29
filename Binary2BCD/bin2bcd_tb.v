`timescale 1ns / 1ps

module tb_bin2bcd;

    reg  [7:0] bin;       // binary input
    wire [11:0] bcd;      // BCD output

    // Instantiate DUT (Device Under Test)
    bin2bcd uut (
        .bin(bin),
        .bcd(bcd)
    );

    initial begin
        $display("Binary -> BCD (Hundreds Tens Ones)");

        // apply test values
        bin = 8'd12;  #10; $display("bin=%3d -> BCD=%1d%1d%1d", bin, bcd[11:8], bcd[7:4], bcd[3:0]);

        $stop;
    end

endmodule
