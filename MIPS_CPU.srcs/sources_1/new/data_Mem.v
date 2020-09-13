`timescale 1ns / 1ps

module data_Mem # ( parameter WL = 32, WL_addr = 32, MEM_Depth = 64 )
(
    input CLK, DMWE,
    input [WL_addr - 1 : 0] DMA,
    input [WL - 1 : 0] DMWD,
    output [WL - 1 : 0] DMRD
);
    
    reg [WL - 1 : 0] ram[MEM_Depth - 1 : 0];
    initial $readmemh("my_Data_Memory.mem", ram);
    
    assign DMRD = ram[DMA[WL_addr - 1 : 0]];        // Word Aligned
    
    always @ (posedge CLK)
    if (DMWE) ram[DMA[WL_addr - 1 : 0]] <= DMWD;    // Word Aligned
    
    
endmodule


