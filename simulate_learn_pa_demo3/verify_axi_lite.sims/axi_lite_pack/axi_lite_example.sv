// *********************************************************************************
// Company: Fpga Publish
// Engineer: F 
// 
// Create Date: 2023/02/21 20:43:31
// Design Name: 
// Module Name: axi_lite_example
// Project Name: 
// Target Devices: ZYNQ7010 & XAUG
// Tool Versions: 2021.1
// Description: 
// 
// Dependencies: 
// 
// Revision: 0.01 
// Revision 0.01 - File Created
// Additional Comments:
// 
// ***********************************************************************************
`include "axi_lite_slaver_v1_0_S00_AXI.v"
`include "axi_lite_master_v1_0_M00_AXI.v"



// ######################################################################
// module use
`timescale 1ps / 1ps

// ==========================================================
// interface
interface axi#(
	// The master will start generating data from the C_M_START_DATA_VALUE value
		parameter  C_M_START_DATA_VALUE	= 32'hAA000000,
		// The master requires a target slave base address.
    // The master will initiate read and write transactions on the slave with base address specified here as a parameter.
		parameter  C_M_TARGET_SLAVE_BASE_ADDR	= 32'h40000000,
		// Width of M_AXI address bus. 
    // The master generates the read and write addresses of width specified as C_M_AXI_ADDR_WIDTH.
		parameter integer C_AXI_ADDR_WIDTH	= 32,
		// Width of M_AXI data bus. 
    // The master issues write data and accept read data where the width of the data bus is C_M_AXI_DATA_WIDTH
		parameter integer C_AXI_DATA_WIDTH	= 32,
		// Transaction number is the number of write 
    // and read transactions the master will perform as a part of this example memory test.
		parameter integer C_M_TRANSACTIONS_NUM	= 4
)(
    input i_axi_clk,
    input i_axi_rst_n,
    input i_axi_init_txn
);
    // Initiate AXI transactions
		logic  INIT_AXI_TXN;
        assign INIT_AXI_TXN = i_axi_init_txn;
		// Asserts when ERROR is detected
		logic  ERROR;
		// Asserts when AXI transactions is complete
		logic  TXN_DONE;
		// AXI clock signal
		logic  AXI_ACLK ;
        assign AXI_ACLK = i_axi_clk;
		// AXI active low reset signal
		logic  AXI_ARESETN ;
        assign AXI_ARESETN = i_axi_rst_n;
		// Master Interface Write Address Channel ports. Write address (issued by master)
		logic [C_AXI_ADDR_WIDTH-1 : 0] AXI_AWADDR;
		// Write channel Protection type.
    // This signal indicates the privilege and security level of the transaction,
    // and whether the transaction is a data access or an instruction access.
		logic [2 : 0] AXI_AWPROT;
		// Write address valid. 
    // This signal indicates that the master signaling valid write address and control information.
		logic  AXI_AWVALID;
		// Write address ready. 
    // This signal indicates that the slave is ready to accept an address and associated control signals.
		logic  AXI_AWREADY;
		// Master Interface Write Data Channel ports. Write data (issued by master)
		logic [C_AXI_DATA_WIDTH-1 : 0] AXI_WDATA;
		// Write strobes. 
    // This signal indicates which byte lanes hold valid data.
    // There is one write strobe bit for each eight bits of the write data bus.
		logic [C_AXI_DATA_WIDTH/8-1 : 0] AXI_WSTRB;
		// Write valid. This signal indicates that valid write data and strobes are available.
		logic  AXI_WVALID;
		// Write ready. This signal indicates that the slave can accept the write data.
		logic  AXI_WREADY;
		// Master Interface Write Response Channel ports. 
    // This signal indicates the status of the write transaction.
		logic [1 : 0] AXI_BRESP;
		// Write response valid. 
    // This signal indicates that the channel is signaling a valid write response
		logic  AXI_BVALID;
		// Response ready. This signal indicates that the master can accept a write response.
		logic  AXI_BREADY;
		// Master Interface Read Address Channel ports. Read address (issued by master)
		logic [C_AXI_ADDR_WIDTH-1 : 0] AXI_ARADDR;
		// Protection type. 
    // This signal indicates the privilege and security level of the transaction, 
    // and whether the transaction is a data access or an instruction access.
		logic [2 : 0] AXI_ARPROT;
		// Read address valid. 
    // This signal indicates that the channel is signaling valid read address and control information.
		logic  AXI_ARVALID;
		// Read address ready. 
    // This signal indicates that the slave is ready to accept an address and associated control signals.
		logic  AXI_ARREADY;
		// Master Interface Read Data Channel ports. Read data (issued by slave)
		logic [C_AXI_DATA_WIDTH-1 : 0] AXI_RDATA;
		// Read response. This signal indicates the status of the read transfer.
		logic [1 : 0] AXI_RRESP;
		// Read valid. This signal indicates that the channel is signaling the required read data.
		logic  AXI_RVALID;
		// Read ready. This signal indicates that the master can accept the read data and response information.
		logic  AXI_RREADY;
endinterface //axi



module axi_lite_example #(
    
   )(
    
);
//signals generate
reg i_sys_clk   = 0;
reg i_sys_rst_n = 0;
//clock and rst
always #5 i_sys_clk = ~i_sys_clk;
initial #100 i_sys_rst_n = 1;
initial #100000 $stop();
//tran en program
reg i_axi_init_txn = 0;
always #1000 i_axi_init_txn = 1;


//axi interface
axi axi0(
    .i_axi_clk  (i_sys_clk  ),
    .i_axi_rst_n(i_sys_rst_n),
    .i_axi_init_txn(i_axi_init_txn)
);

//master
axi_lite_master_v1_0_M00_AXI#(
    .C_M_START_DATA_VALUE       ( 32'hAA000000 ),
    .C_M_TARGET_SLAVE_BASE_ADDR ( 32'h40000000 ),
    .C_M_AXI_ADDR_WIDTH         ( 32           ),
    .C_M_AXI_DATA_WIDTH         ( 32           ),
    .C_M_TRANSACTIONS_NUM       ( 4            )
)u_axi_lite_master_v1_0_M00_AXI(
    .INIT_AXI_TXN               ( axi0.INIT_AXI_TXN ),
    .ERROR                      ( axi0.ERROR        ),
    .TXN_DONE                   ( axi0.TXN_DONE     ),
    .M_AXI_ACLK                 ( axi0.AXI_ACLK     ),
    .M_AXI_ARESETN              ( axi0.AXI_ARESETN  ),
    .M_AXI_AWADDR               ( axi0.AXI_AWADDR   ),
    .M_AXI_AWPROT               ( axi0.AXI_AWPROT   ),
    .M_AXI_AWVALID              ( axi0.AXI_AWVALID  ),
    .M_AXI_AWREADY              ( axi0.AXI_AWREADY  ),
    .M_AXI_WDATA                ( axi0.AXI_WDATA    ),
    .M_AXI_WSTRB                ( axi0.AXI_WSTRB    ),
    .M_AXI_WVALID               ( axi0.AXI_WVALID   ),
    .M_AXI_WREADY               ( axi0.AXI_WREADY   ),
    .M_AXI_BRESP                ( axi0.AXI_BRESP    ),
    .M_AXI_BVALID               ( axi0.AXI_BVALID   ),
    .M_AXI_BREADY               ( axi0.AXI_BREADY   ),
    .M_AXI_ARADDR               ( axi0.AXI_ARADDR   ),
    .M_AXI_ARPROT               ( axi0.AXI_ARPROT   ),
    .M_AXI_ARVALID              ( axi0.AXI_ARVALID  ),
    .M_AXI_ARREADY              ( axi0.AXI_ARREADY  ),
    .M_AXI_RDATA                ( axi0.AXI_RDATA    ),
    .M_AXI_RRESP                ( axi0.AXI_RRESP    ),
    .M_AXI_RVALID               ( axi0.AXI_RVALID   ),
    .M_AXI_RREADY               ( axi0.AXI_RREADY   )
);
//salver
axi_lite_slaver_v1_0_S00_AXI#(
    .C_S_AXI_DATA_WIDTH                       ( 32 ),
    .C_S_AXI_ADDR_WIDTH                       ( 4 )
)u_axi_lite_slaver_v1_0_S00_AXI(
    .S_AXI_ACLK                               ( axi0.AXI_ACLK     ),
    .S_AXI_ARESETN                            ( axi0.AXI_ARESETN  ),
    .S_AXI_AWADDR                             ( axi0.AXI_AWADDR   ),
    .S_AXI_AWPROT                             ( axi0.AXI_AWPROT   ),
    .S_AXI_AWVALID                            ( axi0.AXI_AWVALID  ),
    .S_AXI_AWREADY                            ( axi0.AXI_AWREADY  ),
    .S_AXI_WDATA                              ( axi0.AXI_WDATA    ),
    .S_AXI_WSTRB                              ( axi0.AXI_WSTRB    ),
    .S_AXI_WVALID                             ( axi0.AXI_WVALID   ),
    .S_AXI_WREADY                             ( axi0.AXI_WREADY   ),
    .S_AXI_BRESP                              ( axi0.AXI_BRESP    ),
    .S_AXI_BVALID                             ( axi0.AXI_BVALID   ),
    .S_AXI_BREADY                             ( axi0.AXI_BREADY   ),
    .S_AXI_ARADDR                             ( axi0.AXI_ARADDR   ),
    .S_AXI_ARPROT                             ( axi0.AXI_ARPROT   ),
    .S_AXI_ARVALID                            ( axi0.AXI_ARVALID  ),
    .S_AXI_ARREADY                            ( axi0.AXI_ARREADY  ),
    .S_AXI_RDATA                              ( axi0.AXI_RDATA    ),
    .S_AXI_RRESP                              ( axi0.AXI_RRESP    ),
    .S_AXI_RVALID                             ( axi0.AXI_RVALID   ),
    .S_AXI_RREADY                             ( axi0.AXI_RREADY   )
);

property p_check_slaver_ready;
    @(posedge axi0.AXI_ACLK)        $rose(axi0.AXI_AWREADY) |-> 
    ##[1:2] (~axi0.AXI_AWVALID) and $rose(axi0.AXI_WREADY)  |-> 
    ##[1:2] (~axi0.AXI_WVALID)  and $rose(axi0.AXI_BREADY)  |-> 
    ##[1:2] (~axi0.AXI_BVALID)  and $rose(axi0.AXI_ARREADY) |-> 
    ##[1:2] (~axi0.AXI_ARVALID) and $rose(axi0.AXI_RREADY)  |-> 
    ##[1:2] (~axi0.AXI_RVALID);
endproperty

a_shake: assert property(p_check_slaver_ready) else $display("error in shake");



endmodule