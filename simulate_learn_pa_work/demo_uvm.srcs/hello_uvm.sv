`include "uvm_pkg.sv"
`timescale 1ps / 1ps
module hello_uvm #(
    
   )(
    
);
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    initial 
    begin
        `uvm_info("info1","hello UVM",UVM_LOW)
    end

endmodule