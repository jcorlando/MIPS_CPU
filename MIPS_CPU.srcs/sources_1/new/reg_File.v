`timescale 1ns / 1ps

module reg_File # (parameter WL = 32)
(
    input CLK,
    input RFWE,
    input [4:0] RFR1, RFR2, RFWA,
    input [WL - 1 : 0] RFWD,
    output reg [WL - 1 : 0] RFRD1, RFRD2
);
    reg [WL - 1 : 0] rf[0 : 31];
    
    initial $readmemh("my_Reg_Memory.mem", rf);     // Initialize Register File
    initial
    begin
        RFRD1 <= 0;                                 // Initialize Register File
        RFRD2 <= rf[RFR2];                          // Initialize Register File
    end
    
    always @ (posedge CLK)
    begin
        if (RFWE) begin rf[RFWA] <= RFWD; end
        RFRD1 <= rf[RFR1];                          // Read First Mode
        RFRD2 <= rf[RFR2];                          // Read First Mode
    end
endmodule

