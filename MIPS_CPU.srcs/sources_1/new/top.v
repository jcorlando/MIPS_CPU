`timescale 1ns / 1ps

module top # (  parameter WL = 32,
                          WL_addr = 32,
                          MEM_Depth = 64 )
(
    input CLK, DMWE,
    input [WL_addr - 1 : 0] DMA,
    input [WL - 1 : 0] DMWD,
    output [WL - 1 : 0] DMRD
);
    
    data_Mem # ( .WL(WL), .WL_addr(WL_addr), .MEM_Depth(MEM_Depth) )
        dataMemory( .CLK(CLK), .DMWE(DMWE), .DMA(DMA), .DMWD(DMWD), .DMRD(DMRD) );
    
endmodule
