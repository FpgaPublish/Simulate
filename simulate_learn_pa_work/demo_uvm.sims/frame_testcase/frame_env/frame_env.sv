`ifndef FRAME_ENV_SV
`define FRAME_ENV_SV

class frame_env extends uvm_env;
    frame_agent_config agt_cfg;
 
    frame_env_refm    refm;
    frame_env_scb     scb;
    frame_agent       i_agt;
    frame_agent       o_agt;
 
    `uvm_component_utils(frame_env)
 
    extern function      new(string name = "frame_env", uvm_component parent = null);
    extern function void build_phase(uvm_phase phase);
endclass : frame_env
 
function frame_env::new(string name = "frame_env", uvm_component parent = null);
    super.new(name, parent);
 
    `uvm_info(get_type_name(), "created", UVM_LOW)
endfunction : new
 
function void frame_env::build_phase(uvm_phase phase);
    super.build_phase(phase);
 
    if(!uvm_config_db #(frame_agent_config)::get(this, "", "agt_cfg", agt_cfg))
        `uvm_error("NO CONFIG", $sformatf("No config for: %s. Check tests", get_full_name()))
 
    refm  = frame_env_refm::type_id::create("refm", this);
    scb   = frame_env_scb::type_id::create("scb", this);
    i_agt = frame_agent::type_id::create("i_agt", this);
    i_agt.is_active = agt_cfg.i_agt_is_active;
    o_agt = frame_agent::type_id::create("o_agt", this);
    o_agt.is_active = agt_cfg.o_agt_is_active;
endfunction : build_phase

`endif //FRAME_ENV_SV