//-------------------------------------------------------------------------
//						mem_driver - www.verificationguide.com
//-------------------------------------------------------------------------

`define DRIV_IF vif.DRIVER.driver_cb

class spi_driver extends uvm_driver #(spi_seq_item);

  //--------------------------------------- 
  // Virtual Interface
  //--------------------------------------- 
  virtual spi_if vif;
  `uvm_component_utils(spi_driver)
    
  //--------------------------------------- 
  // Constructor
  //--------------------------------------- 
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  //--------------------------------------- 
  // build phase
  //---------------------------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
     if(!uvm_config_db#(virtual spi_if)::get(this, "", "vif", vif))
       `uvm_fatal("NO_VIF",{"virtual interface must be set for: ",get_full_name(),".vif"});
  endfunction: build_phase

  //---------------------------------------  
  // run phase
  //---------------------------------------  
  virtual task run_phase(uvm_phase phase);
    forever begin
      seq_item_port.get_next_item(req);
      drive();
      seq_item_port.item_done();
    end
  endtask : run_phase
  
  //---------------------------------------
  // drive - transaction level to signal level
  // drives the value's from seq_item to interface signals
  //---------------------------------------
  virtual task drive();
    `DRIV_IF.pop <= 0;
    `DRIV_IF.push <= 0;
    @(posedge vif.DRIVER.clk);
    
    `DRIV_IF.D_pop <= req.D_pop;
    
    if(req.pop) begin // pop operation
      `DRIV_IF.pop <= req.pop;
      `DRIV_IF.D_pop <= req.D_pop;
      @(posedge vif.DRIVER.clk);
    end
    else if(req.push) begin //push operation
      `DRIV_IF.push <= req.push;
      @(posedge vif.DRIVER.clk);
      `DRIV_IF.push <= 0;
      @(posedge vif.DRIVER.clk);
      req.D_push = `DRIV_IF.D_push;
    end
    
  endtask : drive
endclass : spi_driver
