//-------------------------------------------------------------------------
//						mem_scoreboard - www.verificationguide.com 
//-------------------------------------------------------------------------

class spi_scoreboard extends uvm_scoreboard;
  
  //---------------------------------------
  // declaring pkt_qu to store the pkt's recived from monitor
  //---------------------------------------
  spi_seq_item pkt_qu[$];
  
  //---------------------------------------
  // sc_mem 
  //---------------------------------------
  bit [64:0] sc_mem [4];

  //---------------------------------------
  //port to recive packets from monitor
  //---------------------------------------
  uvm_analysis_imp#(spi_seq_item, spi_scoreboard) item_collected_export;
  `uvm_component_utils(spi_scoreboard)

  //---------------------------------------
  // new - constructor
  //---------------------------------------
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new
  //---------------------------------------
  // build_phase - create port and initialize local memory
  //---------------------------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
      item_collected_export = new("item_collected_export", this);
      foreach(sc_mem[i]) sc_mem[i] = 8'hFF;
  endfunction: build_phase
  
  //---------------------------------------
  // write task - recives the pkt from monitor and pushes into queue
  //---------------------------------------
  virtual function void write(spi_seq_item pkt);
    //pkt.print();
    pkt_qu.push_back(pkt);
  endfunction : write

  //---------------------------------------
  // run_phase - compare's the read data with the expected data(stored in local memory)
  // local memory will be updated on the write operation.
  //---------------------------------------
  virtual task run_phase(uvm_phase phase);
    spi_seq_item spi_pkt;
    
    forever begin
      wait(pkt_qu.size() > 0);
      spi_pkt = pkt_qu.pop_front();
      
      if(spi_pkt.pop) begin
        sc_mem[spi_pkt.D_pop] = spi_pkt.D_push;
        `uvm_info(get_type_name(),$sformatf("------ :: POPPED DATA       :: ------"),UVM_LOW)
        `uvm_info(get_type_name(),$sformatf("Pop: %0h",spi_pkt.D_push),UVM_LOW)
        `uvm_info(get_type_name(),$sformatf("Push: %0h",spi_pkt.D_pop),UVM_LOW)
        `uvm_info(get_type_name(),"------------------------------------",UVM_LOW)        
      end
	/*
      else if(mem_pkt.D_push) begin
        if(sc_mem[spi_pkt.D_push] == mem_pkt.rdata) begin
          `uvm_info(get_type_name(),$sformatf("------ :: READ DATA Match :: ------"),UVM_LOW)
          `uvm_info(get_type_name(),$sformatf("Addr: %0h",mem_pkt.addr),UVM_LOW)
          `uvm_info(get_type_name(),$sformatf("Expected Data: %0h Actual Data: %0h",sc_mem[mem_pkt.addr],mem_pkt.rdata),UVM_LOW)
          `uvm_info(get_type_name(),"------------------------------------",UVM_LOW)
        end
      end*/
    end
  endtask : run_phase
endclass : spi_scoreboard
