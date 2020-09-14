`timescale 1ns / 1ps

module tb_MIPS_CPU;
// Parameters
parameter WL = 32, MEM_Depth = 64;
//Inputs
reg CLK;                                        // Clock
reg DMWE;                                       // Data Memory
reg [WL - 1 : 0] DMA;                           // Data Memory
reg [WL - 1 : 0] DMWD;                          // Data Memory
// Outputs
wire [WL - 1 : 0] DMRD;                         // Data Memory
wire [WL - 1 : 0] instruction;                  // Instruction Memory
// Instantiate DUT
    top # ( .WL(WL), .MEM_Depth(MEM_Depth) )
            DUT( .CLK(CLK),                     // Clock
                 .DMWE(DMWE),                   // Data Memory
                 .DMA(DMA),                     // Data Memory
                 .DMWD(DMWD),                   // Data Memory
                 .DMRD(DMRD),                   // Data Memory
                 .instruction(instruction)      // Instruction Memory
               );
// Clock generation
always #110 CLK <= ~CLK;
initial
    begin
        CLK <= 0;                           // Clock
        DMWD <= 0;                          // Data Memory
        DMWE <= 0;                          // Data Memory
        DMA  <= 0;                          // Data Memory
        @(posedge CLK);                     // Clock
        DMA  <= 1;                          // Data Memory
        @(posedge CLK);                     // Clock
        DMA  <= 2;                          // Data Memory
        @(posedge CLK);                     // Clock
        DMA  <= 3;                          // Data Memory
        @(posedge CLK);                     // Clock
        DMA  <= 4;                          // Data Memory
    end
endmodule
