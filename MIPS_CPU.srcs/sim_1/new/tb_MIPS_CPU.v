`timescale 1ns / 1ps

module tb_MIPS_CPU;
// Parameters
parameter WL = 32, WL_addr = 32, MEM_Depth = 64;
//Inputs
reg CLK;
reg DMWE;
reg [WL_addr - 1 : 0] DMA;
reg [WL - 1 : 0] DMWD;
// Outputs
wire [WL - 1 : 0] DMRD;
// Instantiate DUT
top      # ( .WL(WL), .WL_addr(WL_addr), .MEM_Depth(MEM_Depth) )
                DUT( .CLK(CLK), .DMWE(DMWE), .DMA(DMA), .DMWD(DMWD), .DMRD(DMRD) );

// Clock generation
always #125 CLK <= ~CLK;
initial
    begin
        CLK <= 0;
        DMWD <= 0;
        DMWE <= 0;
        DMA  <= 32'h00000000;
        @(posedge CLK);
        DMA  <= 32'h00000001;
        @(posedge CLK);
        DMA  <= 32'h00000002;
        @(posedge CLK);
        DMA  <= 32'h00000003;
        @(posedge CLK);
        DMA  <= 32'h00000004;
    end
endmodule
