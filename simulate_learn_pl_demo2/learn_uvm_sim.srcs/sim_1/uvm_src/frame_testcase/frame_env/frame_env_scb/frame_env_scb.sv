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
    int pre_number=0;
    frame_transaction expect_queue[$];
    uvm_blocking_get_port #(my_transaction) exp_port;//from my_reference
    uvm_blocking_get_port #(my_transaction) act_port;//from my_monitor
    extern virtual function void build_phase(uvm_phase phase);
    extern virtual task  main_phase(uvm_phase phase);
    extern function new(string name = "frame_env_scb", uvm_component parent = null);
endclass : frame_env_scb
 
function frame_env_scb::new(string name = "frame_env_scb", uvm_component parent = null);
    super.new(name, parent); //create env scoreboard
    
    `uvm_info(get_type_name(), "created", UVM_LOW)
endfunction : new

function void frame_env_scb::build_phase(uvm_phase phase);
    super.build_phase(phase);
    exp_port=new("exp_port",this);
    act_port=new("act_port",this);
endfunction
task frame_env_scb::main_phase(uvm_phase phase);
    my_transaction get_expect,get_actual,tmp_tran;
    bit result;
    super.main_phase(phase);
    fork
        while(1)
        begin
            exp_port.get(get_expect);
            expect_queue.push_back(get_expect);
        end
        while(1)
        begin
            act_port.get(get_actual);
            if(expect_queue.size > 1)
            begin
                tmp_tran=expect_queue.pop_front();
                result=get_actual.compare(tmp_tran);
            end
            if(result) 
            begin
                pre_number=pre_number + 1;
                $display("compare SUCCESSFULLy:%0d",pre_number);
            end
            else 
            begin
                $display("compare FAILED");
                $display("the expect pkt is");
                tmp_tran.print();
                $display("the actual pkt is");
                get_actual.print();
            end
        end
    join
   
  endtask                

`endif //FRAME_ENV_SCB_SV