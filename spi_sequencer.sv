//-------------------------------------------------------------------------
//						mem_sequencer - www.verificationguide.com
//-------------------------------------------------------------------------

class spi_sequencer extends uvm_sequencer#(spi_seq_item);

  `uvm_component_utils(spi_sequencer) 

  //---------------------------------------
  //constructor
  //---------------------------------------
  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction
  
endclass
