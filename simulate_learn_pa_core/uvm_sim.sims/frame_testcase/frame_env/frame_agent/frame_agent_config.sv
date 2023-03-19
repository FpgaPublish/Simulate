// *********************************************************************************
// Company: Fpga Publish
// Engineer: F 
// 
// Create Date: 2023/03/07 22:48:31
// Design Name: 
// Module Name: frame_agent_config
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

`ifndef FRAME_MASTER_AGENT_CONFIG_SV
`define FRAME_MASTER_AGENT_CONFIG_SV

class frame_agent_config extends uvm_object;
    uvm_active_passive_enum i_agt_is_active = UVM_PASSIVE; //create i agent mode 
    uvm_active_passive_enum o_agt_is_active = UVM_PASSIVE; //create o agent mode
 
    `uvm_object_utils(frame_agent_config)
 
    extern function new(string name = "frame_agent_config");
endclass : frame_agent_config
 
function frame_agent_config::new(string name = "frame_agent_config");
    super.new(name); //create agnet config
    
    `uvm_info(get_type_name(), "created", UVM_LOW)
endfunction : new

`endif //FRAME_MASTER_AGENT_CONFIG_SV