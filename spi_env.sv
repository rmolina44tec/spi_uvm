//-------------------------------------------------------------------------
//						mem_env - www.verificationguide.com
//-------------------------------------------------------------------------

`include "spi_agent.sv"
`include "spi_scoreboard.sv"

class spi_model_env extends uvm_env;
  
  //---------------------------------------
  // agent and scoreboard instance
  //---------------------------------------
  spi_agent      spi_agnt;
  spi_scoreboard mem_scb;
  
  `uvm_component_utils(spi_model_env)
  
  //--------------------------------------- 
  // constructor
  //---------------------------------------
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  //---------------------------------------
  // build_phase - crate the components
  //---------------------------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    spi_agnt = spi_agent::type_id::create("spi_agnt", this);
    mem_scb  = spi_scoreboard::type_id::create("spi_scb", this);
  endfunction : build_phase
  
  //---------------------------------------
  // connect_phase - connecting monitor and scoreboard port
  //---------------------------------------
  function void connect_phase(uvm_phase phase);
    spi_agnt.monitor.item_collected_port.connect(mem_scb.item_collected_export);
  endfunction : connect_phase

endclass : spi_model_env
