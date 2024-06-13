onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /top/dut/clk_i
add wave -noupdate /top/dut/rst_i
add wave -noupdate /top/dut/addr_i
add wave -noupdate /top/dut/wdata_i
add wave -noupdate /top/dut/rdata_o
add wave -noupdate /top/dut/wr_rd_i
add wave -noupdate /top/dut/valid_i
add wave -noupdate /top/dut/ready_o
add wave -noupdate /top/dut/regA
add wave -noupdate /top/dut/i
add wave -noupdate -expand -subitemconfig {/top/mem_pif/assert__0_THREAD_MONITOR.count -expand} /top/mem_pif/assert__0
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {23 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 235
configure wave -valuecolwidth 116
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {100 ns}
