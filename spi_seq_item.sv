//-------------------------------------------------------------------------
//						mem_seq_item - www.verificationguide.com 
//-------------------------------------------------------------------------

class spi_seq_item extends uvm_sequence_item;
  //---------------------------------------
  //data and control fields
  //---------------------------------------
  rand bit 	 CLK;
  rand bit       reset;
  rand bit       pndgn;
  rand bit [8'd65-1:0] D_pop;
  rand bit 	 MISO;
       bit 	 pop;
        bit [8'd65-1:0] D_push;
	bit	 push;
	bit 	 MOSI;
	bit 	 SCLK;
	bit	 SCS;
  
  //---------------------------------------
  //Utility and Field macros
  //---------------------------------------
  `uvm_object_utils_begin(spi_seq_item)
    `uvm_field_int(pndgn,UVM_ALL_ON)
    `uvm_field_int(D_pop,UVM_ALL_ON)
    `uvm_field_int(MISO,UVM_ALL_ON)
    `uvm_field_int(pop,UVM_ALL_ON)
    `uvm_field_int(D_push,UVM_ALL_ON)
    `uvm_field_int(push,UVM_ALL_ON)
    `uvm_field_int(MOSI,UVM_ALL_ON)
    `uvm_field_int(SCLK,UVM_ALL_ON)
    `uvm_field_int(SCS,UVM_ALL_ON)
  `uvm_object_utils_end
  
  //---------------------------------------
  //Constructor
  //---------------------------------------
  function new(string name = "spi_seq_item");
    super.new(name);
  endfunction
  
  //---------------------------------------
  //constaint, to generate any one among write and read
  //---------------------------------------
  //constraint pop_c { pop != push; }; 
  
endclass
