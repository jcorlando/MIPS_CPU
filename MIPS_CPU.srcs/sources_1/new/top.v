`timescale 1ns / 1ps

module top # (  parameter WL = 32, MEM_Depth = 64 )
(
    input CLK,                          // Clock
    input DMWE,                         // Data Memory
    input [WL - 1 : 0] DMA,             // Data Memory
    input [WL - 1 : 0] DMWD,            // Data Memory
    output [WL - 1 : 0] DMRD,           // Data Memory
    output [WL - 1 : 0] instruction     // Instruction Memory
);
    wire [WL - 1 : 0] pc_Out;           // Program Counter
    
    data_Mem # ( .WL(WL), .MEM_Depth(MEM_Depth) )
        dataMemory( .CLK(CLK), .DMWE(DMWE), .DMA(DMA), .DMWD(DMWD), .DMRD(DMRD) );
    
    pc # ( .WL(WL) )
        programCounter( .CLK(CLK), .pc_In(pc_Out), .pc_Out(pc_Out) );
    
    inst_Mem # ( .WL(WL), .MEM_Depth(MEM_Depth) )
        instMemory( .addr(pc_Out), .instruction(instruction) );
    
endmodule
