class mem_env extends uvm_env;
`uvm_component_utils(mem_env);
mem_agent agent;
//mem_sbd sbd;
`NEW_COMP

function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	agent = mem_agent::type_id::create("agent", this);
	//sbd = mem_sbd::type_id::create("sbd", this);
endfunction

function void connect_phase(uvm_phase phase);
	//if (num_masters > 0) magentA[0].mon.ap_port.connect(sbd.imp_m0);
endfunction
function void end_of_elaboration_phase(uvm_phase phase);
	//top_sqr_i.apb_sqr_i = apb_agent_i.sqr;
	//for (int i = 0; i < mem_common::num_masters; i=i+1) begin
	//	top_sqr_i.mem_sqr_iA[i] = magentA[i].sqr;
	//end
endfunction


endclass
