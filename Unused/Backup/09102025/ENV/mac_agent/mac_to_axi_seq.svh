`ifndef MAC_TO_AXI_SEQ_SVH
`define MAC_TO_AXI_SEQ_SVH

class mac_to_axi_seq extends axi_str_mas_base_sequence #(32,32) ;


  `uvm_object_utils(mac_to_axi_seq)

  // Handle to upstream sequencer providing MAC packets
  uvm_sequencer #(mac_seq_item) up_seqr;

  // Sequence items
  axi_str_mas_seq_item #(32,32) req;
  mac_seq_item mac_pkt;

  // data queue to hold flattened packet data which same size of tdata data size 
  bit [31:0] data_q[$]; 



 function new(string name = "mac_to_axi_seq");
    super.new(name);
  endfunction : new


 virtual task body();
    mac_pkt = mac_seq_item::type_id::create("mac_pkt");

    forever begin
      // 1. Get MAC packet from upstream sequencer
      up_seqr.get_next_item(mac_pkt);
      mac_pkt.print();

      // 2. Create AXI Stream transaction
      `uvm_create(req)
       req.print();
      $display("req after create");
      start_item(req);
      $display("req after start");


      // 3. Convert MAC fields to data bytes
      convert_mac_to_data();
      $display("after convert");
        req.data_rand.constraint_mode(0);
      // 4. Randomize AXI request with constraints
      if (!req.randomize() with {
            total_bytes == data_q.size()*(DATA_SIZE / 8);
            foreach (data_q[i]) { tdata_q[i] == data_q[i]; }
          })
        `uvm_error(get_full_name(), "AXI STREAM RANDOMIZATION FAILED")
       $display("after rendomize");
      `uvm_info("MAC_TO_AXI_SEQ", $sformatf("MAC size=%0d | data_q size=%0d | tdata_q size=%0d",data_q.size(), data_q.size(), req.tdata_q.size()), UVM_LOW)
       $display("afte info");

      finish_item(req);
      up_seqr.item_done();
    end
  endtask : body


  // ---------------------------------------------------------
  // Conversion from MAC packet to byte data
  // ---------------------------------------------------------
  function void convert_mac_to_data();
    // Flatten fields in same order as packet structure
    data_q = {>>{
                mac_pkt.dst_mac,
                mac_pkt.src_mac,
                {mac_pkt.vlan_id, mac_pkt.pcp, mac_pkt.dei},
                mac_pkt.eth_type,
                mac_pkt.payload,
                mac_pkt.fcs
              }};

    foreach (data_q[i])
      `uvm_info("MAC_TO_AXI_SEQ",
                $sformatf("actual data_q[%0d] = %h", i, data_q[i]),
                UVM_DEBUG)
  endfunction : convert_mac_to_data
endclass : mac_to_axi_seq

`endif // MAC_TO_AXI_SEQ_SVH


  
