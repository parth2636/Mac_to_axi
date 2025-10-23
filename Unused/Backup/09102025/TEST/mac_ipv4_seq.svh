`ifndef MAC_IPV4_SEQ_SVH
`define MAC_IPV4_SEQ_SVH
class mac_ipv4_seq extends mac_base_seq;
  `uvm_object_utils(mac_ipv4_seq)

  // Declare transaction handle
  mac_seq_item pkt;

  // Constructor
  function new(string name = "mac_ipv4_seq");
    super.new(name);
  endfunction

  // Body task
  virtual task body();
    repeat (2) begin
      pkt = mac_seq_item::type_id::create("pkt");

      start_item(pkt);
      $display("seq start");

     `uvm_info(get_type_name(), "Starting MAC minimum packet (randomized with fixed constraints)...", UVM_LOW)

    if (!pkt.randomize() with {
          // ----------- Fixed, deterministic values ------------
          dst_mac   == 48'h112233445566;
          src_mac   == 48'hAABBCCDDEEFF;
          vlan_id   == 0;
          pcp       == 0;
          dei       == 0;
          eth_type  == 16'h0800;   // IPv4

          // Minimum Ethernet payload size = 46 bytes
          payload.size() == 46;
          foreach (payload[i]) payload[i] == 8'hAA;

          fcs == 32'hDEADBEEF;
        })
    begin
      `uvm_error(get_type_name(), "Randomization failed for MAC sanity packet")
    end
      finish_item(pkt);
    end
  endtask

endclass : mac_ipv4_seq

`endif // MAC_IPV4_SEQ_SVH

