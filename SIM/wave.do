onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group VIF_0 /top/axi_vif0/drv_cb/tready
add wave -noupdate -expand -group VIF_0 /top/axi_vif0/drv_cb/tvalid
add wave -noupdate -expand -group VIF_0 /top/axi_vif0/drv_cb/tdata
add wave -noupdate -expand -group VIF_0 /top/axi_vif0/drv_cb/tstrb
add wave -noupdate -expand -group VIF_0 /top/axi_vif0/drv_cb/tkeep
add wave -noupdate -expand -group VIF_0 /top/axi_vif0/drv_cb/tlast
add wave -noupdate -expand -group VIF_0 /top/axi_vif0/drv_cb/tuser
add wave -noupdate -expand -group VIF_0 /top/axi_vif0/drv_cb/drv_cb_event
add wave -noupdate -expand -group VIF_1 /top/axi_vif1/drv_cb/tready
add wave -noupdate -expand -group VIF_1 /top/axi_vif1/drv_cb/tvalid
add wave -noupdate -expand -group VIF_1 /top/axi_vif1/drv_cb/tdata
add wave -noupdate -expand -group VIF_1 /top/axi_vif1/drv_cb/tstrb
add wave -noupdate -expand -group VIF_1 /top/axi_vif1/drv_cb/tkeep
add wave -noupdate -expand -group VIF_1 /top/axi_vif1/drv_cb/tlast
add wave -noupdate -expand -group VIF_1 /top/axi_vif1/drv_cb/tuser
add wave -noupdate -expand -group VIF_1 /top/axi_vif1/drv_cb/drv_cb_event
add wave -noupdate -expand -group VIF_2 /top/axi_vif2/drv_cb/tready
add wave -noupdate -expand -group VIF_2 /top/axi_vif2/drv_cb/tvalid
add wave -noupdate -expand -group VIF_2 /top/axi_vif2/drv_cb/tdata
add wave -noupdate -expand -group VIF_2 /top/axi_vif2/drv_cb/tstrb
add wave -noupdate -expand -group VIF_2 /top/axi_vif2/drv_cb/tkeep
add wave -noupdate -expand -group VIF_2 /top/axi_vif2/drv_cb/tlast
add wave -noupdate -expand -group VIF_2 /top/axi_vif2/drv_cb/tuser
add wave -noupdate -expand -group VIF_2 /top/axi_vif2/drv_cb/drv_cb_event
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {3512250 ps}
