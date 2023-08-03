`timescale 1ns / 1ps
/////////////////////////////////////////////////////////////////////////////////
//
// Create Date: 08/01/2023 12:40:00 PM
//
// Module Name: my_i2c_tb.v
//
//////////////////////////////////////////////////////////////////////////////////

`define reset_all_signals() \
    // Address Write Channel \
    axi_awaddr  = 6'b000000; \
    axi_awprot  =    3'b000; \
    axi_awvalid =      1'b0; \
    // Write Data Channel \
    axi_wdata   =  32'h0000; \
    axi_wstrb   =   4'b0000; \
    axi_wvalid  =      1'b0; \
    // Write Response Channel \
    axi_bready  =      1'b0; \
    // Read Address Channel \
    axi_araddr  = 6'b000000; \
    axi_arprot  =    3'b000; \
    axi_arvalid =      1'b0; \
    // Read Data Channel \
    axi_rready  =      1'b0;


module my_i2c_tb();

    // Clock Signal 100MHz
    reg clk;
    initial begin
        clk = 0;
        forever #(5) clk = !clk;
    end

    wire              scl_io;
    wire              sda_io;
    wire      req_data_chunk;
    wire                busy;
    wire                nack;

    reg          axi_aresetn;

    // Address Write Channel
    reg   [ 5:0]  axi_awaddr;
    reg   [ 2:0]  axi_awprot;
    reg          axi_awvalid;
    wire         axi_awready; // output

    // Write Data Channel
    reg   [31:0]   axi_wdata;
    reg   [ 3:0]   axi_wstrb;
    reg           axi_wvalid;
    wire          axi_wready; // output

    // Write Response Channel
    wire  [ 1:0]   axi_bresp; // output
    wire          axi_bvalid; // output
    reg           axi_bready;

    // Read Address Channel
    reg   [ 5:0]  axi_araddr;
    reg   [ 2:0]  axi_arprot;
    reg          axi_arvalid;
    wire         axi_arready; // output

    // Read Data Channel
    wire [ 31:0]   axi_rdata; // output
    wire  [ 1:0]   axi_rresp; // output
    wire          axi_rvalid; // output
    reg           axi_rready;

    // Run Tests Here
    initial begin
        $timeformat(-9, 2, " ns", 20);

        axi_aresetn = 0;
        `reset_all_signals

        #50;
        axi_aresetn = 1;

        $display("Test #1 Write 0xABCD to Reg $5");
        // Write Address and Data together
        axi_awaddr = 6'b000101 << 2;
        axi_awvalid = 1'b1;
        axi_wdata = 32'hABCD;
        axi_wstrb = 4'b0011;
        axi_wvalid = 1'b1;
        // Wait for AXI slave to ACK
        wait (axi_awready == 1'b1 &&
              axi_wready == 1'b1);
        // Wait for AXI slave to reset
        wait (axi_awready == 1'b0 &&
              axi_wready == 1'b0);
        // Stop writing address and data
        axi_awvalid = 0;
        axi_wvalid = 0;
        // Wait for slave to ACK response
        wait (axi_bvalid == 1'b1);
        // Send ack to slave
        axi_bready = 1'b1;
        wait (axi_bvalid == 1'b0);
        axi_bready = 1'b0;
        // Delay between next operation
        #10;
        // Reset all signals
        `reset_all_signals

        axi_arvalid = 1'b1;
        axi_araddr = 6'b000101 << 2;
        // Wait for AXI slave to send data
        wait (axi_arready == 1'b1);
        wait (axi_rvalid == 1'b1);
        assert (axi_rdata == 32'hABCD)
            $display("  - Read 0x%x value back successfully", axi_rdata);
        else
            $error("Failed to read correct value back, 0x%x != 0x%x", axi_rdata, 32'hABCD);
        // Signal to AXI Slave that data has been read
        axi_arvalid = 1'b0;
        axi_rready = 1'b1;
        wait (axi_rvalid == 1'b0);

        `reset_all_signals
        $display("Test #1 Finished");

        $display("Test #2 - I2C Write 0 bytes");
        // Write Address of Device to Reg #1
        $display("  - Writing Address of Device 0x5B to Reg 0");
        axi_awaddr = 6'b000000 << 2;
        axi_awvalid = 1'b1;
        axi_wdata = 32'h00005B;
        axi_wstrb = 4'b0111;
        axi_wvalid = 1'b1;
        // Wait for AXI slave to ACK
        wait (axi_awready == 1'b1 &&
              axi_wready == 1'b1);
        // Wait for AXI slave to reset
        wait (axi_awready == 1'b0 &&
              axi_wready == 1'b0);
        // Stop writing address and data
        axi_awvalid = 0;
        axi_wvalid = 0;
        // Wait for slave to ACK response
        wait (axi_bvalid == 1'b1);
        // Send ack to slave
        axi_bready = 1'b1;
        wait (axi_bvalid == 1'b0);
              axi_bready = 1'b0;
       // Delay between next operation
        #10;
        // Reset all signals (to be clean)
        `reset_all_signals

        // Write Sub-Address to Reg #1
        $display("  - Writing Register Address 0x00 Reg 1");
        axi_awaddr = 6'b000001 << 2;
        axi_awvalid = 1'b1;
        axi_wdata = 32'h000000;
        axi_wstrb = 4'b0111;
        axi_wvalid = 1'b1;
        // Wait for AXI slave to ACK
        wait (axi_awready == 1'b1 &&
              axi_wready == 1'b1);
        // Wait for AXI slave to reset
        wait (axi_awready == 1'b0 &&
              axi_wready == 1'b0);
        // Stop writing address and data
        axi_awvalid = 0;
        axi_wvalid = 0;
        // Wait for slave to ACK response
        wait (axi_bvalid == 1'b1);
        // Send ack to slave
        axi_bready = 1'b1;
        wait (axi_bvalid == 1'b0);
        axi_bready = 1'b0;
        // Delay between next operation
        #10;
        // Reset all signals
        `reset_all_signals

        // Write Num of Bytes to Reg #2
        $display("  - Writing Length to Reg 3");
        axi_awaddr = 6'b000010 << 2;
        axi_awvalid = 1'b1;
        axi_wdata = 32'h000000;
        axi_wstrb = 4'b0111;
        axi_wvalid = 1'b1;
        // Wait for AXI slave to ACK
        wait (axi_awready == 1'b1 &&
              axi_wready == 1'b1);
        wait (axi_awready == 1'b0 &&
              axi_wready == 1'b0);
        // Stop writing address and data
        axi_awvalid = 0;
        axi_wvalid = 0;
        // Wait for slave to ACK response
        wait (axi_bvalid == 1'b1);
        // Send ack to slave
        axi_bready = 1'b1;
        wait (axi_bvalid == 1'b0);
        axi_bready = 1'b0;
        // Delay between next operation
        #10;
        // Reset all signals
        `reset_all_signals

        // Kick off write by writing to Reg 7
        $display("  - Starting I2C by writing to Reg 7");
        axi_awaddr = 6'b000111 << 2;
        axi_awvalid = 1'b1;
        axi_wdata = 32'h000000;
        axi_wstrb = 4'b0111;
        axi_wvalid = 1'b1;
        // Wait for AXI slave to ACK
        wait (axi_awready == 1'b1 &&
              axi_wready == 1'b1);
        wait (axi_awready == 1'b0 &&
              axi_wready == 1'b0);
        // Stop writing address and data
        axi_awvalid = 0;
        axi_wvalid = 0;
        // Wait for slave to ACK response
        wait (axi_bvalid == 1'b1);
        // Send ack to slave
        axi_bready = 1'b1;
        wait (axi_bvalid == 1'b0);
        axi_bready = 1'b0;
        // Delay between next operation
        #10;
        // Reset all signals
        `reset_all_signals

        // Wait for I2C IP to stop being 'busy'
        wait (dbg2_busy == 1'b0);

//        $finish();
    end

    // Instantiate my_i2c
    my_i2c #(
        .C_S_AXI_DATA_WIDTH(32),
        .C_S_AXI_ADDR_WIDTH(6)
    )
        my_i2c_ip_dut(
            // I2C
            .my_scl_i(my_scl_i),
            .my_scl_o(my_scl_o),
            .my_scl_t(my_scl_t),
            .my_sda_i(my_sda_i),
            .my_sda_o(my_sda_o),
            .my_sda_t(my_sda_t),
            // Debug Lines
            .dbg2_i2c_write_en(dbg2_i2c_write_en),
            .dbg2_busy(dbg2_busy),
            .dbg2_req_data_chunk(dbg2_req_data_chunk),
            .dbg2_nack(dbg2_nack),
            // Ports of Axi Slave Bus Interface S00_AXI
            .s00_axi_aclk(clk),
             //Global Reset Signal. This Signal is Active LOW
            .s00_axi_aresetn(axi_aresetn),
            // Write address (issued by master, acceped by Slave)
            .s00_axi_awaddr(axi_awaddr),
            // Write channel Protection type
            .s00_axi_awprot(axi_awprot),
            // Write address valid
            .s00_axi_awvalid(axi_awvalid),
            // Write address ready
            .s00_axi_awready(axi_awready),
            // Write data
            .s00_axi_wdata(axi_wdata),
            // Write strobes
            .s00_axi_wstrb(axi_wstrb),
            // Write valid
            .s00_axi_wvalid(axi_wvalid),
            // Write ready
            .s00_axi_wready(axi_wready),
            // Write response
            .s00_axi_bresp(axi_bresp),
            // Write response valid
            .s00_axi_bvalid(axi_bvalid),
            // Response ready
            .s00_axi_bready(axi_bready),
            // Read address
            .s00_axi_araddr(axi_araddr),
            // Protection type
            .s00_axi_arprot(axi_arprot),
            // Read address valid
            .s00_axi_arvalid(axi_arvalid),
            // Read address ready
            .s00_axi_arready(axi_arready),
            // Read data
            .s00_axi_rdata(axi_rdata),
            // Read response
            .s00_axi_rresp(axi_rresp),
            // Read valid
            .s00_axi_rvalid(axi_rvalid),
            // Read ready
            .s00_axi_rready(axi_rready)
        );
endmodule
