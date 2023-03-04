`ifndef FRAME_ENV_SCB_SV
`define FRAME_ENV_SCB_SV

class frame_env_scb extends uvm_scoreboard;
    `uvm_component_utils(frame_env_scb)
 
    extern function new(string name = "frame_env_scb", uvm_component parent = null);
endclass : frame_env_scb
 
function frame_env_scb::new(string name = "frame_env_scb", uvm_component parent = null);
    super.new(name, parent);
    
    `uvm_info(get_type_name(), "created", UVM_LOW)
endfunction : new

`endif //FRAME_ENV_SCB_SV