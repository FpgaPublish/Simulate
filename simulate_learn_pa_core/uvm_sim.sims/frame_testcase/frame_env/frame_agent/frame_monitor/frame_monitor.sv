// *********************************************************************************
// Company: Fpga Publish
// Engineer: F 
// 
// Create Date: 2023/03/07 22:55:33
// Design Name: 
// Module Name: frame_monitor
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

`ifndef FRAME_MONITOR_SV
`define FRAME_MONITOR_SV

class frame_monitor extends uvm_monitor;
    virtual shk_interface vif = null;
 
    `uvm_component_utils(frame_monitor)
 
    extern function new(string name = "frame_monitor", uvm_component parent = null);
endclass : frame_monitor
 
function frame_monitor::new(string name = "frame_monitor", uvm_component parent = null);
    super.new(name, parent); //create monitor
    
    `uvm_info(get_type_name(), "created", UVM_LOW)
endfunction : new

`endif //FRAME_MONITOR_SV