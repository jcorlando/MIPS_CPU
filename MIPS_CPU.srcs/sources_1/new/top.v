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
    wire [WL - 1 : 0] pc_Out;                       // Program Counter
    wire [5 : 0] opcode = control_Unit.opcode;      // Control Unit
    wire [4 : 0] rs = control_Unit.rs;              // Control Unit
    wire [4 : 0] rt = control_Unit.rt;              // Control Unit
    wire [4 : 0] rd = control_Unit.rd;              // Control Unit
    wire [15 : 0] Imm = control_Unit.Imm;           // Control Unit
    wire [5 : 0] funct = control_Unit.funct;        // Control Unit
    wire [25 : 0] Jaddr = control_Unit.Jaddr;       // Control Unit
    
    control_Unit # ( .WL(WL) )
        control_Unit( .instruction(instruction) );
    
    
    data_Mem # ( .WL(WL), .MEM_Depth(MEM_Depth) )
        dataMemory( .CLK(CLK), .DMWE(DMWE), .DMA(DMA), .DMWD(DMWD), .DMRD(DMRD) );
    
    pc # ( .WL(WL) )
        programCounter( .CLK(CLK), .pc_In(pc_Out), .pc_Out(pc_Out) );
    
    inst_Mem # ( .WL(WL), .MEM_Depth(MEM_Depth) )
        instMemory( .addr(pc_Out), .instruction(instruction) );
    
endmodule
