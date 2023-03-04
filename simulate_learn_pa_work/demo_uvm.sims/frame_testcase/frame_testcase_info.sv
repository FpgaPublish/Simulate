`ifndef FRAME_TESTCASE_INFO_SV
`define FRAME_TESTCASE_INFO_SV

class frame_testcase_info extends frame_base_test;
    `uvm_component_utils(frame_testcase_info)
 
    extern function new(string name = "frame_testcase_info", uvm_component parent = null);
endclass : frame_testcase_info
 
function frame_testcase_info::new(string name = "frame_testcase_info", uvm_component parent = null);
    super.new(name, parent);
 
    `uvm_info(get_type_name(), "created", UVM_LOW)
endfunction : new

`endif //FRAME_TESTCASE_INFO_SV