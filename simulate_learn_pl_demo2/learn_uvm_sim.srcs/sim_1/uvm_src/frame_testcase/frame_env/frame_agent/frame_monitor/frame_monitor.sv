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
`include "uvm_macros.svh"
`ifndef FRAME_MONITOR_SV
`define FRAME_MONITOR_SV

class frame_monitor extends uvm_monitor;
    virtual shk_interface vif = null;
 
    `uvm_component_utils(frame_monitor)
    uvm_analysis_port #(frame_transaction) ap; //  to scoreboard
    extern function new(string name = "frame_monitor", uvm_component parent = null);
    extern virtual function void build_phase(uvm_phase phase);
    extern virtual task main_phase(uvm_phase phase);
    extern virtual task receive_one_pkt(ref rame_transaction get_pkt);

endclass : frame_monitor
 
function frame_monitor::new(string name = "frame_monitor", uvm_component parent = null);
    super.new(name, parent); //create monitor
    
    `uvm_info(get_type_name(), "created", UVM_LOW)
endfunction : new

function void frame_monitor::build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db #(virtual shk_interface)::get(this,"shk_interface",vif))
    begin
        `uvm_fatal("my_monitor","Error in Getting interface");
    end
    ap = new("ap",this);
endfunction
task frame_monitor::main_phase(uvm_phase phase);
    my_transaction tr;
    super.main_phase(phase);
    while(1)
    begin
        tr=new();
        receive_one_pkt(tr);
        ap.write(tr);
    end
endtask
task frame_monitor::receive_one_pkt(ref frame_transaction get_pkt);
    //add monitor work  
endtask
`endif //FRAME_MONITOR_SV