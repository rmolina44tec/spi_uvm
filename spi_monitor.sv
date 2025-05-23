//-------------------------------------------------------------------------
//						mem_monitor - www.verificationguide.com 
//-------------------------------------------------------------------------

class spi_monitor extends uvm_monitor;

  //---------------------------------------
  // Virtual Interface
  //---------------------------------------
  virtual spi_if vif;

  //---------------------------------------
  // analysis port, to send the transaction to scoreboard
  //---------------------------------------
  uvm_analysis_port #(spi_seq_item) item_collected_port;
  
  //---------------------------------------
  // The following property holds the transaction information currently
  // begin captured (by the collect_address_phase and data_phase methods).
  //---------------------------------------
  spi_seq_item trans_collected;

  `uvm_component_utils(spi_monitor);

  //---------------------------------------
  // new - constructor
  //---------------------------------------
  function new (string name, uvm_component parent);
    super.new(name, parent);
    trans_collected = new();
    item_collected_port = new("item_collected_port", this);
  endfunction : new

  //---------------------------------------
  // build_phase - getting the interface handle
  //---------------------------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual spi_if)::get(this, "", "vif", vif))
       `uvm_fatal("NOVIF",{"virtual interface must be set for: ",get_full_name(),".vif"});
  endfunction: build_phase
  
  //---------------------------------------
  // run_phase - convert the signal level activity to transaction level.
  // i.e, sample the values on interface signal ans assigns to transaction class fields
  //---------------------------------------
  virtual task run_phase(uvm_phase phase);
    forever begin
      @(posedge vif.MONITOR.clk);
      wait(vif.monitor_cb.pop || vif.monitor_cb.push);
	trans_collected.pop= vif.monitor_cb.pop;
	trans_collected.push= vif.monitor_cb.push;
	trans_collected.D_pop= vif.monitor_cb.D_pop;
	trans_collected.D_push= vif.monitor_cb.D_push;
	item_collected_port.write(trans_collected);
      end 
  endtask : run_phase

endclass : spi_monitor
