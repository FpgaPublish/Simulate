`ifndef FRAME_BASE_TEST_SV
`define FRAME_BASE_TEST_SV

class frame_base_test extends uvm_test;

    frame_env          env;

    frame_agent_config agt_cfg;


    `uvm_component_utils(frame_base_test)

    extern function      new(string name = "frame_base_test", uvm_component parent);

    extern function void build_phase(uvm_phase phase);

    extern function void end_of_elaboration_phase(uvm_phase phase);

endclass : frame_base_test

 

function frame_base_test::new(string name = "frame_base_test", uvm_component parent);

    super.new(name, parent);

 

    `uvm_info(get_type_name(), "created", UVM_LOW)

endfunction : new

 

function void frame_base_test::build_phase(uvm_phase phase);

    super.build_phase(phase);

 

    env = frame_env::type_id::create("env", this);

    agt_cfg = frame_agent_config::type_id::create("agt_cfg");

    agt_cfg.i_agt_is_active = UVM_ACTIVE;

 

    uvm_config_db #(frame_agent_config)::set(this, "env", "agt_cfg", agt_cfg);

endfunction : build_phase

 

function void frame_base_test::end_of_elaboration_phase(uvm_phase phase);

    super.end_of_elaboration_phase(phase);

 

    uvm_top.print_topology();

    `uvm_info(get_type_name(), $sformatf("Verbosity level is set to: %d", get_report_verbosity_level()), UVM_LOW)

    factory.print();

endfunction : end_of_elaboration_phase

`endif //FRAME_BASE_TEST_SV