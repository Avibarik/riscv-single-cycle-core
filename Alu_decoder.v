module Alu_decoder (ALUOp , op5,funct3,funct7,ALUControl);
    input op5 , funct7;
    input [2:0]funct3;
    input [1:0] ALUOp;
    output [2:0] ALUControl;

    //interim wire 
    wire[1:0] concatenation;

    assign concatenation = {op5,funct7};

     assign ALUControl  = (ALUOp == 2'b00 ) ? 3'b000:
                          (ALUOp == 2'b01 ) ? 3'b001:
                          ((ALUOp == 2'b10 ) & (funct3 == 3'b010)) ? 3'b101: 
                          ((ALUOp == 2'b10 ) & (funct3 == 3'b110)) ? 3'b011: 
                          ((ALUOp == 2'b10 ) & (funct3 == 3'b111)) ? 3'b010:
                          ((ALUOp == 2'b10 ) & (funct3 == 3'b111)) & (concatenation == 2'b11)? 3'b001: 
                          ((ALUOp == 2'b10 ) & (funct3 == 3'b111)) & (concatenation != 2'b11)? 3'b000:3'b000;




    
endmodule