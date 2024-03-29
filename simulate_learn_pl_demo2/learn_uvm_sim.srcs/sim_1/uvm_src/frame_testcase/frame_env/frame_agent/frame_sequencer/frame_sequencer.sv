//`include "uvm_macros.svh"
`ifndef FRAME_SEQUENCER_SV
`define FRAME_SEQUENCER_SV

class frame_sequencer extends uvm_sequencer #(frame_transaction);
    `uvm_component_utils(frame_sequencer)
 
    extern function new(string name = "frame_sequencer", uvm_component parent = null);
    extern function void build_phase(uvm_phase phase);
endclass : frame_sequencer
 
function frame_sequencer::new(string name = "frame_sequencer", uvm_component parent = null);
    super.new(name, parent); //create sequncer 
    
    //create info
    `uvm_info(get_type_name(), "created", UVM_LOW)
endfunction : new
function void frame_sequencer::build_phase(uvm_phase phase);
    super.build_phase(phase);
endfunction


`endif //FRAME_SEQUENCER_SV