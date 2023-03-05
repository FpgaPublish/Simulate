`timescale 1ps / 1ps

`include "uvm_pkg.sv"
import uvm_pkg::*;
`include "uvm_macros.svh"
`include "frame_pkg.svh"

module tb_frame_top #(
    
   )(
    
);
    //sys clock
    bit w_sys_clk    = 0;
    bit w_sys_resetn = 0;
    
    always#5 w_sys_clk = ~w_sys_clk;
    initial #100 w_sys_resetn = 100;
    
    shk_interface u_shk_interface(
        .i_sys_clk(w_sys_clk),
        .i_sys_resetn(w_sys_resetn)
    );
    
    // start info
    initial 
    begin
        `uvm_info("info1","hello UVM",UVM_LOW)
    end
    initial 
    begin
        uvm_config_db#(
            virtual shk_interface
        )::set(
            null,
            "uvm_test_top.env.i_agt",
            "vif",
            u_shk_interface
        );
        uvm_config_db#(
            virtual shk_interface
        )::set(
            null,
            "uvm_test_top.env.o_agt", //default top
            "vif",
            u_shk_interface
        );
            
    end
    initial 
        begin
            run_test("frame_base_test");
        end
    
endmodule