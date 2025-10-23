`ifndef MAC_TO_AXI_SEQ_SVH
`define MAC_TO_AXI_SEQ_SVH

class mac_to_axi_seq extends uvm_sequence #(axis_item);
  `uvm_object_utils(mac_to_axi_seq)

  // Upstream sequencer providing MAC packets
  uvm_sequencer #(mac_seq_item) up_seqr;

  function new(string name="mac_to_axi_seq");
    super.new(name);
  endfunction

  virtual task body();
    mac_seq_item mac_pkt;
    axis_item    ax;
    byte         data_q[$];
    int          i, j;

    forever begin
      // 1. Get next MAC packet from upstream
      up_seqr.get_next_item(mac_pkt);

      // 2. Flatten MAC fields into byte stream
      data_q = {>>{ mac_pkt.dst_mac,
                    mac_pkt.src_mac,
                    {mac_pkt.vlan_id, mac_pkt.pcp, mac_pkt.dei},
                    mac_pkt.eth_type,
                    mac_pkt.payload,
                    mac_pkt.fcs }};

      // 3. Break into AXI beats (4 bytes per beat)
      for (i = 0; i < data_q.size(); i += 4) begin
        ax = axis_item::type_id::create("ax");
        start_item(ax);
        ax.tdata = 0;

        // pack 4 bytes big-endian
        for (j = 0; j < 4; j++) begin
          int idx = i + j;
          byte b = (idx < data_q.size()) ? data_q[idx] : 8'h00;
          ax.tdata = (ax.tdata << 8) | b;
        end

        // 4. tlast/tkeep
        ax.tlast = ((i + 4) >= data_q.size());
        if (ax.tlast)
          ax.tkeep = (1 << (data_q.size() - i)) - 1;
        else
          ax.tkeep = 4'b1111;

        finish_item(ax);
      end

      // 5. Mark upstream item done
      up_seqr.item_done();
    end
  endtask
endclass

`endif // MAC_TO_AXI_SEQ_SVH

