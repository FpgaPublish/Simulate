`ifndef FRAME_MASTER_AGENT_CONFIG_SV
`define FRAME_MASTER_AGENT_CONFIG_SV

class frame_agent_config extends uvm_object;
    uvm_active_passive_enum i_agt_is_active = UVM_PASSIVE;
    uvm_active_passive_enum o_agt_is_active = UVM_PASSIVE;
 
    `uvm_object_utils(frame_agent_config)
 
    extern function new(string name = "frame_agent_config");
endclass : frame_agent_config
 
function frame_agent_config::new(string name = "frame_agent_config");
    super.new(name);
    
    `uvm_info(get_type_name(), "created", UVM_LOW)
endfunction : new

`endif //FRAME_MASTER_AGENT_CONFIG_SV