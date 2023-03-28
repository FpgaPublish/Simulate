// *********************************************************************************
// Company: Fpga Publish
// Engineer: F 
// 
// Create Date: 2023/03/07 22:48:06
// Design Name: 
// Module Name: shk_interface
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

`ifndef SHK_INTERFACE_SV
`define SHK_INTERFACE_SV

interface shk_interface(input bit i_sys_clk, bit i_sys_resetn);
    logic           w_shk_valid;
    logic           w_shk_msync;
    logic  [31:0]   w_shk_mdata;
    logic  [31:0]   w_shk_maddr;
    logic           w_shk_msync;
    
    logic           w_shk_ssync;
    logic           w_shk_ready;
    logic  [31:0]   w_shk_sdata;
    logic  [31:0]   w_shk_saddr;
    logic           w_shk_ssync;
    
endinterface : shk_interface

`endif //SHK_INTERFACE_SV
