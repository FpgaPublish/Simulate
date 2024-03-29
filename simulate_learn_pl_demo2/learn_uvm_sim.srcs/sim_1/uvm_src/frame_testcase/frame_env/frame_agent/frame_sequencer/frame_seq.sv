// *********************************************************************************
// Company: Fpga Publish
// Engineer: F 
// 
// Create Date: 2023/03/07 22:56:54
// Design Name: 
// Module Name: frame_seq
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

`ifndef FRAME_SEQ_SV
`define FRAME_SEQ_SV

class frame_seq extends uvm_sequence #(frame_transaction);
    `uvm_object_utils(frame_seq)
    frame_transaction u_transaction;
 
    extern function new(string name = "frame_seq");
    virtual task body();
        if(starting_phase!= null)
        begin
            starting_phase.raise_objection(this);
            repeat(10)
            begin
                `uvm_do(u_transaction)
            end
            #0;
        end
        if(starting_phase !=null)
        begin
            starting_phase.drop_objection(this);
        end
    endtask
endclass : frame_seq
 
function frame_seq::new(string name = "frame_seq");
    //create seq
    super.new(name); //create sequence
    
    //create info
    `uvm_info(get_type_name(), "created", UVM_HIGH)
endfunction : new


`endif //FRAME_SEQ_SV