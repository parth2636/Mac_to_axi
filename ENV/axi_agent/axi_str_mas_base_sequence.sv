/* -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.

* File Name : axi_str_mas_base_sequence.sv

* Purpose : give inputs according to testcase

* Creation Date : 06-05-2024

* Last Modified :

* Created By :  

_._._._._._._._._._._._._._._._._._._._._.*/


`ifndef AXI_STR_MAS_BASE_SEQUENCE_SV
`define AXI_STR_MAS_BASE_SEQUENCE_SV

class axi_str_mas_base_sequence #(shortint DATA_SIZE=32,int USER_SIZE=32) extends uvm_sequence #(axi_str_mas_seq_item #(DATA_SIZE,USER_SIZE)); 
 
  `uvm_object_param_utils(axi_str_mas_base_sequence #(DATA_SIZE,USER_SIZE)) 
   
   axi_str_mas_seq_item #(DATA_SIZE,USER_SIZE) req;
      //-------------------------------------------------------------------------------- 
     // Method : 
      
       // Arguments : 
        
         // Description : 
          
           //--------------------------------------------------------------------------------- 
   function new (string name="axi_str_mas_base_sequence"); 
      super.new(name); 
   endfunction: new 

   
   /*task body();
    //write transfer
    `uvm_do_with(req, {total_bytes == 32;no_of_bytes==8;});
    `uvm_do_with(req, {total_bytes == 64;no_of_bytes==8;});
    /*`uvm_create(req);
    start_item(req);
    $display($time," : start sequence start"); 
    if(!req.randomize() with {total_bytes == 128;no_of_bytes == 32;})
      $display($time," : randomize failed");
    finish_item(req);
    $display($time," :finish sequence start ");

    #20;
   endtask : body*/

   task body();
    //write transfer
     `uvm_do_with(req, {total_bytes == 18;});
    `uvm_do_with(req, {total_bytes == 33;});
    `uvm_do_with(req, {total_bytes == 66;})

    #20;
   endtask : body
   //function void response_handler(uvm_sequence_item response);
   //endfunction : response_handler

endclass : axi_str_mas_base_sequence

`endif
