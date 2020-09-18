`timescale 1ns / 1ps

module top # (  parameter WL = 32, MEM_Depth = 32 )
(
    input CLK                                                   // Clock
);
    wire [WL - 1 : 0] pc_Out;                                   // Program Counter
    wire [5 : 0] opcode = control_Unit.opcode;                  // Control Unit
    wire [4 : 0] rs = control_Unit.rs;                          // Control Unit
    wire [4 : 0] rt = control_Unit.rt;                          // Control Unit
    wire [4 : 0] rd = control_Unit.rd;                          // Control Unit
    wire [15 : 0] Imm = control_Unit.Imm;                       // Control Unit
    wire [5 : 0] funct = control_Unit.funct;                    // Control Unit
    wire [25 : 0] Jaddr = control_Unit.Jaddr;                   // Control Unit
    wire [WL - 1 : 0] SImm = control_Unit.SImm;                 // Control Unit
    wire [WL - 1 : 0] instruction;                              // Instruction Memory
    wire [WL - 1 : 0] RFRD1;                                    // Register File
    wire [WL - 1 : 0] RFRD2;                                    // Register File
    wire signed [WL - 1 : 0] ALU_Out;                           // ALU
    wire DMWE;                                                  // Data Memory
    wire [WL - 1 : 0] DMA;                                      // Data Memory
    wire [WL - 1 : 0] DMWD;                                     // Data Memory
    wire [WL - 1 : 0] DMRD;                                     // Data Memory
    
    control_Unit # ( .WL(WL) )                                                              // Control Unit
        control_Unit( .instruction(instruction) );                                          // Control Unit
    
    pc # ( .WL(WL) )                                                                        // Program Counter
        programCounter( .CLK(CLK), .pc_In(pc_Out), .pc_Out(pc_Out) );                       // Program Counter
    
    inst_Mem # ( .WL(WL), .MEM_Depth(MEM_Depth) )                                           // Instruction Memory
        instMemory( .addr(pc_Out), .instruction(instruction) );                             // Instruction Memory
    
    reg_File # ( .WL(WL), .MEM_Depth(MEM_Depth) )                                           // Register File
        registerFile( .CLK(CLK), .RFR1(rs), .RFR2(rt), .RFWD(DMRD),                         // Register File
                        .RFRD1(RFRD1), .RFRD2(RFRD2) );                                     // Register File
    
    alu # (  .WL(WL) )                                                                      // ALU
        alu( .A(RFRD1), .B(SImm), .ALU_Out(ALU_Out) );                                      // ALU
    
    data_Mem # ( .WL(WL), .MEM_Depth(MEM_Depth) )                                           // Data Memory
        dataMemory( .CLK(CLK), .DMWE(DMWE), .DMA(ALU_Out), .DMWD(DMWD), .DMRD(DMRD) );      // Data Memory
    
endmodule
