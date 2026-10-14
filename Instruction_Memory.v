module Instruction_Memory(rst,A,RD);

  input rst;
  input [31:0]A;
  output [31:0]RD;

    reg [31:0] mem [1023:0];
  integer i;

  assign RD = (~rst) ? {32{1'b0}} : mem[A[31:2]];

  initial begin
    for (i = 0; i < 1024; i = i + 1)
      mem[i] = 32'h00000000;
    $readmemh("memfile.hex", mem);
  end


/*
  initial begin
    //mem[0] = 32'hFFC4A303;
    //mem[1] = 32'h00832383;
    // mem[0] = 32'h0064A423;
    // mem[1] = 32'h00B62423;
    mem[0] = 32'h0062E233;
    // mem[1] = 32'h00B62423;

  end
*/
endmodule