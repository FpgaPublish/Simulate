`ifndef FRAME_INTERFACE_SV
`define FRAME_INTERFACE_SV

interface shk_interface(input bit i_sys_clk, bit i_sys_resetn);
    logic           w_shk_valid;
    logic           w_shk_msync;
    logic  [31:0]   w_shk_mdata;
    logic  [31:0]   w_shk_maddr;
    
    logic           w_shk_ssync;
    logic           w_shk_ready;
    logic  [31:0]   w_shk_sdata;
    logic  [31:0]   w_shk_saddr;
    
endinterface : frame_interface

`endif //FRAME_INTERFACE_SV
