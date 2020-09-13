`timescale 1ns / 1ps

module reg_File # (parameter WL = 32, MEM_Depth = 32)
(
    input CLK,
    input RFWE,
    input [4:0] RFR1, RFR2, RFWA,
    input [WL - 1 : 0] RFWD,
    output [WL - 1 : 0] RFRD1, RFRD2
);
    
    reg [WL - 1 : 0] rf[0 : MEM_Depth - 1];
    reg [4:0] read_addr_1;      // Registered address for write-first mode
    reg [4:0] read_addr_2;      // Registered address for write-first mode
    
    always @ (posedge CLK)
    begin
        if (RFWE) begin rf[RFWA] <= RFWD; end
        read_addr_1 <= RFR1;        // Registered address for write-first mode
        read_addr_2 <= RFR2;        // Registered address for write-first mode
    end
    
    assign RFRD1 = rf[read_addr_1];     // Asynchronous Read
    assign RFRD2 = rf[read_addr_2];     // Asynchronous Read
    
endmodule

