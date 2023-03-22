`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/21 21:55:13
// Design Name: 
// Module Name: shk_spi_driv
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


`timescale 1ns / 1ps
`define NB_SYS_LEVEL 10 //ns

`define ERR_SUBT_OVER_RANGE 4'd1
module shk_spi_driv #(
    //mode
    parameter MD_SIM_ABLE = 0,
    parameter MD_SPI_VOLT = 2'b0, //[0]:data sampled on rise if 0
                                  //[1]:clock idle in low if 0
    
    //number
    parameter NB_SPD_LEVEL = 1000,//ns,once solve time
    parameter NB_CLK_START = 100 ,//ns,clk start work
    parameter NB_CLK_PLUSE = 40  ,//ns,clk pluse once span
    parameter NB_CLK_IDLES = 20  ,//ns,clk pluse in idle span 
    parameter NB_CLK_NUMBE = 9   ,//bit,clock number
    //width
    parameter WD_SHK_ADR   = 16  , //shake width of addr
    parameter WD_SHK_DAT   = 16  , //shake width of data
    parameter WD_ERR_INFO  = 4
   )(
    //system signals
    input           i_sys_clk  ,  
    input           i_sys_rst_n,  
    //SHK interface of slaver
    input                       s_shk_spi_valid,
    input   [WD_SHK_ADR-1:0]    s_shk_spi_maddr,
    input   [WD_SHK_DAT-1:0]    s_shk_spi_mdata,
    input                       s_shk_spi_msync,
    output                      s_shk_spi_ready,
    output  [WD_SHK_ADR-1:0]    s_shk_spi_saddr,
    output  [WD_SHK_DAT-1:0]    s_shk_spi_sdata,
    output                      s_shk_spi_ssync,
    //SPI interface of master
    output                      m_spi_port_csns,
    output                      m_spi_port_sclk,
    output                      m_spi_port_mosi,
    input                       m_spi_port_miso,
    
    //error info feedback
    output   [WD_ERR_INFO-1:0]  m_err_shk_info1
);
//========================================================
//function to math and logic
//function y = 2 ^ N
function automatic integer EXP2_N(input integer N);
    for(EXP2_N = 1; N > 0; EXP2_N = EXP2_N * 2)
    begin
        N = N - 1;
    end
endfunction
//function y = [log2(N)]
function automatic integer LOG2_N(input integer N);
    for(LOG2_N = 0; N > 1; LOG2_N = LOG2_N + 1)
    begin
        N = N >> 1;
    end
endfunction
//========================================================
//localparam to converation and calculate
localparam WD_ONCE_CNT = LOG2_N(NB_SPD_LEVEL/`NB_SYS_LEVEL) + 1;
localparam WD_CLK_NUMB = LOG2_N(NB_CLK_NUMBE) + 1;
//========================================================
//register and wire to time sequence and combine
//shk data temp
reg [WD_SHK_DAT -1:0]   r_shk_spi_mdata;
//stream data
reg                     r_stm_spi_sync;
reg [WD_ONCE_CNT-1:0]   r_stm_spi_cunt;
//spi port
reg r_spi_port_csns;
reg r_spi_port_sclk;
reg r_spi_port_mosi;
//spi clock count
reg                     r_spi_sclk_sync;
reg [WD_ONCE_CNT  -1:0] r_spi_sclk_cunt;
reg [WD_CLK_NUMB  -1:0] r_clk_numb_cunt;
reg [WD_CLK_NUMB  -1:0] r_clk_numb_subt;
//spi data read
reg [WD_SHK_DAT   -1:0] r_shk_spi_sdata;
//========================================================
//always and assign to drive logic and connect
// ----------------------------------------------------------
// shake data
always@(posedge i_sys_clk)
begin
    if(!i_sys_rst_n) //system reset
    begin
        r_shk_spi_mdata <= 1'b0; //
    end
    else if(s_shk_spi_valid) //
    begin
        r_shk_spi_mdata <= s_shk_spi_mdata;  //
    end
end
// ----------------------------------------------------------
//stream frame
always@(posedge i_sys_clk)
begin
    if(!i_sys_rst_n) //system reset
    begin
        r_stm_spi_sync <= 1'b0; //
    end
    else if(s_shk_spi_valid) //
    begin
        r_stm_spi_sync <= 1'b1;  //
    end
    else if(r_stm_spi_cunt == NB_SPD_LEVEL - 1'b1)
    begin
        r_stm_spi_sync <= 1'b0;
    end
end
always@(posedge i_sys_clk)
begin
    if(!i_sys_rst_n) //system reset
    begin
        r_stm_spi_cunt <= 1'b0; //
    end
    else if(r_stm_spi_sync) //
    begin
        if(r_stm_spi_cunt == NB_SPD_LEVEL - 1'b1)
        begin
            r_stm_spi_cunt <= 1'b0;
        end
        else 
        begin
            r_stm_spi_cunt <= r_stm_spi_cunt + 1'b1;  //
        end
    end
    else 
    begin
        r_stm_spi_cunt <= 1'b0;
    end
end
// ----------------------------------------------------------
// sclk counter
always@(posedge i_sys_clk)
begin
    if(!i_sys_rst_n) //system reset
    begin
        r_spi_sclk_sync <= 1'b0; //
    end
    else if(r_stm_spi_cunt == NB_CLK_START / `NB_SYS_LEVEL) //clock start count
    begin
        r_spi_sclk_sync <= 1'b1;  //
    end
    else if(r_clk_numb_cunt == NB_CLK_NUMBE) //last clock count finish
    begin
        r_spi_sclk_sync <= 1'b0;
    end
end
always@(posedge i_sys_clk)
begin
    if(!i_sys_rst_n) //system reset
    begin
        r_spi_sclk_cunt <= 1'b0; //
    end
    else if(r_spi_sclk_sync) //
    begin
        if(r_spi_sclk_cunt == NB_CLK_PLUSE - 1'b1)  //
        begin
            r_spi_sclk_cunt <= 1'b0;
        end
        else
        begin
            r_spi_sclk_cunt <= r_spi_sclk_cunt + 1'b1;
        end
    end
    else 
    begin
        r_spi_sclk_cunt <= 1'b0;
    end
end
always@(posedge i_sys_clk)
begin
    if(!i_sys_rst_n) //system reset
    begin
        r_clk_numb_cunt <= 1'b0; //
        r_clk_numb_subt <= 1'b0;
    end
    else if(r_spi_sclk_sync) //
    begin
        if(r_spi_sclk_cunt == NB_CLK_PLUSE - 1'b1)  //
        begin
            r_clk_numb_cunt <= r_clk_numb_cunt + 1'b1;
            r_clk_numb_subt <= r_clk_numb_subt - 1'b1;
        end
    end
    else
    begin
        r_clk_numb_cunt <= 1'b0;
        r_clk_numb_subt <= NB_CLK_NUMBE - 1'b1;
    end
end
// ----------------------------------------------------------
// spi signals gen
always@(posedge i_sys_clk)
begin
    if(!i_sys_rst_n) //system reset
    begin
        r_spi_port_csns <= 1'b0; //
    end
    else if(r_stm_spi_sync) //
    begin
        r_spi_port_csns <= 1'b0;  //
    end
    else  
    begin
        r_spi_port_csns <= 1'b1;
    end
end
always@(posedge i_sys_clk)
begin
    if(!i_sys_rst_n) //system reset
    begin
        r_spi_port_sclk <= 1'b0; //
    end
    else if(r_spi_sclk_sync) //
    begin
        if(r_spi_sclk_cunt == NB_CLK_IDLES/`NB_SYS_LEVEL - 1'b1)  //
        begin
            r_spi_port_sclk <= ~MD_SPI_VOLT[1]; //from idle to lock
        end
        else if(r_spi_sclk_cunt == NB_CLK_PLUSE/`NB_SYS_LEVEL - 1'b1)
        begin
            r_spi_port_sclk <= MD_SPI_VOLT[1];
        end
    end
    else 
    begin
        r_spi_port_sclk <= MD_SPI_VOLT[1];
    end
end
always@(posedge i_sys_clk)
begin
    if(!i_sys_rst_n) //system reset
    begin
        r_spi_port_mosi <= 1'b0; //
    end
    else if(r_spi_sclk_sync)
    begin
        case(MD_SPI_VOLT)
            0: //data sample in rise and clock form low
                begin
                    if(r_spi_sclk_cunt == NB_CLK_IDLES / 2 / `NB_SYS_LEVEL - 1'b1)
                    begin
                        r_spi_port_mosi <= r_shk_spi_mdata[r_clk_numb_subt];
                    end
                end
            1:  //data sample in fall and clock from low
                begin
                    if(r_spi_sclk_cunt == NB_CLK_IDLES / 2 / `NB_SYS_LEVEL - 1'b1 && r_clk_numb_subt >= 1'b1)
                    begin
                        r_spi_port_mosi <= r_shk_spi_mdata[r_clk_numb_subt-1'b1];
                    end
                end
            2: //data sample in rise and clock from high
                begin
                    if(r_spi_sclk_cunt == (NB_CLK_IDLES + NB_CLK_PLUSE) / 2 / `NB_SYS_LEVEL - 1'b1 && r_clk_numb_subt >= 1'b1)
                    begin
                        r_spi_port_mosi <= r_shk_spi_mdata[r_clk_numb_subt-1'b1];
                    end
                end
            3:  //data sample in fall and clock from high
                begin
                    if(r_spi_sclk_cunt == (NB_CLK_IDLES + NB_CLK_PLUSE) / 2 / `NB_SYS_LEVEL - 1'b1)
                    begin
                        r_spi_port_mosi <= r_shk_spi_mdata[r_clk_numb_subt];
                    end
                end
        endcase
    end
    else
    begin
        r_spi_port_mosi <= r_shk_spi_mdata[r_clk_numb_subt];
    end
end
assign m_spi_port_csns = r_spi_port_csns;
assign m_spi_port_sclk = r_spi_port_sclk;
assign m_spi_port_mosi = r_spi_port_mosi;
// ----------------------------------------------------------
// spi data read
always@(posedge i_sys_clk)
begin
    if(!i_sys_rst_n) //system reset
    begin
        r_shk_spi_sdata <= 1'b0; //
    end
    else if(r_spi_sclk_sync) //
    begin
        case(MD_SPI_VOLT)  //
            0: //data sample in rise and clock form low
                begin
                    if(r_spi_sclk_cunt == NB_CLK_IDLES  / `NB_SYS_LEVEL - 1'b1)
                    begin
                        r_shk_spi_sdata[r_clk_numb_subt] <= m_spi_port_miso;
                    end
                end
            1: //data sample in fall and clock from low
                begin
                    if(r_spi_sclk_cunt == NB_CLK_PLUSE / `NB_SYS_LEVEL - 1'b1)
                    begin
                        r_shk_spi_sdata[r_clk_numb_subt] <= m_spi_port_miso;
                    end
                end
            2: //data sample in rise and clock from high
                begin
                    if(r_spi_sclk_cunt == NB_CLK_PLUSE / `NB_SYS_LEVEL - 1'b1)
                    begin
                        r_shk_spi_sdata[r_clk_numb_subt] <= m_spi_port_miso;
                    end
                end
            3: //data sample in fall and clock from high
                begin
                    if(r_spi_sclk_cunt == NB_CLK_IDLES / `NB_SYS_LEVEL - 1'b1)
                    begin
                        r_shk_spi_sdata[r_clk_numb_subt] <= m_spi_port_miso;
                    end
                end
        endcase
    end
end
assign s_shk_spi_sdata = r_shk_spi_sdata;
assign s_shk_spi_ready = r_stm_spi_cunt == NB_SPD_LEVEL - 1'b1; //whole stream count over

//========================================================
//module and task to build part of system

//========================================================
//expand and plug-in part with version 

//========================================================
//ila and vio to debug and monitor
assign m_err_shk_info1 = (r_clk_numb_subt > NB_CLK_NUMBE) ? `ERR_SUBT_OVER_RANGE : 1'b0;


endmodule