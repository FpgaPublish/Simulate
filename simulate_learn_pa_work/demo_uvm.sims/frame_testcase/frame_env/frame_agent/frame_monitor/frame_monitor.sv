`ifndef FRAME_MONITOR_SV
`define FRAME_MONITOR_SV

class frame_monitor extends uvm_monitor;
    virtual shk_interface vif = null;
 
    `uvm_component_utils(frame_monitor)
 
    extern function new(string name = "frame_monitor", uvm_component parent = null);
endclass : frame_monitor
 
function frame_monitor::new(string name = "frame_monitor", uvm_component parent = null);
    super.new(name, parent);
    
    `uvm_info(get_type_name(), "created", UVM_LOW)
endfunction : new

`endif //FRAME_MONITOR_SV