// *********************************************************************************
// Company: Fpga Publish
// Engineer: F 
// 
// Create Date: 2023/03/07 22:53:34
// Design Name: 
// Module Name: frame_driver
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
//`include "uvm_macros.svh"
`ifndef FRAME_DRIVER_SV
`define FRAME_DRIVER_SV

class frame_driver extends uvm_driver #(frame_seq_item);
    virtual shk_interface vif = null;
    uvm_analysis_port #(frame_transaction) ap;
    `uvm_component_utils(frame_driver) //init driver
 
    extern function new(string name = "frame_driver", uvm_component parent = null);
    extern virtual function void build_phase(uvm_phase phase);
    extern virtual task  main_phase(uvm_phase phase);
    extern virtual task  drive_one_pkt(frame_transaction req);
endclass : frame_driver
 
function frame_driver::new(string name = "frame_driver", uvm_component parent = null);
    //create driver
    super.new(name, parent); 
    //create info
    `uvm_info(get_type_name(), "created", UVM_LOW)
endfunction : new

function void frame_driver::build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db #(virtual shk_interface)::get(this,"","shk_interface",vif))
    begin
        `uvm_fatal("frame_driver","Error in get interface");
    end
    ap = new("ap",this);
endfunction

task frame_driver::main_phase(uvm_phase phase);
    frame_transaction req;
    super.main_phase(phase);
    while(1)
        begin
            seq_item_port.get_next_item(req);
            drive_one_pkt(req);
            ap.write(req);
            seq_item_port.item_done();
        end
endtask

task frame_driver::drive_one_pkt(frame_transaction req);
    vif.w_shk_valid = 'b0;
    vif.w_shk_msync = 'b0;
    vif.w_shk_mdata = 'b0;
    vif.w_shk_maddr = 'b0;
    vif.w_shk_msync = 'b0;
    #100
    begin
        vif.w_shk_valid = 'b1;
        vif.w_shk_msync = 'b0;
        vif.w_shk_mdata = 'b100;
        vif.w_shk_maddr = 'b110;
        vif.w_shk_msync = 'b0;
    end
    
endtask

`endif //FRAME_DRIVER_SV