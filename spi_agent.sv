//-------------------------------------------------------------------------
//						spi_agent - www.verificationguide.com 
//-------------------------------------------------------------------------

// This module has been adapted to work with SPI modules

`include "spi_seq_item.sv"
`include "spi_sequencer.sv"
`include "spi_sequence.sv"
`include "spi_driver.sv"
`include "spi_monitor.sv"

class spi_agent extends uvm_agent;

  //---------------------------------------
  // component instances
  //---------------------------------------
  spi_driver    driver;
  spi_sequencer sequencer;
  spi_monitor   monitor;

  `uvm_component_utils(spi_agent)
  
  //---------------------------------------
  // constructor
  //---------------------------------------
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  //---------------------------------------
  // build_phase
  //---------------------------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    monitor = spi_monitor::type_id::create("monitor", this);

    //creating driver and sequencer only for ACTIVE agent
    if(get_is_active() == UVM_ACTIVE) begin
      driver    = spi_driver::type_id::create("driver", this);
      sequencer = spi_sequencer::type_id::create("sequencer", this);
    end
  endfunction : build_phase
  
  //---------------------------------------  
  // connect_phase - connecting the driver and sequencer port
  //---------------------------------------
  function void connect_phase(uvm_phase phase);
    if(get_is_active() == UVM_ACTIVE) begin
      driver.seq_item_port.connect(sequencer.seq_item_export);
    end
  endfunction : connect_phase

endclass : spi_agent
