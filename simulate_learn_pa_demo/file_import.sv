// *********************************************************************************
// Company: Fpga Publish
// Engineer: F 
// 
// Create Date: 2023/02/18 21:28:59
// Design Name: 
// Module Name: file_import
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
`include "sv_read_dat_file.svh"
module file_import #(
    
   )(
    
);
// =============================================================
// BUS and SIP to generate signals

// =============================================================
// module to simulate
use_sv_read_dat_file p_use_sv_read_dat_file();
// =============================================================
// assertion to monitor 

endmodule