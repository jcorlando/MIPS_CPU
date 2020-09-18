`timescale 1ns / 1ps

module tb_MIPS_CPU;
// Parameters
parameter WL = 32, MEM_Depth = 64;
//Inputs
reg CLK;                                            // Clock
// Outputs
wire [WL - 1 : 0] pc_Out = DUT.pc_Out;              // Program Counter
wire [5 : 0] opcode = DUT.opcode;                   // Control Unit
wire [4 : 0] rs = DUT.rs;                           // Control Unit
wire [4 : 0] rt = DUT.rt;                           // Control Unit
wire [4 : 0] rd = DUT.rd;                           // Control Unit
wire [15 : 0] Imm = DUT.Imm;                        // Control Unit
wire [5 : 0] funct = DUT.funct;                     // Control Unit
wire [25 : 0] Jaddr = DUT.Jaddr;                    // Control Unit
wire [WL - 1 : 0] SImm = DUT.SImm;                  // Control Unit
wire [WL - 1 : 0] instruction = DUT.instruction;    // Instruction Memory
wire [WL - 1 : 0] RFRD1 = DUT.RFRD1;                // Register File
wire [WL - 1 : 0] RFRD2 = DUT.RFRD2;                // Register File
wire signed [WL - 1 : 0] ALU_Out = DUT.ALU_Out;     // ALU
wire DMWE = DUT.DMWE;                               // Data Memory
wire [WL - 1 : 0] DMA = DUT.dataMemory.DMA;         // Data Memory
wire [WL - 1 : 0] DMWD = DUT.DMWD;                  // Data Memory
wire [WL - 1 : 0] DMRD = DUT.DMRD;                  // Data Memory
// Instantiate DUT
    top # ( .WL(WL), .MEM_Depth(MEM_Depth) )
            DUT( .CLK(CLK)                          // Clock
               );
// Clock generation
always #110 CLK <= ~CLK;
initial
    begin
        CLK <= 0;                                   // Clock
        @(posedge CLK);                             // Clock
        @(posedge CLK);                             // Clock
        @(posedge CLK);                             // Clock
        @(posedge CLK);                             // Clock
    end
endmodule
