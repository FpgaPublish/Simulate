// *********************************************************************************
// Company: Fpga Publish
// Engineer: F 
// 
// Create Date: 2023/03/07 22:53:34
// Design Name: 
// Module Name: frame_driver
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

`ifndef FRAME_DRIVER_SV
`define FRAME_DRIVER_SV

class frame_driver extends uvm_driver #(frame_seq_item);
    virtual shk_interface vif = null;
 
    `uvm_component_utils(frame_driver) //init driver
 
    extern function new(string name = "frame_driver", uvm_component parent = null);
endclass : frame_driver
 
function frame_driver::new(string name = "frame_driver", uvm_component parent = null);
    //create driver
    super.new(name, parent); 
    //create info
    `uvm_info(get_type_name(), "created", UVM_LOW)
endfunction : new

`endif //FRAME_DRIVER_SV