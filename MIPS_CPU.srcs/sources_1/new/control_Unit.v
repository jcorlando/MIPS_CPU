`timescale 1ns / 1ps

module control_Unit # ( parameter WL = 32 )
(
    input [WL - 1 : 0] instruction,
    output reg RFWE,
    output reg DMWE,
    output reg [3 : 0] ALU_Control

);
    wire [5 : 0] opcode = instruction[31 : 26];
    wire [4 : 0] rs = instruction[25 : 21];
    wire [4 : 0] rt = instruction[20 : 16];
    wire [4 : 0] rd = instruction[15 : 11];
    wire [15 : 0] Imm = instruction[15 : 0];
    wire [5 : 0] funct = instruction[5 : 0];
    wire [25 : 0] Jaddr = instruction[25 : 0];
    wire [WL - 1 : 0] SImm = { {(WL - 16){Imm[15]}} ,Imm[15:0] };
    
    always @ (*)
    begin
        case(opcode)
            
            35:
            begin
                ALU_Control <= 4'b0000;
                RFWE <= 1;
                DMWE <= 0;
            end
            
            43:
            begin
                ALU_Control <= 4'b0000;
                RFWE <= 0;
                DMWE <= 1;
            end
            
            default:
            begin
                ALU_Control <= 4'b0000;
                RFWE <= 0;
                DMWE <= 0;
            end
            
        endcase
    end
    
endmodule
