`timescale 1ns / 1ps

module top # (  parameter WL = 32, MEM_Depth = 64 )
(
    input CLK,                          // Clock
    input DMWE,                         // Data Memory
    input [WL - 1 : 0] DMA,             // Data Memory
    input [WL - 1 : 0] DMWD,            // Data Memory
    output [WL - 1 : 0] DMRD,           // Data Memory
    input [WL - 1 : 0] addr,            // Instruction Memory
    output [WL - 1 : 0] instruction     // Instruction Memory
);
    
    data_Mem # ( .WL(WL), .MEM_Depth(MEM_Depth) )
        dataMemory( .CLK(CLK), .DMWE(DMWE), .DMA(DMA), .DMWD(DMWD), .DMRD(DMRD) );
    
    inst_Mem # ( .WL(WL), .MEM_Depth(MEM_Depth) )
        instMemory( .addr(addr), .instruction(instruction) );
    
    
endmodule
