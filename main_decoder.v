module main_decoder(Op, RegWrite, ImmSrc, ALUSrc, MemWrite, ResultSrc, Branch, ALUOp);
    input [6:0] Op;
    output RegWrite, ALUSrc, MemWrite, ResultSrc, Branch;
    output [1:0] ImmSrc, ALUOp;

    // 1 for Load (0000011) and R-type (0110011) to write result to register
    assign RegWrite = (Op == 7'b0000011 || Op == 7'b0110011) ? 1'b1 : 1'b0;
    
    // 01 for Store (S-type), 10 for Branch (B-type), 00 for Load/I-type
    assign ImmSrc = (Op == 7'b0100011) ? 2'b01 : 
                    (Op == 7'b1100011) ? 2'b10 : 2'b00;
                    
    // 1 for Load and Store to select Immediate as 2nd ALU operand
    assign ALUSrc = (Op == 7'b0000011 || Op == 7'b0100011) ? 1'b1 : 1'b0;
    
    // 1 for Store (0100011) to enable writing data into memory
    assign MemWrite = (Op == 7'b0100011) ? 1'b1 : 1'b0;
    
    // 1 for Load (0000011) to write memory data back; 0 to write ALU result
    assign ResultSrc = (Op == 7'b0000011) ? 1'b1 : 1'b0;
    
    // 1 for Branch (1100011) to indicate a conditional jump instruction
    assign Branch = (Op == 7'b1100011) ? 1'b1 : 1'b0;
    
    // 10 for R-type (funct-based), 01 for Branch (SUB), 00 for Load/Store (ADD)
    assign ALUOp = (Op == 7'b0110011) ? 2'b10 :
                   (Op == 7'b1100011) ? 2'b01 : 2'b00;

endmodule