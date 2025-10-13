`timescale 1ns / 1ps

module Park_Transform(
    input signed [15:0] i_alpha, i_beta,
    input signed [15:0] sin_theta, cos_theta,
    output reg signed [15:0] i_d, i_q
    );
    
    reg signed [31:0] temp_cos_alpha, temp_cos_beta, temp_sin_alpha, temp_sin_beta ;

    always @ (i_alpha or i_beta or sin_theta or cos_theta)
    begin
    temp_cos_alpha = cos_theta * i_alpha;
    temp_cos_beta = cos_theta * i_beta;
    temp_sin_alpha = sin_theta * i_alpha;
    temp_sin_beta = sin_theta * i_beta;
    
    i_d = (temp_cos_beta + temp_sin_alpha) >>> 15;
    i_q = (temp_cos_alpha - temp_sin_beta) >>> 15;
    
    end
    
    
endmodule
