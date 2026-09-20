`timescale 1ns / 1ps

module tb_alu;
    // Inputs to the ALU (declared as registers in the testbench)
    reg [31:0] a;
    reg [31:0] b;
    reg [2:0]  alu_control;

    // Output from the ALU (declared as a wire)
    wire [31:0] result;

    // Instantiate the Unit Under Test (UUT)
   alu uut (
        .A(a),
        .B(b),
        .ALUControl(alu_control),
        .Result(result)
    );

    initial begin
        // 1. Enable waveform dump for GTKWave
        $dumpfile("alu_wave.vcd");
        $dumpvars(0, tb_alu);

       // 1. ADD (ALUControl[1:0] = 00, ALUControl[0] = 0) -> 10 + 5 = 15
a = 32'd10; b = 32'd5; alu_control = 3'b000;
#10;
$display("[ADD] a=%0d, b=%0d, result=%0d", a, b, result);

// 2. SUB (ALUControl[1:0] = 01, ALUControl[0] = 1) -> 10 - 5 = 5
a = 32'd10; b = 32'd5; alu_control = 3'b001;
#10;
$display("[SUB] a=%0d, b=%0d, result=%0d", a, b, result);

// 3. AND (ALUControl[1:0] = 10) -> 12 & 10 = 8
a = 32'b1100; b = 32'b1010; alu_control = 3'b010;
#10;
$display("[AND] a=%b, b=%b, result=%b", a, b, result);

// 4. OR (ALUControl[1:0] = 11) -> 12 | 10 = 14
a = 32'b1100; b = 32'b1010; alu_control = 3'b011;
#10;
$display("[OR]  a=%b, b=%b, result=%b", a, b, result);

        #10;
        $finish;
    end
endmodule