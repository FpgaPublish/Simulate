// *********************************************************************************
// Company: Fpga Publish
// Engineer: F 
// 
// Create Date: 2023/03/07 22:23:35
// Design Name: 
// Module Name: frame_base_test
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

`ifndef FRAME_BASE_TEST_SV
`define FRAME_BASE_TEST_SV

class frame_base_test extends uvm_test;

    frame_env          env;    //declare environment
    frame_agent_config agt_cfg;//declare config class


    `uvm_component_utils(frame_base_test) //init bast test

    extern function new(string name = "frame_base_test", uvm_component parent); //override new

    extern function void build_phase(uvm_phase phase); //override build phase

    extern function void end_of_elaboration_phase(uvm_phase phase); //override elaboration phase

endclass : frame_base_test


function frame_base_test::new(string name = "frame_base_test", uvm_component parent);

    super.new(name, parent);  //new base test

    `uvm_info(get_type_name(), "created", UVM_LOW) //info of current class

endfunction : new

 

function void frame_base_test::build_phase(uvm_phase phase);
    super.build_phase(phase); //build phase init

    env = frame_env::type_id::create("env", this); //create env

    agt_cfg = frame_agent_config::type_id::create("agt_cfg"); //create config 

    agt_cfg.i_agt_is_active = UVM_ACTIVE; //set config value

    uvm_config_db #(frame_agent_config)::set(this, "env", "agt_cfg", agt_cfg); //set config 

endfunction : build_phase

 
function void frame_base_test::end_of_elaboration_phase(uvm_phase phase);

    super.end_of_elaboration_phase(phase); //init phase

    uvm_top.print_topology(); //info

    `uvm_info(get_type_name(), $sformatf("Verbosity level is set to: %d", get_report_verbosity_level()), UVM_LOW) //info report


endfunction : end_of_elaboration_phase

`endif //FRAME_BASE_TEST_SV