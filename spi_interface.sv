//-------------------------------------------------------------------------
//						mem_interface - www.verificationguide.com
//-------------------------------------------------------------------------

interface spi_if(input logic clk,reset);
  
  //---------------------------------------
  //declaring the signals
  //---------------------------------------
  //logic [1:0] addr;
  //logic wr_en;
  //logic rd_en;
  //logic [7:0] wdata;
  //logic [7:0] rdata;

  logic pndgn; //Pendiente FIFO TX
  logic [64:0] D_pop; //Datos FIFO TX
  logic MISO; //Signal of SPI
  logic	pop; //Control FIFO TX
  logic	[64:0]	D_push; //Datos FIFO RX
  logic	push; //Control FIFO RX
  logic MOSI; //SPI
  logic SCLK; //SPI
  logic SCS; //SPI
  
  //---------------------------------------
  //driver clocking block
  //---------------------------------------
  clocking driver_cb @(posedge clk);
    default input #1 output #1;
    //output addr;
    //output wr_en;
    //output rd_en;
    //output wdata;
    //input  rdata;
    output  pndgn;
    output  D_pop;
    output  MISO;
    output   pop;
    input   D_push;
    output   push;
    input   MOSI;
    input   SCLK;
    input   SCS;
  endclocking
  
  //---------------------------------------
  //monitor clocking block
  //---------------------------------------
  clocking monitor_cb @(posedge clk);
    default input #1 output #1;
    //input addr;
    //input wr_en;
    //input rd_en;
    //input wdata;
    //input rdata;  
    input  pndgn;
    input  D_pop;
    input  MISO;
    input   pop;
    input   D_push;
    input   push;
    input   MOSI;
    input   SCLK;
    input   SCS;
  endclocking
  
  //---------------------------------------
  //driver modport
  //---------------------------------------
  modport DRIVER  (clocking driver_cb,input clk,reset);
  
  //---------------------------------------
  //monitor modport  
  //---------------------------------------
  modport MONITOR (clocking monitor_cb,input clk,reset);
  
endinterface
