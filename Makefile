#
# axi_to_uart
# fifo_now
#
.PHONY: axi_to_uart
axi_to_uart:
	@echo "------------------------------------------------------------"
	@echo "|  Building  -  axi_to_uart                                |"
	@echo "------------------------------------------------------------"
	@iverilog -o axi_to_uart_test.bin -g2005-sv \
                                  ./axi_to_uart/axi_to_uart_S00.v \
                                  ./axi_to_uart/axi_to_uart_S00_tb.sv \
                                  ./fifo_now/fifo_now.v \
                                  ./uart_now/uart_tx_now.v
	@echo "------------------------------------------------------------"
	@echo "|  Simulating  -  axi_to_uart                              |"
	@echo "------------------------------------------------------------"
	@vvp axi_to_uart_test.bin
	@echo "------------------------------------------------------------"
	@echo "|  Launching GTKWave                                       |"
	@echo "------------------------------------------------------------"
	#gtkwave ./axi_to_uart_test.gtkw

build:
	@echo "----------------"
	@echo "Building"
	@iverilog -o test_run ./fifo_now/my_fifo.v \
							 ./axi_to_uart/my_axi_S00_AXI_tb.v \
							 ./axi_to_uart/my_axi_S00_AXI.v \
					         ./uart_now/uart_tx.v

test: build
	@echo "----------------"
	@echo "Running tests"
	@echo "----------------"
	./test_run
