`ifndef FRAME_ENV_REFM_SV
`define FRAME_ENV_REFM_SV

class frame_env_refm extends uvm_component;
    `uvm_component_utils(frame_env_refm)
 
    extern function new(string name = "frame_env_refm", uvm_component parent = null);
endclass : frame_env_refm
 
function frame_env_refm::new(string name = "frame_env_refm", uvm_component parent = null);
    super.new(name, parent);
    
    `uvm_info(get_type_name(), "created", UVM_LOW)
endfunction : new

`endif //FRAME_ENV_REFM_SV