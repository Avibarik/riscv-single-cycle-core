 module alu(A,B,ALUControl,Result);
    // declaringg inputs
    input [31:0]A,B;
    input [2:0]ALUControl;

    //declaring outputs 
    output [31:0] Result;

    //declaring interim wires 
    wire[31:0] a_and_b;
    wire[31:0] a_or_b;
    wire[31:0] not_b;

    wire[31:0] mux_1;

    wire[31:0] sum;

    wire[31:0] mux_2;

     
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
    assign sum = A + mux_1 + ALUControl[0];

    // Designing 4by1 Mux
    assign mux_2 = (ALUControl[1:0] == 2'b00) ? sum:
                   (ALUControl[1:0] == 2'b01) ? sum:
                   (ALUControl[1:0] == 2'b10) ? a_and_b : a_or_b;

    assign Result = mux_2;
endmodule
    
