`timescale 1ns / 1ps

module Single_Cycle_Top_Tb ();

    reg clk;
    reg rst;

    // Unit Under Test (UUT)
    Single_Cycle_Top Single_Cycle_Top (
        .clk(clk),
        .rst(rst)
    );

    // Clock generator: 100ns period (50ns low, 50ns high)
    always begin
        #50 clk = ~clk;
    end

    // Single unified test sequence
    initial begin
        // Initialize signals
        clk = 1'b0;
        rst = 1'b0;     // Assert active-low reset

        // Hold reset for 150ns (past the first rising edge at 50ns and falling edge at 100ns)
        #175;
        rst = 1'b1;     // Release reset, CPU begins execution

        // Run CPU for instructions to execute
        #1000;

        $finish;
    end

    // Waveform dump
    initial begin
        $dumpfile("Single_Cycle.vcd");
        $dumpvars(0, Single_Cycle_Top_Tb);
    end

    // Instruction execution monitor
    always @(posedge clk) begin
        if (rst && Single_Cycle_Top.PC_Top <= 32'h1C) begin
            $display("Time=%0t | PC=0x%02h | Instr=0x%08h | ALUResult=0x%08h | RegWrite=%b",
                     $time, Single_Cycle_Top.PC_Top, Single_Cycle_Top.RD_Instr, 
                     Single_Cycle_Top.ALUResult, Single_Cycle_Top.RegWrite);
        end
    end

endmodule
