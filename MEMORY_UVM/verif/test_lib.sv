class mem_base_test extends uvm_test;
mem_env env;
`uvm_component_utils(mem_base_test)
`NEW_COMP
mem_block mem_block_h;
mem_adapter mem_adapter_h;

function void build_phase(uvm_phase phase);
	`uvm_info("MEM_UVC", "Test: Build_phase", UVM_NONE)

	mem_block_h = new("mem_block_h");

	mem_block_h.build();
	mem_block_h.default_map.set_auto_predict(1);
	mem_block_h.default_map.set_base_addr(0);
	mem_block_h.lock_model();
	mem_block_h.reset();
	//uvm_config_db#(mem_block)::set(null,"*","mem_block_h",mem_block_h);
	uvm_resource_db#(mem_block)::set("*","mem_block_h",mem_block_h);

	env = mem_env::type_id::create("env", this);
endfunction

function void connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	mem_adapter_h= mem_adapter::type_id::create("mem_adapter_h", this);
	mem_block_h.mem_map.set_sequencer(env.agent.sqr, mem_adapter_h);
endfunction

function void end_of_elaboration_phase(uvm_phase phase);
	`uvm_info("TB HIERARCHY", this.sprint(), UVM_NONE)
endfunction

//function void report_phase(uvm_phase phase);
//endfunction


endclass

class mem_wr_rd_test extends mem_base_test;
	`uvm_component_utils(mem_wr_rd_test)

	`NEW_COMP
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction

	task run_phase(uvm_phase phase);
		mem_wr_rd_seq wr_rd_seq;
		wr_rd_seq = mem_wr_rd_seq::type_id::create("wr_rd_seq");
		phase.phase_done.set_drain_time(this, 100);
		phase.raise_objection(this);
		wr_rd_seq.start(env.agent.sqr);
		phase.drop_objection(this);
	endtask
endclass

class mem_reg_wr_rd_test extends mem_base_test;
	`uvm_component_utils(mem_reg_wr_rd_test)

	`NEW_COMP
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction

	task run_phase(uvm_phase phase);
		mem_reg_wr_rd_seq reg_wr_rd_seq;
		reg_wr_rd_seq = mem_reg_wr_rd_seq::type_id::create("reg_wr_rd_seq");
		phase.phase_done.set_drain_time(this, 100);
		phase.raise_objection(this);
		reg_wr_rd_seq.start(env.agent.sqr);
		phase.drop_objection(this);
	endtask
endclass

