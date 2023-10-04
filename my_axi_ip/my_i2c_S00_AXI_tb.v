`timescale 1ns / 1ps
///////////////////////////////////////////////////////////////////////////////
// 
// Create Date: 07/16/2023 01:13:34 PM
// Module Name: test_bench
// 
///////////////////////////////////////////////////////////////////////////////

//`define reset_all() \
//    // Address Write Channel \
//    axi_awaddr = 5'b00000; \
//    axi_awvalid = 1'b0; \
//    // Write Channel \
//    axi_wdata = 32'h0000; \
//    axi_wstrb = 4'b0000; \
//    axi_wvalid = 1'b0; \
//    // Write Response Channel \
//    axi_bready = 1'b0; \
//    // Read Address Channel \
//    axi_araddr = 5'b00000; \
//    axi_arprot = 3'b000; \
//    axi_arvalid = 1'b0; \
//    // Read Data Channel \
//    axi_rready = 1'b0;

module my_axi_ip_S00_AXI_tb ();

    // Clock Signal 100MHz
    reg clk;
    initial begin
        clk = 0;
        forever #(5) clk = !clk;  // 100MHz clock
    end

//    wire scl_i;
//    wire scl_o;
//    wire scl_t;
//    wire sda_i;
//    wire sda_o;
//    wire sda_t;
//
//    wire i2c_write_en;
//    wire req_data_chunk;
//    wire busy;
//    wire nack;
//
//    reg axi_aresetn;
//
//    reg  [ 5:0]  axi_awaddr;
//    
//    reg  [ 2:0]  axi_awprot;
//    reg          axi_awvalid;
//    wire         axi_awready; // output
//    
//    reg  [31:0]  axi_wdata; 
//    reg  [ 3:0]  axi_wstrb;
//    reg          axi_wvalid;
//    wire         axi_wready; // output
//
//    wire [ 1:0]  axi_bresp; // output
//    wire         axi_bvalid; // output
//    reg          axi_bready;
//
//    reg  [ 5:0]  axi_araddr;
//    reg  [ 2:0]  axi_arprot;
//    reg          axi_arvalid;
//    wire         axi_arready; // output
//
//    wire [31:0]  axi_rdata; // output
//    wire [ 1:0]  axi_rresp; // output
//    wire         axi_rvalid; // output
//    reg          axi_rready;

    // Run Tests Here
    initial begin
        $timeformat(-9, 2, " ns", 20);

        // Initialize default values
        $display("Setting default values");

        // Reset IP
//        `reset_all


//        axi_awvalid = 1'b0;
//        axi_wvalid = 1'b0;
//        axi_bready = 1'b0;
//        axi_arvalid = 1'b0;
//        axi_rready = 1'b0;
//        $display("Wrote 0xEF to register 7");

        $finish();
    end

    my_axi_ip_S00_AXI #(
        .C_S_AXI_DATA_WIDTH(32),
        .C_S_AXI_ADDR_WIDTH(6)
    )
        my_axi_ip_S00_AXI_dut(
            // UART
            .uart_rxd                (                uart_rxd),
            .uart_txd                (                uart_txd),
            .uart_clk_edge           (           uart_clk_edge),
            .o_SM_Main               (               o_SM_Main),
            // Debug Lines
            .dbg_uart_write_en       (       dbg_uart_write_en),
            .dbg_uart_writing        (        dbg_uart_writing),
            .dbg_uart_write_data     (     dbg_uart_write_data),
            .dbg_uart_write_finished ( dbg_uart_write_finished),
            .dbg_uart_write_count    (    dbg_uart_write_count),

            .dbg_o_tx_active         (         dbg_o_tx_active),
            .dbg_o_tx_serial         (         dbg_o_tx_serial),
            .dbg_o_tx_done           (           dbg_o_tx_done),

            // Global Clock Signal
            .S_AXI_ACLK(clk),

             //Global Reset Signal. This Signal is Active LOW
            .S_AXI_ARESETN(axi_aresetn),

            // Write Address Channel
            .S_AXI_AWADDR(axi_awaddr),
            .S_AXI_AWPROT(axi_awprot),
            .S_AXI_AWVALID(axi_awvalid),
            .S_AXI_AWREADY(axi_awready),

            // Write Data Channel
            .S_AXI_WDATA(axi_wdata),
            .S_AXI_WSTRB(axi_wstrb),
            .S_AXI_WVALID(axi_wvalid),
            .S_AXI_WREADY(axi_wready),

            // Write Response Channel
            .S_AXI_BRESP(axi_bresp),
            .S_AXI_BVALID(axi_bvalid),
            .S_AXI_BREADY(axi_bready),

            // Read Address Channel
            .S_AXI_ARADDR(axi_araddr),
            .S_AXI_ARPROT(axi_arprot),
            .S_AXI_ARVALID(axi_arvalid),
            .S_AXI_ARREADY(axi_arready),

            // Read Data Channel
            .S_AXI_RDATA(axi_rdata),
            .S_AXI_RRESP(axi_rresp),
            .S_AXI_RVALID(axi_rvalid),
            .S_AXI_RREADY(axi_rready)
        );
endmodule
