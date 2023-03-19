`ifndef FRAME_SEQUENCER_SV
`define FRAME_SEQUENCER_SV

class frame_sequencer extends uvm_sequencer #(frame_seq_item);
    `uvm_component_utils(frame_sequencer)
 
    extern function new(string name = "frame_sequencer", uvm_component parent = null);
endclass : frame_sequencer
 
function frame_sequencer::new(string name = "frame_sequencer", uvm_component parent = null);
    super.new(name, parent); //create sequncer 
    
    //create info
    `uvm_info(get_type_name(), "created", UVM_LOW)
endfunction : new

`endif //FRAME_SEQUENCER_SV