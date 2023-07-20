`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
// Create Date: 07/16/2023 01:13:34 PM
// 
//////////////////////////////////////////////////////////////////////////////////

`define reset_all() \
    // Address Write Channel \
    axi_awaddr = 5'b0000; \
    axi_awvalid = 1'b0; \
    // Write Channel \
    axi_wdata = 32'h0000; \
    axi_wstrb = 4'b0000; \
    axi_wvalid = 1'b0; \
    // Write Response Channel \
    axi_bready = 1'b0; \
    // Read Address Channel \
    axi_araddr = 5'b00000; \
    axi_arprot = 3'b000; \
    axi_arvalid = 1'b0; \
    // Read Data Channel \
    axi_rready = 1'b0;

module test_bench(

    );
    
    // Clock Signal 100MHz
    reg clk;
    initial begin
        clk = 0;
        forever #(5) clk = !clk;  //100MHz clock
    end

    wire scl_io;
    wire sda_io;
    wire req_data_chunk;
    wire busy;
    wire nack;

    reg axi_aresetn;

    reg  [ 4:0]  axi_awaddr;
    reg  [ 2:0]  axi_awprot;
    reg          axi_awvalid;
    wire         axi_awready; // output
    
    reg  [31:0]  axi_wdata; 
    reg  [ 3:0]  axi_wstrb;
    reg          axi_wvalid;
    wire         axi_wready; // output

    wire [ 1:0]  axi_bresp; // output
    wire         axi_bvalid; // output
    reg          axi_bready;

    reg  [ 4:0]  axi_araddr;
    reg  [ 2:0]  axi_arprot;
    reg          axi_arvalid;
    wire         axi_arready; // output

    wire [31:0]  axi_rdata; // output
    wire [ 1:0]  axi_rresp; // output
    wire         axi_rvalid; // output
    reg          axi_rready;

    // Run Tests Here
    initial begin
        $timeformat(-9, 2, " ns", 20);

        axi_aresetn = 0;
        `reset_all

        #50;
        axi_aresetn = 1;

        $display("Test #1 Write 0xABCD to reg 0x5");
        axi_awaddr = 5'b00101 << 2;
        axi_wdata = 32'hABCD;
        axi_awvalid = 1'b1;
        axi_wstrb = 4'b0011;
        axi_wvalid = 1'b1;
        // Wait for AXI slave to ACK
        wait (axi_awready == 1'b1 &&
              axi_wready == 1'b1);
        wait (axi_awready == 1'b0 &&
              axi_wready == 1'b0);
        axi_awvalid = 0;
        axi_wvalid = 0;
        wait (axi_bvalid == 1'b1);
        // Ack
        axi_bready = 1'b1;
        wait (axi_bvalid == 1'b0);
        axi_bready = 1'b0;
        // Delay between next operation
        #10;
        `reset_all

        axi_arvalid = 1'b1;
        axi_araddr = 5'b00101 << 2;
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

        `reset_all
        $display("Test #1 Finished");

        $display("Test #2 Write 2 values, Read 2 values");
        $display("  - Writing 0xAAA0 to Reg 0");
        // Write to Reg #0
        axi_awaddr = 5'b00000 << 2;
        axi_wdata = 32'hAAA0;
        axi_awvalid = 1'b1;
        axi_wstrb = 4'b0011;
        axi_wvalid = 1'b1;
        // Wait for AXI slave to ACK
        wait (axi_awready == 1'b1 &&
              axi_wready == 1'b1);
        wait (axi_awready == 1'b0 &&
              axi_wready == 1'b0);
        axi_awvalid = 0;
        axi_wvalid = 0;
        wait (axi_bvalid == 1'b1);
        // Ack
        axi_bready = 1'b1;
        wait (axi_bvalid == 1'b0);
        axi_bready = 1'b0;
        // Delay between next operation
        #10;
        `reset_all

        // Write to Reg #1
        $display("  - Writing 0xAAA1 to Reg 1");
        axi_awaddr = 5'b00001 << 2;
        axi_wdata = 32'hAAA1;
        axi_awvalid = 1'b1;
        axi_wstrb = 4'b0011;
        axi_wvalid = 1'b1;
        // Wait for AXI slave to ACK
        wait (axi_awready == 1'b1 &&
              axi_wready == 1'b1);
        wait (axi_awready == 1'b0 &&
              axi_wready == 1'b0);
        axi_awvalid = 0;
        axi_wvalid = 0;
        wait (axi_bvalid == 1'b1);
        // Ack
        axi_bready = 1'b1;
        wait (axi_bvalid == 1'b0);
        axi_bready = 1'b0;
        // Delay between next operation
        #10;
        `reset_all

        $display("  - Now read both values back");
        // Read 1st value back
        axi_arvalid = 1'b1;
        axi_araddr = 5'b00000 << 2;
        // Wait for AXI slave to send data
        wait (axi_arready == 1'b1);
        wait (axi_rvalid == 1'b1);
        assert (axi_rdata == 32'hAAA0)
            $display("  - Read 0x%x value back successfully from Reg 0", axi_rdata);
        else
            $error("Failed to read correct value back, 0x%x != 0x%x", axi_rdata, 32'hAAA0);
        // Signal to AXI Slave that data has been read
        axi_arvalid = 1'b0;
        axi_rready = 1'b1;
        wait (axi_rvalid == 1'b0);
        // Delay between next operation
        `reset_all
        #20;

        // Read 2nd value back
        axi_arvalid = 1'b1;
        axi_araddr = 5'b00001 << 2;
        // Wait for AXI slave to send data
        wait (axi_arready == 1'b1);
        wait (axi_rvalid == 1'b1);
        assert (axi_rdata == 32'hAAA1)
            $display("  - Read 0x%x value back successfully from Reg 1", axi_rdata);
        else
            $error("Failed to read correct value back, 0x%x != 0x%x", axi_rdata, 32'hAAA1);
        // Signal to AXI Slave that data has been read
        axi_arvalid = 1'b0;
        axi_rready = 1'b1;
        wait (axi_rvalid == 1'b0);
        `reset_all
        #20;

        $display("Test #2 Finished");

        $display("Test #3 Prepare for I2C Write");
        // Write Address of Device to Reg #1
        $display("  - Writing Address of Device 0xFE to Reg 0");
        axi_awaddr = 5'b00000 << 2;
        axi_wdata = 32'h00005B;
        axi_awvalid = 1'b1;
        axi_wstrb = 4'b0111;
        axi_wvalid = 1'b1;
        // Wait for AXI slave to ACK
        wait (axi_awready == 1'b1 &&
              axi_wready == 1'b1);
        wait (axi_awready == 1'b0 &&
              axi_wready == 1'b0);
        axi_awvalid = 0;
        axi_wvalid = 0;
        wait (axi_bvalid == 1'b1);
        // Ack
        axi_bready = 1'b1;
        wait (axi_bvalid == 1'b0);
        axi_bready = 1'b0;
        // Delay between next operation
        #10;
        `reset_all

        // Write Address of Device to Reg #1
        $display("  - Writing Register Address 0x00 Reg 1");
        axi_awaddr = 5'b00001 << 2;
        axi_wdata = 32'h000000;
        axi_awvalid = 1'b1;
        axi_wstrb = 4'b0111;
        axi_wvalid = 1'b1;
        // Wait for AXI slave to ACK
        wait (axi_awready == 1'b1 &&
              axi_wready == 1'b1);
        wait (axi_awready == 1'b0 &&
              axi_wready == 1'b0);
        axi_awvalid = 0;
        axi_wvalid = 0;
        wait (axi_bvalid == 1'b1);
        // Ack
        axi_bready = 1'b1;
        wait (axi_bvalid == 1'b0);
        axi_bready = 1'b0;
        // Delay between next operation
        #10;
        `reset_all

        // Write Num of Bytes to Reg #2
        $display("  - Writing Register Address 0x00 Reg 2");
        axi_awaddr = 5'b00010 << 2;
        axi_wdata = 32'h0000FF;
        axi_awvalid = 1'b1;
        axi_wstrb = 4'b0111;
        axi_wvalid = 1'b1;
        // Wait for AXI slave to ACK
        wait (axi_awready == 1'b1 &&
              axi_wready == 1'b1);
        wait (axi_awready == 1'b0 &&
              axi_wready == 1'b0);
        axi_awvalid = 0;
        axi_wvalid = 0;
        wait (axi_bvalid == 1'b1);
        // Ack
        axi_bready = 1'b1;
        wait (axi_bvalid == 1'b0);
        axi_bready = 1'b0;
        // Delay between next operation
        #10;
        `reset_all

//        // Registers should now read:
//        // slv_reg0 <= 0x5B
//        // slv_reg1 <= 0x00
//        // slv_reg2 <= 0x01
        // Write 0 to Reg 7 (0x0) (I2C WRITE)
        $display("  - Writing Start (0x88) to Reg 6");
        axi_awaddr = 5'b00111 << 2;
        axi_wdata = 32'h88;
        axi_awvalid = 1'b1;
        axi_wstrb = 4'b0001;
        axi_wvalid = 1'b1;
        // Wait for AXI slave to ACK
        wait (axi_awready == 1'b1 &&
              axi_wready == 1'b1);
        wait (axi_awready == 1'b0 &&
              axi_wready == 1'b0);
        axi_awvalid = 0;
        axi_wvalid = 0;
        wait (axi_bvalid == 1'b1);
        // Ack
        axi_bready = 1'b1;
        wait (axi_bvalid == 1'b0);
        axi_bready = 1'b0;
        // Delay between next operation
        #10;
        `reset_all

        wait (busy == 0);
        wait (busy == 1'b0);
//        #20;
//        $display("Write Finished");
//        wait (busy == 1);
//        // Wait for start of scl clock
        wait (scl_io == 1);

        // Start condition
        wait (sda_io == 0);
        wait (scl_io == 0);
        #100;
        // 1 0 1 1 0 1 1 [ 0 ]
        $display("1st bit: %x", sda_io);
        #2500;
        $display("2nd bit: %x", sda_io);
        #2500;
        $display("3rd bit: %x", sda_io);
        #2500;
        $display("4th bit: %x", sda_io);
        #2500;
        $display("5th bit: %x", sda_io);
        #2500;
        $display("6th bit: %x", sda_io);
        #2500;
        $display("7th bit: %x", sda_io);
        #2500;
        $display("8th bit: %x", sda_io);
        // I have to send an ACK or NACK for 1 clock cycle
        sda_io = 0;
        #2500;
        // 1625 T0
        // 4165 T1
        // 6665 T2
        // 9125 T3
        // 11665 T4
        $finish();

//        $display("Read Start");
//        // Write 0 to Reg 6 (0x0) (I2C READ)
//        axi_awaddr = 5'b00110 << 2;
//        axi_awvalid = 1'b1;
//        axi_wdata = 32'h099;
//        axi_wstrb = 4'b0001;
//        axi_wvalid = 1'b1;
//        // Wait for AXI slave to ACK
//        wait (axi_awready == 1'b1 &&
//              axi_wready == 1'b1);
//        wait (axi_bvalid == 1'b1);
//        // Ack
//        axi_bready = 1'b1;
//        // Must wait 2 clock cycles for axi_bvalid to go low
//        #30;
//        `reset_all

//        $display("Test #3 Finished");

////        #10;
////        // Reset all signals
////        axi_awvalid = 1'b0;
////        axi_wvalid = 1'b0;
////        axi_bready = 1'b0;
////        axi_arvalid = 1'b0;
//        axi_rready = 1'b0;

//        $display("Test #3 Write Transaction");
//        #10;
//        // 1 - Write Device address to reg 0
//        axi_awaddr = 5'b00100;
//        axi_awvalid = 1'b1;
//        axi_wdata = 32'h005B;
//        axi_wstrb = 4'b0001;
//        axi_wvalid = 1'b1;
//        // Wait for AXI slave to ACK
//        $display("0000");
//        wait (axi_awready == 1'b1 &&
//              axi_wready == 1'b1);
//        axi_awvalid = 1'b1;
//        axi_wvalid = 1'b1;
//        $display("1111");
//        wait (axi_bvalid == 1'b1);
//        $display("2222");
//        // Ack
//        axi_bready = 1'b1;
//        #10;
//        // Reset all signals
//        axi_awvalid = 1'b0;
//        axi_wvalid = 1'b0;
//        axi_bready = 1'b0;
//        axi_arvalid = 1'b0;
//        axi_rready = 1'b0;
//        $display("Wrote 0x5B to register 0");

//        // 2 - Write register to reg 1
//        axi_awaddr = 5'b00001 << 2;
//        axi_awvalid = 1'b1;
//        axi_wdata = 32'h00DE;
//        axi_wstrb = 4'b0001;
//        axi_wvalid = 1'b1;
//        // Wait for AXI slave to ACK
//        wait (axi_awready == 1'b1 &&
//              axi_wready == 1'b1);
//        wait (axi_bvalid == 1'b1);
//        // Ack
//        axi_bready = 1'b1;
//        #10;
//        // Reset all signals
//        axi_awvalid = 1'b0;
//        axi_wvalid = 1'b0;
//        axi_bready = 1'b0;
//        axi_arvalid = 1'b0;
//        axi_rready = 1'b0;
//        $display("Wrote 0xDE to register 1");

//        // 3 - Write # of bytes to reg 7 to signal a write
//        axi_awaddr = 5'b00111 << 2;
//        axi_awvalid = 1'b1;
//        axi_wdata = 32'h00EF; // 0 bytes
//        axi_wstrb = 4'b0001;
//        axi_wvalid = 1'b1;
//        // Wait for AXI slave to ACK
//        wait (axi_awready == 1'b1 &&
//              axi_wready == 1'b1);
//        wait (axi_bvalid == 1'b1);
//        // Ack
//        axi_bready = 1'b1;
//        #10;

//        // Reset all signals
//        axi_awvalid = 1'b0;
//        axi_wvalid = 1'b0;
//        axi_bready = 1'b0;
//        axi_arvalid = 1'b0;
//        axi_rready = 1'b0;
//        $display("Wrote 0xEF to register 7");

//        // Now wait to see something on the i2c bus
//        wait (scl_io == 0);

    end

    // Instantiate my_i2c_wrapper_v1_0_S00_AXI
    my_i2c_ip_v1_0_S00_AXI #(
        .C_S_AXI_DATA_WIDTH(32),
        .C_S_AXI_ADDR_WIDTH(5)
    )
        my_i2c_ip_dut(
            .scl_io(scl_io),
            .sda_io(sda_io),
            .req_data_chunk(req_data_chunk),
            .busy(busy),
            .nack(nack),
            // Global Clock Signal
            .S_AXI_ACLK(clk),

             //Global Reset Signal. This Signal is Active LOW
            .S_AXI_ARESETN(axi_aresetn),

            // Write address (issued by master, acceped by Slave)
            .S_AXI_AWADDR(axi_awaddr),

            // Write channel Protection type. This signal indicates the
    		// privilege and security level of the transaction, and whether
    		// the transaction is a data access or an instruction access.
            .S_AXI_AWPROT(axi_awprot),

            // Write address valid. This signal indicates that the master signaling
    		// valid write address and control information.
    		.S_AXI_AWVALID(axi_awvalid),

    		// Write address ready. This signal indicates that the slave is ready
    		// to accept an address and associated control signals.
            .S_AXI_AWREADY(axi_awready),

    		// Write data (issued by master, acceped by Slave) 
            .S_AXI_WDATA(axi_wdata),

            // Write strobes. This signal indicates which byte lanes hold
    		// valid data. There is one write strobe bit for each eight
    		// bits of the write data bus.    
            .S_AXI_WSTRB(axi_wstrb),

            // Write valid. This signal indicates that valid write
    		// data and strobes are available.
            .S_AXI_WVALID(axi_wvalid),

            // Write ready. This signal indicates that the slave
    		// can accept the write data.
		      .S_AXI_WREADY(axi_wready),

            // Write response. This signal indicates the status
    		// of the write transaction.
            .S_AXI_BRESP(axi_bresp),

    		// Write response valid. This signal indicates that the channel
    		// is signaling a valid write response.
            .S_AXI_BVALID(axi_bvalid),

            // Response ready. This signal indicates that the master
    		// can accept a write response.
		    .S_AXI_BREADY(axi_bready),

            // Read address (issued by master, acceped by Slave)
            .S_AXI_ARADDR(axi_araddr),

    		// Protection type. This signal indicates the privilege
    		// and security level of the transaction, and whether the
    		// transaction is a data access or an instruction access.
            .S_AXI_ARPROT(axi_arprot),

    		// Read address valid. This signal indicates that the channel
    		// is signaling valid read address and control information.
            .S_AXI_ARVALID(axi_arvalid),

            // Read address ready. This signal indicates that the slave is
    		// ready to accept an address and associated control signals.
            .S_AXI_ARREADY(axi_arready),

            // Read data (issued by slave)
            .S_AXI_RDATA(axi_rdata),

            // Read response. This signal indicates the status of the
    		// read transfer.
            .S_AXI_RRESP(axi_rresp),

            // Read valid. This signal indicates that the channel is
    		// signaling the required read data.
            .S_AXI_RVALID(axi_rvalid),

    		// Read ready. This signal indicates that the master can
    		// accept the read data and response information.
            .S_AXI_RREADY(axi_rready)
        );
endmodule
