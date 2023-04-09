`ifndef FRAME_ENV_REFM_SV
`define FRAME_ENV_REFM_SV

class frame_env_refm extends uvm_component;
    `uvm_component_utils(frame_env_refm) //init ref module
    uvm_blocking_get_port #(frame_transaction) port;
    uvm_analysis_port #(frame_transaction) ap;
    extern function new(string name = "frame_env_refm", uvm_component parent = null);
    extern function void build_phase(uvm_phase phase);
    extern virtual task main_phase(uvm_phase phase);
    extern virtual task one_pkt(ref frame_transaction pkt, ref frame_transaction pkt2);
endclass : frame_env_refm
 
function frame_env_refm::new(string name = "frame_env_refm", uvm_component parent = null);
    super.new(name, parent); //create ref module
    
    `uvm_info(get_type_name(), "created", UVM_LOW)
endfunction : new
function void frame_env_refm::build_phase(uvm_phase phase);
    super.build_phase(phase);
    port=new("port",this);
    ap=new("ap",this);
endfunction
task frame_env_refm::main_phase(uvm_phase phase);
    frame_transaction tr,tr2;
    super.main_phase(phase);
    while(1)
    begin
        tr2 = new();
        port.get(tr);
        one_pkt(tr2,tr);
        ap.write(tr2);
    end
endtask //frame_env_refm::main_phase
task frame_env_refm::one_pkt(ref frame_transaction pkt, ref frame_transaction pkt2);
    begin
        
    end
endtask //frame_env_refm


`endif //FRAME_ENV_REFM_SV