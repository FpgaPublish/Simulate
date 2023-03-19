`ifndef FRAME_AGENT_SV
`define FRAME_AGENT_SV

class frame_agent extends uvm_agent;
    virtual shk_interface vif; //create shk interface
 
    frame_sequencer   sqr; //declare sequencer
    frame_driver      drv; //declare driver
    frame_monitor     mon; //declare monitor
 
    `uvm_component_utils(frame_agent) //int agent
 
    extern function      new(string name = "frame_agent", uvm_component parent = null); 
    extern function void build_phase(uvm_phase phase);
endclass : frame_agent
 
function frame_agent::new(string name = "frame_agent", uvm_component parent = null);
    super.new(name, parent); //create agent
 
    `uvm_info(get_type_name(), "created", UVM_LOW)
endfunction : new
 
function void frame_agent::build_phase(uvm_phase phase);
    super.build_phase(phase); //override build phase
 
    if(!uvm_config_db #(virtual shk_interface)::get(this, "", "vif", vif)) //get config
        `uvm_error("NO VIF", {"virtual interface must be set for: ", get_full_name()})
 
    mon = frame_monitor::type_id::create("mon", this); //create monitor
    mon.vif = vif;
    
    if(is_active == UVM_ACTIVE) begin //active agent
        sqr = frame_sequencer::type_id::create("sqr", this);
        drv = frame_driver::type_id::create("drv", this);
        drv.vif = vif;
    end
endfunction : build_phase

`endif //FRAME_AGENT_SV

