`ifndef FRAME_SEQ_ITEM_H
`define FRAME_SEQ_ITEM_H

class frame_seq_item extends uvm_sequence_item;
    //uvm set
    `uvm_object_utils(frame_seq_item)
    //function list
    extern function new(string name = "frame_seq_item");
    
endclass : frame_seq_item

function frame_seq_item::new(string name = "frame_seq_item");
    //create sequence
    super.new(name);
    //create info
    `uvm_info(get_type_name(), "created", UVM_HIGH)
    
endfunction : new

`endif