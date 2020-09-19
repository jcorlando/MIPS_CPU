`timescale 1ns / 1ps

module top # (  parameter WL = 32, MEM_Depth = 64 )
(
    input CLK                                                   // Clock
);
    wire [WL - 1 : 0] pc_Out;                                   // Program Counter
    wire [WL - 1 : 0] instruction;                              // Instruction Memory
    wire [5 : 0] opcode = control_Unit.opcode;                  // Control Unit
    wire [4 : 0] rs = control_Unit.rs;                          // Control Unit
    wire [4 : 0] rt = control_Unit.rt;                          // Control Unit
    wire [4 : 0] rd = control_Unit.rd;                          // Control Unit
    wire [15 : 0] Imm = control_Unit.Imm;                       // Control Unit
    wire [5 : 0] funct = control_Unit.funct;                    // Control Unit
    wire [25 : 0] Jaddr = control_Unit.Jaddr;                   // Control Unit
    wire [WL - 1 : 0] SImm = control_Unit.SImm;                 // Control Unit
    wire RFWE;                                                  // Control Unit
    wire DMWE;                                                  // Control Unit
    wire [3 : 0] ALU_Control;                                   // Control Unit
    wire [WL - 1 : 0] RFRD1;                                    // Register File
    wire [WL - 1 : 0] RFRD2;                                    // Register File
    wire [4 : 0] RFR1 = registerFile.RFR1;                      // Register File
    wire [4 : 0] RFR2 = registerFile.RFR2;                      // Register File
    wire signed [WL - 1 : 0] ALU_Out;                           // ALU
    wire [WL - 1 : 0] DMA;                                      // Data Memory
    wire [WL - 1 : 0] DMWD = RFRD2;                             // Data Memory
    wire [WL - 1 : 0] DMRD;                                     // Data Memory
    
    
    pc # ( .WL(WL) )                                                                        // Program Counter
        programCounter( .CLK(CLK), .pc_In(pc_Out), .pc_Out(pc_Out) );                       // Program Counter
    
    inst_Mem # ( .WL(WL), .MEM_Depth(MEM_Depth) )                                           // Instruction Memory
        instMemory( .addr(pc_Out), .instruction(instruction) );                             // Instruction Memory
        
    control_Unit # ( .WL(WL) )                                                              // Control Unit
        control_Unit( .instruction(instruction), .RFWE(RFWE),                               // Control Unit
                        .DMWE(DMWE), .ALU_Control(ALU_Control) );                           // Control Unit
    
    reg_File # ( .WL(WL) )                                                                  // Register File
        registerFile( .CLK(CLK), .RFWE(RFWE), .RFR1(rs), .RFR2(rt), .RFWA(rt),              // Register File
                        .RFWD(DMRD), .RFRD1(RFRD1), .RFRD2(RFRD2) );                        // Register File
    
    alu # (  .WL(WL) )                                                                      // ALU
        alu( .A(RFRD1), .B(SImm), .ALU_Out(ALU_Out), .ALU_Control(ALU_Control) );           // ALU
    
    data_Mem # ( .WL(WL), .MEM_Depth(MEM_Depth) )                                           // Data Memory
        dataMemory( .CLK(CLK), .DMWE(DMWE), .DMA(ALU_Out), .DMWD(RFRD2), .DMRD(DMRD) );      // Data Memory
    
endmodule
