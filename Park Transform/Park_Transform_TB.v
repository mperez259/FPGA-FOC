`timescale 1ns / 1ps

module Park_Transform_TB;

    // -------- DUT I/O --------
    reg  signed [15:0] i_alpha, i_beta;       // Inputs from Clarke
    reg  signed [15:0] sin_theta, cos_theta;  // Rotor electrical angle
    wire signed [15:0] i_d, i_q;              // Outputs from Park transform

    // Instantiate DUT
    Park_Transform uut (
        .i_alpha(i_alpha),
        .i_beta(i_beta),
        .sin_theta(sin_theta),
        .cos_theta(cos_theta),
        .i_d(i_d),
        .i_q(i_q)
    );

    // -------- Simulation parameters --------
    real freq   = 60.0;            // Electrical frequency (Hz)
    real Ts     = 50e-6;           // 50 µs sample period (20 kHz rate)
    real omega;                    // Angular frequency (rad/s)
    real angle;                    // Shared phase angle variable
    real SCALE  = 32768.0;         // Q15 scaling (1.0 = 32768)
    real amp    = 20054.0 / 32768.0; // Current amplitude (~0.612 pu)
    integer tmp_alpha, tmp_beta, tmp_sin, tmp_cos;

    // -------- Initialization --------
    initial begin
        omega = 2.0 * 3.14159265 * freq; // ω = 2πf = 377 rad/s
        angle = 0.0;

        // Optional waveform dump (for Vivado/GTKWave)
        $dumpfile("park_ideal.vcd");
        $dumpvars(0, Park_Transform_TB);

        // Run for about 5 full cycles (~83 ms)
        repeat (1666) begin
            // αβ stator currents (stationary reference frame)
            tmp_alpha = $rtoi(amp * $sin(angle) * SCALE);
            tmp_beta  = $rtoi(amp * $cos(angle) * SCALE);

            // dq frame rotation angle (perfectly synchronized)
            tmp_sin   = $rtoi($sin(angle) * SCALE);
            tmp_cos   = $rtoi($cos(angle) * SCALE);

            // Assign to DUT
            i_alpha   = tmp_alpha[15:0];
            i_beta    = tmp_beta[15:0];
            sin_theta = tmp_sin[15:0];
            cos_theta = tmp_cos[15:0];

            // Advance angle by ωTs each step
            angle = angle + omega * Ts;
            #50000;  // 50 µs in nanoseconds
        end

        $finish;
    end

endmodule
