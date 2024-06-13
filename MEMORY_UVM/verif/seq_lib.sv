class mem_base_seq extends uvm_sequence#(mem_tx);
	`uvm_object_utils(mem_base_seq)

	bit dummy_var = 1;
	uvm_reg rg;
	mem_tx tx_t;
	`NEW_OBJ
	task pre_body();
		uvm_phase phase = get_starting_phase();
		if (phase != null) begin
			$display("Raising objection");
			phase.phase_done.set_drain_time(this, 100);
			phase.raise_objection(this);
		end
	endtask
	task post_body();
		uvm_phase phase = get_starting_phase();
		if (phase != null) begin
			$display("Drop objection");
			phase.drop_objection(this);
		end
	endtask
endclass


class mem_wr_rd_seq extends mem_base_seq; //mem_wr_rd_seq will be based on mem_tx
bit [31:0] wr_addr;
	`uvm_object_utils(mem_wr_rd_seq)
	`NEW_OBJ
	task body();
		repeat(1) begin
			`uvm_do_with(req, {req.wr_rd == 1;})  //write tx
			wr_addr = req.addr;
		end
		repeat(1) `uvm_do_with(req, {req.wr_rd == 0; req.addr == wr_addr;})  //read tx
	endtask
endclass


class mem_reg_wr_rd_seq extends mem_base_seq; //mem_wr_rd_seq will be based on mem_tx
uvm_reg mem_regs[$]; //Queue of uvm_reg
uvm_reg_data_t ref_data; //will be used for compare purpose
rand uvm_reg_data_t data; //will be used for compare purpose
uvm_reg_data_t miicommand_wr_data; //will be used for compare purpose
uvm_status_e status;

bit [31:0] addr;
uvm_reg reg_name;

`uvm_object_utils(mem_reg_wr_rd_seq)
`NEW_OBJ

task body();
	mem_block mem_block_h;
	uvm_reg_map maps;
	uvm_reg_map maps_t[$];

	//if(uvm_config_db#(mem_block)::get(null,"","mem_block_h",mem_block_h) != 0) begin
	//if(uvm_resource_db#(mem_block)::get_by_name("*","mem_block_h",mem_block_h) == null) begin
	if(uvm_resource_db#(mem_block)::read_by_type("RAL",mem_block_h,this) == 0) begin
		`uvm_fatal(get_name(), "could not get mem_block_h from uvm_config_db");
	end
	else begin
		`uvm_info(get_name(), "GOT mem_block_h from uvm_config_db",UVM_LOW);
  		mem_block_h.get_registers(mem_regs); //getting all register handles in mem_regs
		foreach(mem_regs[i]) begin
			$display("\t\tmem_regs[%0d] = %p",i,mem_regs[i]);
		end
  	mem_regs.shuffle();
  	foreach(mem_regs[i]) begin
  	    if(!this.randomize()) begin
  	      `uvm_error("body", "randomization error")
  	    end
  	    addr = mem_regs[i].get_address();
		$display("addr = %h  mem_regs[%0d] = %p",addr,i,mem_regs[i]);
  	    //reg_name = mem_block_h.regA_reg.get_name();
  	    reg_name = mem_block_h.get_reg_by_name("regA_reg");;
		$display("\nget_reg_by_name reg_name = %p",reg_name);
		//$display("\nget_full_name reg_name = %s",reg_name.get_full_name());
		//$display("\nget_name = %s",reg_name.get_name());
		//maps = mem_block_h.get_map_by_name("mem_map");
		mem_block_h.get_maps(maps_t);
		//$display("\nmaps = %p",maps);
  	    //mem_regs[i].write(status, data, .parent(this)); //performing write
  	    //mem_regs[i].write(status, data, .parent(this)); //performing write
  	    reg_name.write(status, data,.map(maps_t.pop_front()), .parent(this)); //performing write
  	    //reg_name.write(status, data, .parent(this)); //performing write
  	    	//uvm_reg_rw kind of object => adapter
		$display("\ncompleted one write to %s reg its status -> %s\n",reg_name.get_full_name,status);
		`uvm_info(get_full_name(),$sformatf("completed one write to %s reg its status -> %s",reg_name.get_full_name,status),UVM_NONE);
  	end
	end
endtask
endclass
