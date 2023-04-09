// *********************************************************************************
// Company: Fpga Publish
// Engineer: F 
// 
// Create Date: 2023/03/07 22:45:57
// Design Name: 
// Module Name: frame_env_scb
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

`ifndef FRAME_ENV_SCB_SV
`define FRAME_ENV_SCB_SV

class frame_env_scb extends uvm_scoreboard;
    `uvm_component_utils(frame_env_scb) //init scoreboard
 
    extern function new(string name = "frame_env_scb", uvm_component parent = null);
endclass : frame_env_scb
 
function frame_env_scb::new(string name = "frame_env_scb", uvm_component parent = null);
    super.new(name, parent); //create env scoreboard
    
    `uvm_info(get_type_name(), "created", UVM_LOW)
endfunction : new

`endif //FRAME_ENV_SCB_SV