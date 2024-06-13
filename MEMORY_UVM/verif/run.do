vlog \
+incdir+D:/personal/UVM/MEMORY_UVM/design\
+incdir+D:/personal/UVM/0.UVM_SRC/uvm-1.2/src\
list.svh 
vsim -assertdebug -novopt -suppress 12110 top -sv_lib C:/questasim64_10.7c/uvm-1.2/win64/uvm_dpi +UVM_TESTNAME=mem_reg_wr_rd_test -l run.log +UVM_TIMEOUT=500000 +UVM_VERBOSITY=UVM_MEDIUM
#add wave -position insertpoint sim:/top/dut/*
do wave.do
run -all

