
build:
	@echo "Building"
	iverilog -o test_run ./my_fifo/my_fifo.v \
							 ./my_axi_ip/my_axi_S00_AXI_tb.v \
							 ./my_axi_ip/my_axi_S00_AXI.v \
					         ./uart_ip/uart_tx.v

test: build
	@echo "Running tests"
