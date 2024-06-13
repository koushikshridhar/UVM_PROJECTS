module top;
//1.clk and reset declaration
reg clk,rst;
//2. interface instantiation as pif
mem_intf mem_pif(clk,rst);
//3. assertion instantaion

//4. clk and rst generation
initial begin
	clk = 0;
	forever #5 clk = ~clk;
end

initial begin
	rst = 1;
	#15;
	rst = 0;
end
// . dut instantiation
memory dut(
			.clk_i(mem_pif.clk_i), 
			.rst_i(mem_pif.rst_i), 
			.addr_i(mem_pif.addr_i), 
			.wdata_i(mem_pif.wdata_i), 
			.rdata_o(mem_pif.rdata_o), 
			.wr_rd_i(mem_pif.wr_rd_i), 
			.valid_i(mem_pif.valid_i), 
			.ready_o(mem_pif.ready_o)
			);


//5. call the run_test of uvm
initial begin
	//run_test("mem_base_test");
	//run_test("mem_wr_rd_test");
	run_test("mem_reg_wr_rd_test");
end

//6. set the interface handle in resource db
initial begin
	uvm_resource_db#(virtual mem_intf)::set("mem", "mem_vif", mem_pif, null); //now mem_pif will accessible everywhere in TB
end
endmodule
