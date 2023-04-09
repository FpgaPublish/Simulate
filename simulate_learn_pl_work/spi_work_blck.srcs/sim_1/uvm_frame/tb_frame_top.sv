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

module tb_frame_top #(
    
   )(
    
);
// ==========================================================
// sys clock

bit w_sys_clk    = 0;
bit w_sys_resetn = 0;
//sys clock generate
always#5 w_sys_clk = ~w_sys_clk;
initial #100 w_sys_resetn = 100;
// ==========================================================
// interface
shk_interface u_shk_interface(
    .i_sys_clk    (w_sys_clk  ),
    .i_sys_resetn(w_sys_resetn)
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