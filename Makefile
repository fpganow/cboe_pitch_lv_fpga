
#
# axi_to_uart
# fifo_now
#

build:
	@echo "Building"
	@iverilog -o test_run ./fifo_now/my_fifo.v \
							 ./axi_to_uart/my_axi_S00_AXI_tb.v \
							 ./axi_to_uart/my_axi_S00_AXI.v \
					         ./uart_now/uart_tx.v

test: build
	@echo "Running tests"
