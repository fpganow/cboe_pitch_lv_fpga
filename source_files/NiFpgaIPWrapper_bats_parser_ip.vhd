-- VHDL wrapper for NiFpgaAG_bats_parser_ip
-- Generated by LabVIEW FPGA IP Export Utility
--
-- Ports:
-- reset      :  Reset port. Minimum assertion length: 8 base clock cycles.
--               Minimum de-assertion length: 160 base clock cycles.
-- enable_in  :  Enable in port. Minimum re-initialization length: 7 base clock cycles.
-- enable_out :  Enable out port.
-- enable_clr :  Enable clear port.
-- ctrlind_00_Ready_For_Debug : Top level control "Ready.For.Debug", sync to PllClk80Derived2x1B60MHz, bool
-- ctrlind_01_Debug_Valid : Top level indicator "Debug.Valid", sync to PllClk80Derived2x1B60MHz, bool
-- ctrlind_02_Debug_Element : Top level indicator "Debug.Element", sync to PllClk80Derived2x1B60MHz, u64
-- ctrlind_03_Ready_for_OrderBook_Command : Top level control "Ready.for.OrderBook.Command", sync to PllClk80Derived2x1B60MHz, bool
-- ctrlind_04_OrderBook_Command_Valid : Top level indicator "OrderBook.Command.Valid", sync to PllClk80Derived2x1B60MHz, bool
-- ctrlind_05_Nanoseconds_U64 : Top level indicator "Nanoseconds (U64)", sync to PllClk80Derived2x1B60MHz, u64
-- ctrlind_06_Seconds_U64 : Top level indicator "Seconds (U64)", sync to PllClk80Derived2x1B60MHz, u64
-- ctrlind_07_Remaining_Quantity_U32 : Top level indicator "Remaining Quantity (U32)", sync to PllClk80Derived2x1B60MHz, u32
-- ctrlind_08_Canceled_Quantity_U32 : Top level indicator "Canceled Quantity (U32)", sync to PllClk80Derived2x1B60MHz, u32
-- ctrlind_09_Executed_Quantity_U32 : Top level indicator "Executed Quantity (U32)", sync to PllClk80Derived2x1B60MHz, u32
-- ctrlind_10_Price_U64 : Top level indicator "Price (U64)", sync to PllClk80Derived2x1B60MHz, u64
-- ctrlind_11_Symbol_U64 : Top level indicator "Symbol (U64)", sync to PllClk80Derived2x1B60MHz, u64
-- ctrlind_12_Quantity_U32 : Top level indicator "Quantity (U32)", sync to PllClk80Derived2x1B60MHz, u32
-- ctrlind_13_Order_Id_U64 : Top level indicator "Order Id (U64)", sync to PllClk80Derived2x1B60MHz, u64
-- ctrlind_14_Side_U8 : Top level indicator "Side (U8)", sync to PllClk80Derived2x1B60MHz, u8
-- ctrlind_15_OrderBook_Command_Type : Top level indicator "OrderBook Command.Type", sync to PllClk80Derived2x1B60MHz, enum8
-- ctrlind_16_data : Top level control "data", sync to PllClk80Derived2x1B60MHz, cluster
-- ctrlind_17_data_valid : Top level control "data.valid", sync to PllClk80Derived2x1B60MHz, bool
-- ctrlind_18_reset : Top level control "reset", sync to PllClk80Derived2x1B60MHz, bool
-- ctrlind_19_Ready_for_Udp_Input : Top level indicator "Ready.for.Udp.Input", sync to PllClk80Derived2x1B60MHz, bool
-- PllClk80Derived2x1B60MHz : Clock "160MHz", nominal frequency 160.00 MHz, base clock

library ieee;
use ieee.std_logic_1164.all;

entity NiFpgaIPWrapper_bats_parser_ip is
		port (
			reset : in std_logic;
			enable_in : in std_logic;
			enable_out : out std_logic;
			enable_clr : in std_logic;
			ctrlind_00_Ready_For_Debug : in std_logic_vector(0 downto 0);
			ctrlind_01_Debug_Valid : out std_logic_vector(0 downto 0);
			ctrlind_02_Debug_Element : out std_logic_vector(63 downto 0);
			ctrlind_03_Ready_for_OrderBook_Command : in std_logic_vector(0 downto 0);
			ctrlind_04_OrderBook_Command_Valid : out std_logic_vector(0 downto 0);
			ctrlind_05_Nanoseconds_U64 : out std_logic_vector(63 downto 0);
			ctrlind_06_Seconds_U64 : out std_logic_vector(63 downto 0);
			ctrlind_07_Remaining_Quantity_U32 : out std_logic_vector(31 downto 0);
			ctrlind_08_Canceled_Quantity_U32 : out std_logic_vector(31 downto 0);
			ctrlind_09_Executed_Quantity_U32 : out std_logic_vector(31 downto 0);
			ctrlind_10_Price_U64 : out std_logic_vector(63 downto 0);
			ctrlind_11_Symbol_U64 : out std_logic_vector(63 downto 0);
			ctrlind_12_Quantity_U32 : out std_logic_vector(31 downto 0);
			ctrlind_13_Order_Id_U64 : out std_logic_vector(63 downto 0);
			ctrlind_14_Side_U8 : out std_logic_vector(7 downto 0);
			ctrlind_15_OrderBook_Command_Type : out std_logic_vector(7 downto 0);
			ctrlind_16_data : in std_logic_vector(71 downto 0);
			ctrlind_17_data_valid : in std_logic_vector(0 downto 0);
			ctrlind_18_reset : in std_logic_vector(0 downto 0);
			ctrlind_19_Ready_for_Udp_Input : out std_logic_vector(0 downto 0);
			PllClk80Derived2x1B60MHz : in std_logic
		);
end NiFpgaIPWrapper_bats_parser_ip;

architecture vhdl_labview of NiFpgaIPWrapper_bats_parser_ip is

	component NiFpgaAG_bats_parser_ip
		port (
			reset : in std_logic;
			enable_in : in std_logic;
			enable_out : out std_logic;
			enable_clr : in std_logic;
			ctrlind_00_Ready_For_Debug : in std_logic_vector(0 downto 0);
			ctrlind_01_Debug_Valid : out std_logic_vector(0 downto 0);
			ctrlind_02_Debug_Element : out std_logic_vector(63 downto 0);
			ctrlind_03_Ready_for_OrderBook_Command : in std_logic_vector(0 downto 0);
			ctrlind_04_OrderBook_Command_Valid : out std_logic_vector(0 downto 0);
			ctrlind_05_Nanoseconds_U64 : out std_logic_vector(63 downto 0);
			ctrlind_06_Seconds_U64 : out std_logic_vector(63 downto 0);
			ctrlind_07_Remaining_Quantity_U32 : out std_logic_vector(31 downto 0);
			ctrlind_08_Canceled_Quantity_U32 : out std_logic_vector(31 downto 0);
			ctrlind_09_Executed_Quantity_U32 : out std_logic_vector(31 downto 0);
			ctrlind_10_Price_U64 : out std_logic_vector(63 downto 0);
			ctrlind_11_Symbol_U64 : out std_logic_vector(63 downto 0);
			ctrlind_12_Quantity_U32 : out std_logic_vector(31 downto 0);
			ctrlind_13_Order_Id_U64 : out std_logic_vector(63 downto 0);
			ctrlind_14_Side_U8 : out std_logic_vector(7 downto 0);
			ctrlind_15_OrderBook_Command_Type : out std_logic_vector(7 downto 0);
			ctrlind_16_data : in std_logic_vector(71 downto 0);
			ctrlind_17_data_valid : in std_logic_vector(0 downto 0);
			ctrlind_18_reset : in std_logic_vector(0 downto 0);
			ctrlind_19_Ready_for_Udp_Input : out std_logic_vector(0 downto 0);
			PllClk80Derived2x1B60MHz : in std_logic;
			tDiagramEnableOut : in std_logic
		);
	end component;

begin
	MyLabVIEWIP : NiFpgaAG_bats_parser_ip
		port map(
			reset => reset,
			enable_in => enable_in,
			enable_out => enable_out,
			enable_clr => enable_clr,
			ctrlind_00_Ready_For_Debug => ctrlind_00_Ready_For_Debug,
			ctrlind_01_Debug_Valid => ctrlind_01_Debug_Valid,
			ctrlind_02_Debug_Element => ctrlind_02_Debug_Element,
			ctrlind_03_Ready_for_OrderBook_Command => ctrlind_03_Ready_for_OrderBook_Command,
			ctrlind_04_OrderBook_Command_Valid => ctrlind_04_OrderBook_Command_Valid,
			ctrlind_05_Nanoseconds_U64 => ctrlind_05_Nanoseconds_U64,
			ctrlind_06_Seconds_U64 => ctrlind_06_Seconds_U64,
			ctrlind_07_Remaining_Quantity_U32 => ctrlind_07_Remaining_Quantity_U32,
			ctrlind_08_Canceled_Quantity_U32 => ctrlind_08_Canceled_Quantity_U32,
			ctrlind_09_Executed_Quantity_U32 => ctrlind_09_Executed_Quantity_U32,
			ctrlind_10_Price_U64 => ctrlind_10_Price_U64,
			ctrlind_11_Symbol_U64 => ctrlind_11_Symbol_U64,
			ctrlind_12_Quantity_U32 => ctrlind_12_Quantity_U32,
			ctrlind_13_Order_Id_U64 => ctrlind_13_Order_Id_U64,
			ctrlind_14_Side_U8 => ctrlind_14_Side_U8,
			ctrlind_15_OrderBook_Command_Type => ctrlind_15_OrderBook_Command_Type,
			ctrlind_16_data => ctrlind_16_data,
			ctrlind_17_data_valid => ctrlind_17_data_valid,
			ctrlind_18_reset => ctrlind_18_reset,
			ctrlind_19_Ready_for_Udp_Input => ctrlind_19_Ready_for_Udp_Input,
			PllClk80Derived2x1B60MHz => PllClk80Derived2x1B60MHz,
			tDiagramEnableOut => '1'
		);

end vhdl_labview;
