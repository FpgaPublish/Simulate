// *********************************************************************************
// Company: Fpga Publish
// Engineer: F 
// 
// Create Date: 2023/03/07 22:41:08
// Design Name: 
// Module Name: frame_env
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

`ifndef FRAME_ENV_SV
`define FRAME_ENV_SV

class frame_env extends uvm_env;
    frame_agent_config agt_cfg; //config 
 
    frame_env_refm    refm; //ref module
    frame_env_scb     scb;  //scoreboard
    frame_agent       i_agt; //input agent
    frame_agent       o_agt; //output agent
 
    `uvm_component_utils(frame_env) //init ENV
 
    extern function      new(string name = "frame_env", uvm_component parent = null); //override new
    extern function void build_phase(uvm_phase phase); //override build phase
endclass : frame_env
 
function frame_env::new(string name = "frame_env", uvm_component parent = null);
    super.new(name, parent); //create frame env
 
    `uvm_info(get_type_name(), "created", UVM_LOW)
endfunction : new
 
function void frame_env::build_phase(uvm_phase phase);
    super.build_phase(phase);
 
    if(!uvm_config_db #(frame_agent_config)::get(this, "", "agt_cfg", agt_cfg)) //config get error
    begin
        `uvm_error("NO CONFIG", $sformatf("No config for: %s. Check tests", get_full_name()))
    end
        
    refm  = frame_env_refm::type_id::create("refm", this); //create refm
    scb   = frame_env_scb::type_id::create("scb", this); //create scoreboard
    i_agt = frame_agent::type_id::create("i_agt", this); //create input agent
    i_agt.is_active = agt_cfg.i_agt_is_active;           //agent mode init
    o_agt = frame_agent::type_id::create("o_agt", this); //create output agent
    o_agt.is_active = agt_cfg.o_agt_is_active; //agent mode init
endfunction : build_phase

`endif //FRAME_ENV_SV