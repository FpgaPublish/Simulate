// *********************************************************************************
// Company: Fpga Publish
// Engineer: F 
// 
// Create Date: 2023/02/19 14:22:13
// Design Name: 
// Module Name: shk_example
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

// ######################################################################
// master
module m_shk#(
    parameter WD_SHK_DAT = 32,
    parameter WD_SHK_ADR = 32,
    parameter MD_SIM_FUN = 0 
)(
    input       i_sys_clk,
    input       i_sys_rst_n,
    
    //SHK bus interface
    output                      m_shk_0_valid,
    output [WD_SHK_ADR-1:0]     m_shk_0_maddr,
    output [WD_SHK_DAT-1:0]     m_shk_0_mdata,
    output                      m_shk_0_msync,
    input                       m_shk_0_ready,
    input  [WD_SHK_ADR-1:0]     m_shk_0_saddr,
    input  [WD_SHK_DAT-1:0]     m_shk_0_sdata,
    input                       m_shk_0_ssync,
        
    
    output                      o_unusual_flg
);
//shake variable
reg                      r_shk_0_valid = 0;
reg [WD_SHK_ADR-1:0]     r_shk_0_maddr = 0;
reg [WD_SHK_DAT-1:0]     r_shk_0_mdata = 0;
reg                      r_shk_0_msync = 0;
//shake cycle trig count
reg [7:0] r_valid_cyc_cnt = 0;

//
always@(posedge i_sys_clk)
begin
    r_valid_cyc_cnt <= r_valid_cyc_cnt + 1'b1;
end
always@(posedge i_sys_clk)
begin
    if(m_shk_0_ready)
    begin
        r_shk_0_valid <= (MD_SIM_FUN) ? 1'b1 : 1'b0;
    end
    else if(r_valid_cyc_cnt == 1)
    begin
        r_shk_0_valid <= 1'b1;
    end
end
always@(posedge i_sys_clk)
begin
    if(r_valid_cyc_cnt == 1 && !r_shk_0_valid)
    begin
        r_shk_0_maddr <= r_shk_0_maddr + 1'b1;
        r_shk_0_mdata <= r_shk_0_mdata + 1'b1;
        r_shk_0_msync <= ~r_shk_0_msync;
    end
end
//output connect
assign m_shk_0_valid = r_shk_0_valid;
assign m_shk_0_maddr = r_shk_0_maddr;
assign m_shk_0_mdata = r_shk_0_mdata;
assign m_shk_0_msync = r_shk_0_msync;

endmodule
// ######################################################################
// slaver

module s_shk#(
    parameter WD_SHK_DAT = 32,
    parameter WD_SHK_ADR = 32
)(
    input       i_sys_clk,
    input       i_sys_rst_n,
    
    //SHK bus interface
    input                      s_shk_0_valid,
    input   [WD_SHK_ADR-1:0]   s_shk_0_maddr,
    input   [WD_SHK_DAT-1:0]   s_shk_0_mdata,
    input                      s_shk_0_msync,
    output                     s_shk_0_ready,
    output  [WD_SHK_ADR-1:0]   s_shk_0_saddr,
    output  [WD_SHK_DAT-1:0]   s_shk_0_sdata,
    output                     s_shk_0_ssync,
        
    output                      o_unusual_flg
);
//shake variable
reg                     r_shk_0_ready = 0;
reg  [WD_SHK_ADR-1:0]   r_shk_0_saddr = 0;
reg  [WD_SHK_DAT-1:0]   r_shk_0_sdata = 0;
reg                     r_shk_0_ssync = 0;
//ready prepare count
reg [3:0] r_ready_solve_cnt = 0;
//
always@(posedge i_sys_clk)
begin
    if(s_shk_0_valid && r_ready_solve_cnt == 7) //count is full
    begin
        r_ready_solve_cnt <= 1'b0;
    end
    else 
    begin
        if(r_ready_solve_cnt == 7)
        begin
            r_ready_solve_cnt <= r_ready_solve_cnt;
        end
        else 
        begin
            r_ready_solve_cnt <= r_ready_solve_cnt + 1'b1;
        end
    end
end
//
always@(posedge i_sys_clk)
begin
    if(r_ready_solve_cnt == 7)
    begin
        r_shk_0_ready <= 1'b0;
    end
    else if(s_shk_0_valid)
    begin
        r_shk_0_ready <= 1'b1;
    end
end
always@(posedge i_sys_clk)
begin
    if(r_ready_solve_cnt == 1)
    begin
        r_shk_0_saddr <= r_shk_0_saddr + 1'b1;
        r_shk_0_sdata <= r_shk_0_sdata + 1'b1;
        r_shk_0_ssync <= ~r_shk_0_ssync;
    end
end
//output connect
assign s_shk_0_ready = r_shk_0_ready;
assign s_shk_0_saddr = r_shk_0_saddr;
assign s_shk_0_sdata = r_shk_0_sdata;
assign s_shk_0_ssync = r_shk_0_ssync;

endmodule

// ######################################################################
// simulate
interface  shk#(
    parameter WD_SHK_DAT = 32,
    parameter WD_SHK_ADR = 32
    )();
    logic                   valid;
    logic [WD_SHK_ADR-1:0]  maddr;
    logic [WD_SHK_DAT-1:0]  mdata;
    logic                   msync;
    logic                   ready;
    logic [WD_SHK_ADR-1:0]  saddr;
    logic [WD_SHK_DAT-1:0]  sdata;
    logic                   ssync;
endinterface // shk



`timescale 1ps / 1ps
module shk_example #(
    parameter WD_SHK_DAT = 32,
    parameter WD_SHK_ADR = 32
   )(
    
);
//clock and rst
reg i_sys_clk    = 0;
reg i_sys_rst_n  = 0;
//
always #5 i_sys_clk = ~i_sys_clk;
initial #100 i_sys_rst_n = 1;
initial #100000 $stop();

//interface
shk#(
    .WD_SHK_DAT    ( 32 ),
    .WD_SHK_ADR    ( 32 )
)shk0();

//master
m_shk#(
    .WD_SHK_DAT    ( 32 ),
    .WD_SHK_ADR    ( 32 ),
    .MD_SIM_FUN    ( 1  )  //sim1: valid lock
)u_m_shk(
    .i_sys_clk     ( i_sys_clk     ),
    .i_sys_rst_n   ( i_sys_rst_n   ),
    .m_shk_0_valid ( shk0.valid    ),
    .m_shk_0_maddr ( shk0.maddr    ),
    .m_shk_0_mdata ( shk0.mdata    ),
    .m_shk_0_msync ( shk0.msync    ),
    .m_shk_0_ready ( shk0.ready    ),
    .m_shk_0_saddr ( shk0.saddr    ),
    .m_shk_0_sdata ( shk0.sdata    ),
    .m_shk_0_ssync ( shk0.ssync    ),
    .o_unusual_flg  (   )
);
//slaver
s_shk#(
    .WD_SHK_DAT    ( 32 ),
    .WD_SHK_ADR    ( 32 )
)u_s_shk(
    .i_sys_clk     ( i_sys_clk     ),
    .i_sys_rst_n   ( i_sys_rst_n   ),
    .s_shk_0_valid ( shk0.valid    ),
    .s_shk_0_maddr ( shk0.maddr    ),
    .s_shk_0_mdata ( shk0.mdata    ),
    .s_shk_0_msync ( shk0.msync    ),
    .s_shk_0_ready ( shk0.ready    ),
    .s_shk_0_saddr ( shk0.saddr    ),
    .s_shk_0_sdata ( shk0.sdata    ),
    .s_shk_0_ssync ( shk0.ssync    ),
    .o_unusual_flg (  )
);

// --------------------------------------------------------------------
// assertion for shk
property p_slaver_repo;
    @(posedge i_sys_clk) $rose(shk0.ready) |-> ##[1:3] (!shk0.valid); //ready make valid reset to avoid lock
endproperty
a_salver_repo: assert property(p_slaver_repo) else $display("slaver repo but master not relase");



endmodule