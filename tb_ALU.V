`timescale 1ns / 1ps

module tb_alu;
    // Inputs to the ALU (declared as registers in the testbench)
    reg [31:0] a;
    reg [31:0] b;
    reg [2:0]  alu_control;

    // Output from the ALU (declared as a wire)
    wire [31:0] result;
    wire z, n, v, c;

    // Instantiate the Unit Under Test (UUT)
    ALU uut (
        .A(a),
        .B(b),
        .ALUControl(alu_control),
        .Result(result),
        .Z(z),
        .N(n),
        .V(v),
        .C(c)
    );

    initial begin
        // 1. Enable waveform dump for GTKWave
        $dumpfile("alu_wave.vcd");
        $dumpvars(0, tb_alu);

        // 1. ADD (ALUControl = 000) -> 10 + 5 = 15
        a = 32'd10; b = 32'd5; alu_control = 3'b000; #10;
        $display("[ADD] a=%0d, b=%0d, result=%0d", a, b, result);

        // 2. SUB (ALUControl = 001) -> 10 - 5 = 5
        a = 32'd10; b = 32'd5; alu_control = 3'b001; #10;
        $display("[SUB] a=%0d, b=%0d, result=%0d", a, b, result);

        // 3. AND (ALUControl = 010) -> 12 & 10 = 8
        a = 32'b1100; b = 32'b1010; alu_control = 3'b010; #10;
        $display("[AND] a=%b, b=%b, result=%b", a, b, result);

        // 4. OR (ALUControl = 011) -> 12 | 10 = 14
        a = 32'b1100; b = 32'b1010; alu_control = 3'b011; #10;
        $display("[OR]  a=%b, b=%b, result=%b", a, b, result);

        // 5. SLT (ALUControl = 101) -> Normal comparison: 5 < 10 is 1
        a = 32'd5; b = 32'd10; alu_control = 3'b101; #10;
        $display("[SLT] a=%0d, b=%0d, result=%0d (expected 1)", a, b, result);

        // 6. SLT (ALUControl = 101) -> Normal comparison: 10 < 5 is 0
        a = 32'd10; b = 32'd5; alu_control = 3'b101; #10;
        $display("[SLT] a=%0d, b=%0d, result=%0d (expected 0)", a, b, result);

        // 7. SLT (ALUControl = 101) -> Signed Overflow case 1: +MAX vs -MIN
        // a = +2147483647 (0x7FFFFFFF), b = -2147483648 (0x80000000) -> a < b is FALSE (0)
        a = 32'h7FFFFFFF; b = 32'h80000000; alu_control = 3'b101; #10;
        $display("[SLT Overflow +MAX < -MIN] a=%h, b=%h, result=%0d, V=%b (expected result=0, V=1)", a, b, result, v);

        // 8. SLT (ALUControl = 101) -> Signed Overflow case 2: -MIN vs +MAX
        // a = -2147483648 (0x80000000), b = +2147483647 (0x7FFFFFFF) -> a < b is TRUE (1)
        a = 32'h80000000; b = 32'h7FFFFFFF; alu_control = 3'b101; #10;
        $display("[SLT Overflow -MIN < +MAX] a=%h, b=%h, result=%0d, V=%b (expected result=1, V=1)", a, b, result, v);

        #10;
        $finish;
    end
endmodule