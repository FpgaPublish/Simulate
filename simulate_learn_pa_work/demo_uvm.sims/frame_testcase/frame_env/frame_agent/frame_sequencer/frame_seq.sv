`ifndef FRAME_SEQ_SV
`define FRAME_SEQ_SV

class frame_seq extends uvm_sequence #(frame_seq_item);
    `uvm_object_utils(frame_seq)
 
    extern function new(string name = "frame_seq");
endclass : frame_seq
 
function frame_seq::new(string name = "frame_seq");
    //create seq
    super.new(name);
    
    //create info
    `uvm_info(get_type_name(), "created", UVM_HIGH)
endfunction : new


`endif //FRAME_SEQ_SV