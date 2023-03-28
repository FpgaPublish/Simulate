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
 
    // --------------------------------------------------------------------
    // add TLM 
    uvm_tlm_analysis_fifo  #(frame_transaction) agt_scb_fifo;   //my_monitor
    uvm_tlm_analysis_fifo  #(frame_transaction) agt_refm_fifo;   //my_drive
    uvm_tlm_analysis_fifo  #(frame_transaction) refm_scb_fifo;   //my_model
    
    
    `uvm_component_utils(frame_env) //init ENV
 
    extern function      new(string name = "frame_env", uvm_component parent = null); //override new
    extern function void build_phase(uvm_phase phase); //override build phase
    extern function void connect_phase(uvm_phase phase); //add connect
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
    
    //add tlm connect
    agt_scb_fifo = new("agt_scb_fifo",this);
    agt_refm_fifo = new("agt_refm_fifo",this);
    refm_scb_fifo = new(" refm_scb_fifo",this);
    
endfunction : build_phase
function void frame_env::connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    //env connect fifo 
    i_agt.ap.connect(agt_refm_fifo.analysis_export);
    refm.port.connect(agt_refm_fifo.blocking_get_export);
    refm.ap.connect(refm_scb_fifo.analysis_export);
    scb.exp_port.connect(refm_scb_fifo.blocking_get_export);
    o_agt.ap.connect(agt_scb_fifo.analysis_export);
    scb.act_port.connect(agt_scb_fifo.blocking_get_export);
    
endfunction: connect_phase

`endif //FRAME_ENV_SV