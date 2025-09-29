`timescale 1ns / 1ps

module add_3(input [3:0] A, output reg [3:0] S);
    always@(A)
    begin    
    if(A <= 4)
    S = A;
    else
    S = A + 3;
    end
endmodule