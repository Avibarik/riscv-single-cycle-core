 module alu(A,B,ALUControl,Result,Z,N,V,C);
    // declaringg inputs
    input [31:0]A,B;
    input [2:0]ALUControl;

    //declaring outputs 
    output [31:0] Result;
    output Z,N,V,C;

    //declaring interim wires 
    wire[31:0] a_and_b;
    wire[31:0] a_or_b;
    wire[31:0] not_b;

    wire[31:0] mux_1;

    wire[31:0] sum;

    wire[31:0] mux_2;
    wire[31:0] slt;
    wire cout; 


     
    //logic design

    //AND OPERATION
    assign a_and_b = A & B; 
    
    //OR OPERATION
    assign a_or_b = A | B;
    
    //NOT OPERATION
    assign not_b = ~B;
    
    //ternary operator
    assign mux_1 = (ALUControl[0] == 1'b0) ? B : not_b;
    
    //addition / subtraction operation
    assign {cout,sum} = A + mux_1 + ALUControl[0];

    //Zero Extension
    assign slt = (31'b000000000000000000000000000000, sum[31]);

    // Designing 4by1 Mux
    assign mux_2 = (ALUControl[2:0] == 3'b000) ? sum:
                   (ALUControl[2:0] == 3'b001) ? sum:
                   (ALUControl[2:0] == 3'b010) ? a_and_b:
                   (ALUControl[2:0] == 3'b011) ? a_or_b:
                   (ALUControl[2:0] == 3'b101) ? slt:32'h 00000000

    assign Result = mux_2;

    //flags assignments
    assign Z = &(~Result); // ZERO FLAG

    assign N = Result[31]; // Negative flag  

    assign C = cout &(~ALUControl[1]);  // CARRY FLAG

    assign V =(~ALUControl[1]) & (A[31] ^ sum[31]) & (~(A[31]^B[31]^ALUControl[0]));  //overflow flag



endmodule
    
