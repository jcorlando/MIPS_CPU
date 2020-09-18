`timescale 1ns / 1ps

module reg_File # (parameter WL = 32, MEM_Depth = 32)
(
    input CLK,
    input RFWE,
    input [4:0] RFR1, RFR2, RFWA,
    input [WL - 1 : 0] RFWD,
    output reg [WL - 1 : 0] RFRD1, RFRD2
);
    reg [WL - 1 : 0] rf[0 : MEM_Depth - 1];
    
    initial
    begin
        $readmemh("my_Reg_Memory.mem", rf);
        # 1
        RFRD1 = rf[RFR1];
        RFRD2 = rf[RFR2];
    end
    
    always @ (posedge CLK)
    begin
        if (RFWE) begin rf[RFWA] <= RFWD; end
        RFRD1 <= rf[RFR1];                          // Read First Mode
        RFRD2 <= rf[RFR2];                          // Read First Mode
    end
endmodule

