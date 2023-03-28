// *********************************************************************************
// Company: Fpga Publish
// Engineer: F 
// 
// Create Date: 2023/03/28 22:08:42
// Design Name: 
// Module Name: frame_transaction
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
`ifndef FRAME_TRANSACTION_SV
`define FRAME_TRANSACTION_SV

class frame_transaction extends uvm_sequence_item;
    
    bit w_spi_port_csns ;
    bit w_spi_port_sclk ;
    bit w_spi_port_mosi ;
    bit w_spi_port_miso ;
    
    //add to factory
    `uvm_object_utils_begin(frame_transaction)
        `uvm_field_int(w_spi_port_csns,UVM_ALL_ON)
        `uvm_field_int(w_spi_port_sclk,UVM_ALL_ON)
        `uvm_field_int(w_spi_port_mosi,UVM_ALL_ON)
        `uvm_field_int(w_spi_port_miso,UVM_ALL_ON)
    `uvm_object_utils_end
    
endclass: frame_transaction

function frame_transaction::new (string name = "frame_transaction");
    super.new(name);
endfunction


`endif //FRAME_TRANSACTION_SV