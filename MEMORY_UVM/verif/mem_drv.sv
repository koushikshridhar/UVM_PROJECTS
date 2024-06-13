class mem_drv extends uvm_driver#(mem_tx);
`uvm_component_utils(mem_drv);
virtual mem_intf vif;
`NEW_COMP

function void build_phase(uvm_phase phase);
string pif_name="mem_vif";
super.build_phase(phase);
if (!uvm_resource_db#(virtual mem_intf)::read_by_name("mem", pif_name, vif, this)) begin
	`uvm_error("RESOURCE_DB_ERROR", "Not able to retrive mem_vif handle from resource_db")
end
endfunction

task run_phase(uvm_phase phase);
	wait (vif.rst_i == 0);
	forever begin
		seq_item_port.get_next_item(req);
		req.print();
		drive_tx(req); //drive the AHB interface with this request
		seq_item_port.item_done();  //I am done with this item
	end
endtask

task drive_tx(mem_tx req);
	@(vif.bfm_cb);
    vif.bfm_cb.addr_i <= req.addr;
	vif.bfm_cb.wr_rd_i <= req.wr_rd;
	if(req.wr_rd == 1'b1) vif.bfm_cb.wdata_i <= req.data;
	vif.bfm_cb.valid_i <= 1'b1;
	wait(vif.bfm_cb.ready_o == 1'b1);
	//@(vif.bfm_cb);
    vif.bfm_cb.addr_i  <= 0; 
	vif.bfm_cb.wr_rd_i <= 0; 
	vif.bfm_cb.valid_i <= 0;
	vif.bfm_cb.wdata_i <= 0;
endtask
endclass

