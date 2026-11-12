module Alu_decoder (ALUOp,op,funct3,funct7,ALUControl);
    input op;
    input [6:0]funct7;// funct7 is the bit [31:25] of the instruction
    input [2:0]funct3;
    input [1:0] ALUOp;
    output [2:0] ALUControl;

    //interim wire 
    wire[1:0] concatenation;

    assign concatenation = {op,funct7[5]};  //fifth bit of op tells the alue control what type of  operation is performed whether it is r-type or i type 
    // (op == 1) means it is a r-type instruction if 0 then it is a i-type instruction
    // funct7 is used for distinction between add and sub
     assign ALUControl  = (ALUOp == 2'b00 ) ? 3'b000:                                              // ADD ( for load/store address calculation)
                          (ALUOp == 2'b01 ) ? 3'b001:                                              // SUB (only to check if both inputs are equal or not(beq))
                          ((ALUOp == 2'b10 ) & (funct3 == 3'b010)) ? 3'b101:                      // SLT
                          ((ALUOp == 2'b10 ) & (funct3 == 3'b110)) ? 3'b011:                      // OR
                          ((ALUOp == 2'b10 ) & (funct3 == 3'b111)) ? 3'b010:                      // AND
                          ((ALUOp == 2'b10 ) & (funct3 == 3'b000)) & (concatenation == 2'b11)? 3'b001: // SUB (R-type)
                          ((ALUOp == 2'b10 ) & (funct3 == 3'b000)) & (concatenation != 2'b11)? 3'b000:3'b000; // ADD (R-type)




    
endmodule
