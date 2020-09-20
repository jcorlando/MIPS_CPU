`timescale 1ns / 1ps

module control_Unit # ( parameter WL = 32 )
(
    input [WL - 1 : 0] instruction,
    output reg RFWE,
    output reg DMWE,
    output reg ALUSrc,
    output reg MemtoReg,
    output reg RegDst,
    output reg [3 : 0] ALU_Control
);
    wire [5 : 0] opcode = instruction[31 : 26];
    wire [4 : 0] rs = instruction[25 : 21];
    wire [4 : 0] rt = instruction[20 : 16];
    wire [4 : 0] rd = instruction[15 : 11];
    wire [15 : 0] Imm = instruction[15 : 0];
    wire [4 : 0] shamt = instruction[10 : 6];
    wire [5 : 0] funct = instruction[5 : 0];
    wire [25 : 0] Jaddr = instruction[25 : 0];
    wire signed [WL - 1 : 0] SImm = { {(WL - 16){Imm[15]}} ,Imm[15:0] };
    
    always @ (*)
    begin
        case(opcode)
            35:     //  LW
            begin
                ALU_Control <= 4'b0000;
                RFWE <= 1;
                DMWE <= 0;
                ALUSrc <= 1;
                MemtoReg <= 1;
                RegDst <= 0;
            end
            
            43:     //  SW
            begin
                ALU_Control <= 4'b0000;
                RFWE <= 0;
                DMWE <= 1;
                ALUSrc <= 1;
                MemtoReg <= 1;
                RegDst <= 0;
            end
            
       //////////////////Begin R-Type Instruction//////////////////////////////////////////////////
            0:    // R-Type
                case(funct)
                    32:     //  ADD
                    begin
                        ALU_Control <= 4'b0000;
                        RFWE <= 1;
                        DMWE <= 0;
                        ALUSrc <= 0;
                        MemtoReg <= 0;
                        RegDst <= 1;
                    end
                    
                    34:     //  SUB
                    begin
                        ALU_Control <= 4'b0001;
                        RFWE <= 1;
                        DMWE <= 0;
                        ALUSrc <= 0;
                        MemtoReg <= 0;
                        RegDst <= 1;
                    end
                    
                    4:     //  SLLV
                    begin
                        ALU_Control <= 4'b0100;
                        RFWE <= 1;
                        DMWE <= 0;
                        ALUSrc <= 0;
                        MemtoReg <= 0;
                        RegDst <= 1;
                    end
                    
                    7:     //  SRAV
                    begin
                        ALU_Control <= 4'b0101;
                        RFWE <= 1;
                        DMWE <= 0;
                        ALUSrc <= 0;
                        MemtoReg <= 0;
                        RegDst <= 1;
                    end
                    
                    0:     //  SLL
                    begin
                        ALU_Control <= 4'b0010;
                        RFWE <= 1;
                        DMWE <= 0;
                        ALUSrc <= 0;
                        MemtoReg <= 0;
                        RegDst <= 1;
                    end
                endcase
      ///////////////////////End R-type Instruction///////////////////////////////////////
            
            8:    // ADDI
            begin
                ALU_Control <= 4'b0000;
                RFWE <= 1;
                DMWE <= 0;
                ALUSrc <= 1;
                MemtoReg <= 0;
                RegDst <= 0;
            end
            
            default:    // Default
            begin
                ALU_Control <= 4'b0000;
                RFWE <= 0;
                DMWE <= 0;
                ALUSrc <= 1;
                MemtoReg <= 1;
                
            end
            
        endcase
    end
    
endmodule
