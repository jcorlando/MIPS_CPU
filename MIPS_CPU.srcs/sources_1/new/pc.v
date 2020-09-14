`timescale 1ns / 1ps

module pc # (  parameter WL = 32 )
(
    input CLK,
    input [WL - 1 : 0] pc_In,
    output reg [WL - 1 : 0] pc_Out
);
    wire [WL - 1 : 0] pc = 0;
    assign pc = pc_In;
    assign pc_In = pc_Out;
    
    initial pc_Out <= 0;
    
    always @ (posedge CLK) pc_Out <= pc_Out + 1;
    
endmodule
