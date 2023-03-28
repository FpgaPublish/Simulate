// *********************************************************************************
// Company: Fpga Publish
// Engineer: F 
// 
// Create Date: 2023/03/07 22:11:23
// Design Name: 
// Module Name: tb_frame_top
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

`timescale 1ps / 1ps
// ==========================================================
// UVM files   
`include "uvm_pkg.sv"
import uvm_pkg::*;
`include "uvm_macros.svh"
// ==========================================================
// user head file
`include "frame_pkg.svh"

module tb_frame_top#(
    
   )(
    
);
// ==========================================================
// sys clock

bit w_sys_clk    = 0;
bit w_sys_resetn = 0;
//sys clock generate
always  #5 w_sys_clk = ~w_sys_clk;
initial #100 w_sys_resetn = 100;
// ==========================================================
// interface
shk_interface u_shk_interface(
    .i_sys_clk    (w_sys_clk  ),
    .i_sys_resetn (w_sys_resetn)
);

// ==========================================================
// add DUT
wire w_spi_port_csns ;
wire w_spi_port_sclk ;
wire w_spi_port_mosi ;
wire w_spi_port_miso ;
wire [4-1:0] w_err_shk_info1 ;
shk_spi_driv#(
    .MD_SIM_ABLE     ( 0    ),
    .MD_SPI_VOLT     ( 2'b0 ),
    .NB_SPD_LEVEL    ( 1000 ),
    .NB_CLK_START    ( 100  ),
    .NB_CLK_PLUSE    ( 40   ),
    .NB_CLK_IDLES    ( 20   ),
    .NB_CLK_NUMBE    ( 9    ),
    .WD_SHK_ADR      ( 16   ),
    .WD_SHK_DAT      ( 16   ),
    .WD_ERR_INFO     ( 4    )
)u_shk_spi_driv(
    .i_sys_clk       ( w_sys_clk       ),
    .i_sys_rst_n     ( w_sys_resetn    ),
    .s_shk_spi_valid ( u_shk_interface.w_shk_valid ),
    .s_shk_spi_maddr ( u_shk_interface.w_shk_maddr ),
    .s_shk_spi_mdata ( u_shk_interface.w_shk_mdata ),
    .s_shk_spi_msync ( u_shk_interface.w_shk_msync ),
    .s_shk_spi_ready ( u_shk_interface.w_shk_ready ),
    .s_shk_spi_saddr ( u_shk_interface.w_shk_saddr ),
    .s_shk_spi_sdata ( u_shk_interface.w_shk_sdata ),
    .s_shk_spi_ssync ( u_shk_interface.w_shk_ssync ),
    .m_spi_port_csns ( w_spi_port_csns ),
    .m_spi_port_sclk ( w_spi_port_sclk ),
    .m_spi_port_mosi ( w_spi_port_mosi ),
    .m_spi_port_miso ( w_spi_port_miso ),
    .m_err_shk_info1 ( w_err_shk_info1 )
);


// ==========================================================
// uvm start work
// start info
initial 
begin
    `uvm_info("info1","hello UVM",UVM_LOW) //start info
end
initial 
begin
    //config interface of master agent
    uvm_config_db#(
        virtual shk_interface
    )::set(
        null,
        "uvm_test_top.env.i_agt",
        "vif",
        u_shk_interface
    );
    //cvonfig interface of slaver agent
    uvm_config_db#(
        virtual shk_interface
    )::set(
        null,
        "uvm_test_top.env.o_agt", //default top
        "vif",
        u_shk_interface
    );
        
end
//start base test
initial 
begin
    run_test("frame_base_test");
end

endmodule