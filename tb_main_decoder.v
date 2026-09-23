`timescale 1ns / 1ps

module tb_main_decoder;
// 1. Declare matching inputs and outputs
    reg [6:0] Op;
    wire RegWrite, ALUSrc, MemWrite, ResultSrc, Branch;
    wire [1:0] ImmSrc, ALUOp;

    // 2. Instantiate the module with exact port names
    main_decoder uut (
        .Op(Op),
        .RegWrite(RegWrite),
        .ImmSrc(ImmSrc),
        .ALUSrc(ALUSrc),
        .MemWrite(MemWrite),
        .ResultSrc(ResultSrc),
        .Branch(Branch),
        .ALUOp(ALUOp)
    );

    // 3. Apply stimulus in an initial block
    initial begin
        // Setup waveform dumping for viewing later
        $dumpfile("decoder_wave.vcd");
        $dumpvars(0, tb_main_decoder);

        // Test R-type instruction (opcode: 0110011)
        Op = 7'b0110011;
        #10; 
        
        // Test lw instruction (opcode: 0000011)
        Op = 7'b0000011;
        #10;
        
        // Test sw instruction (opcode: 0100011)
        Op = 7'b0100011;
        #10;

        $finish; // End simulation
    end

    // Optional: Monitor changes in the console
    initial begin
        $monitor("Time = %0d, Opcode = %b, RegWrite = %b, ALUOp = %b", $time, Op, RegWrite, ALUOp);
    end

endmodule