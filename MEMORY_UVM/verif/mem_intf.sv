interface mem_intf(input logic clk_i,rst_i);
logic [`ADDR_WIDTH-1:0] addr_i; 
logic [`WIDTH-1:0] wdata_i;
logic [`WIDTH-1:0] rdata_o;
logic wr_rd_i, valid_i;
logic ready_o;

clocking bfm_cb@(posedge clk_i);
	default input #0 output #2;
	output addr_i; 
	output wdata_i;
	output #1 wr_rd_i; 
	output #1 valid_i;
	input ready_o;
	input rdata_o;
endclocking

clocking mon_cb@(posedge clk_i);
	default input #1 output #0;
	input  addr_i; 
	input  wdata_i;
	input rdata_o;
	input  wr_rd_i; 
	input  valid_i;
	input ready_o;
endclocking

//modport bfm_mp(clocking bfm_cb);
//modport mon_mp(clocking mon_cb);
sequence valid_ready_check_S();
	(
		(wdata_i == 0) || 
		(addr_i == 0)
	);
endsequence:valid_ready_check_S

assert property(
	@(posedge clk_i) (rst_i == 1) |-> valid_ready_check_S
)
else 
	//`uvm_info("valid_ready_check_S","FAILED",UVM_NONE);
	`uvm_info("valid_ready_check_S","FAILED",UVM_NONE);

endinterface

