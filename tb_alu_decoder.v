`timescale 1ns / 1ps

module tb_Alu_decoder;

    // 1. Declare inputs as reg and outputs as wire
    reg [1:0] ALUOp;
    reg op5;
    reg [2:0] funct3;
    reg [6:0] funct7;
    
    wire [2:0] ALUControl;

    // 2. Instantiate the ALU decoder
    Alu_decoder uut (
        .ALUOp(ALUOp),
        .op(op5),
        .funct3(funct3),
        .funct7(funct7),
        .ALUControl(ALUControl)
    );

    // 3. Apply test vectors
    initial begin
        $dumpfile("alu_dec_wave.vcd");
        $dumpvars(0, tb_Alu_decoder);

        // Test Case 1: ALUOp = 00 (lw/sw -> ADD)
        ALUOp = 2'b00; op5 = 1'b0; funct3 = 3'b000; funct7 = 7'b0000000; #10;
        
        // Test Case 2: ALUOp = 01 (beq -> SUB)
        ALUOp = 2'b01; op5 = 1'b0; funct3 = 3'b000; funct7 = 7'b0000000; #10;
        
        // Test Case 3: ALUOp = 10, funct3 = 010 (SLT)
        ALUOp = 2'b10; op5 = 1'b0; funct3 = 3'b010; funct7 = 7'b0000000; #10;

        // Test Case 4: ALUOp = 10, funct3 = 110 (OR)
        ALUOp = 2'b10; op5 = 1'b0; funct3 = 3'b110; funct7 = 7'b0000000; #10;
        
        // Test Case 5: ALUOp = 10, funct3 = 111 (AND)
        ALUOp = 2'b10; op5 = 1'b0; funct3 = 3'b111; funct7 = 7'b0000000; #10;
        
        // Test Case 6: ALUOp = 10, funct3 = 000, R-type ADD (op5=1, funct7[5]=0 -> concatenation=10 -> ADD)
        ALUOp = 2'b10; op5 = 1'b1; funct3 = 3'b000; funct7 = 7'b0000000; #10;
        
        // Test Case 7: ALUOp = 10, funct3 = 000, R-type SUB (op5=1, funct7[5]=1 -> concatenation=11 -> SUB)
        ALUOp = 2'b10; op5 = 1'b1; funct3 = 3'b000; funct7 = 7'b0100000; #10;

        // Test Case 8: ALUOp = 10, funct3 = 000, I-type ADDI (op5=0, funct7[5]=1 -> concatenation=01 -> ADD)
        ALUOp = 2'b10; op5 = 1'b0; funct3 = 3'b000; funct7 = 7'b0100000; #10;

        $finish;
    end

    // Monitor changes in the terminal
    initial begin
        $monitor("Time=%0t | ALUOp=%b op5=%b funct3=%b funct7[5]=%b | ALUControl=%b", 
                 $time, ALUOp, op5, funct3, funct7[5], ALUControl);
    end

endmodule