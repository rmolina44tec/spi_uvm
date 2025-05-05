//-------------------------------------------------------------------------
//				www.verificationguide.com   testbench.sv
//-------------------------------------------------------------------------
//---------------------------------------------------------------
//including interfcae and testcase files
`include "spi_interface.sv"
`include "spi_base_test.sv"
`include "spi_pop_test.sv" //modulo prueba
//---------------------------------------------------------------

module tbench_top;

  //---------------------------------------
  //clock and reset signal declaration
  //---------------------------------------
  bit clk;
  bit reset;
  
  //---------------------------------------
  //clock generation
  //---------------------------------------
  always #5 clk = ~clk;
  
  //---------------------------------------
  //reset Generation
  //---------------------------------------
  initial begin
    reset = 1;
    #5 reset =0;
  end
  
  //---------------------------------------
  //interface instance
  //---------------------------------------
  spi_if intf(clk,reset);
  
  //---------------------------------------
  //DUT instance
  //---------------------------------------
  top_spi DUT (
    .CLK(intf.clk),
    .reset(intf.reset),
    .pndgn(intf.pndgn),
    .D_pop(intf.D_pop),
    .MISO(intf.MISO),
    .pop(intf.pop),
    .D_push(intf.D_push),
    .push(intf.push),
    .MOSI(intf.MOSI),
    .SCLK(intf.SCLK),
    .SCS(intf.SCS)
   );
  
  //---------------------------------------
  //passing the interface handle to lower heirarchy using set method 
  //and enabling the wave dump
  //---------------------------------------
  initial begin 
    uvm_config_db#(virtual spi_if)::set(uvm_root::get(),"*","vif",intf);
    //enable wave dump
    $dumpfile("dump.vcd"); 
    $dumpvars;
  end
  
  //---------------------------------------
  //calling test
  //---------------------------------------
  initial begin 
    run_test();
  end
  
endmodule
