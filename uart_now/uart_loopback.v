`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/05/2023 09:21:21 PM
// Design Name: 
// Module Name: uart_loopback
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module uart_loopback(
    output uart_rtl_rxd_in,
    input uart_rtl_txd_in,
    output uart_rtl_rxd_out,
    input uart_rtl_txd_out
    );
    assign uart_rtl_rxd_in = uart_rtl_txd_out;
    assign uart_rtl_rxd_out = uart_rtl_txd_in;
endmodule
