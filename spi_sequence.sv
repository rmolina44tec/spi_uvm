//-------------------------------------------------------------------------
//						mem_sequence's - www.verificationguide.com
//-------------------------------------------------------------------------

//=========================================================================
// mem_sequence - random stimulus 
//=========================================================================
class spi_sequence extends uvm_sequence#(spi_seq_item);
  
  `uvm_object_utils(spi_sequence)
  
  //--------------------------------------- 
  //Constructor
  //---------------------------------------
  function new(string name = "spi_sequence");
    super.new(name);
  endfunction
  
  `uvm_declare_p_sequencer(spi_sequencer)
  
  //---------------------------------------
  // create, randomize and send the item to driver
  //---------------------------------------
  virtual task body();
   repeat(2) begin
    req = spi_seq_item::type_id::create("req");
    wait_for_grant();
    req.randomize();
    send_request(req);
    wait_for_item_done();
   end 
  endtask
endclass
//=========================================================================

//=========================================================================
// Pop_sequence - "pop" type
//=========================================================================
class pop_sequence extends uvm_sequence#(spi_seq_item);
  
  `uvm_object_utils(spi_sequence)
   
  //--------------------------------------- 
  //Constructor
  //---------------------------------------
  function new(string name = "spi_sequence");
    super.new(name);
  endfunction
  
  virtual task body();
    `uvm_do_with(req,{req.pop==1;})
  endtask
endclass
//=========================================================================

//=========================================================================
// push_sequence - "push" type
//=========================================================================
class push_sequence extends uvm_sequence#(spi_seq_item);
  
  `uvm_object_utils(push_sequence)
   
  //--------------------------------------- 
  //Constructor
  //---------------------------------------
  function new(string name = "push_sequence");
    super.new(name);
  endfunction
  
  virtual task body();
    `uvm_do_with(req,{req.push==1;})
  endtask
endclass
//=========================================================================


//=========================================================================
