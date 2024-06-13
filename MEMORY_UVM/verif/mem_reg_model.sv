class regA extends uvm_reg;
`uvm_object_utils(regA)

rand uvm_reg_field F;

function new(string name = "regA");
       super.new(name, 32, UVM_NO_COVERAGE);
endfunction

//--------------------------------------------------------------------
// build
//--------------------------------------------------------------------
virtual function void build();
   F = uvm_reg_field::type_id::create("F");
   F.configure(this, 32, 0, "RW", 1, 32'h00000000, 1, 1, 0);
endfunction


endclass


class mem_block extends uvm_reg_block;
`uvm_object_utils(mem_block)

rand regA regA_reg;

uvm_reg_map mem_map;

function new(string name = "mem_block");
   super.new(name, build_coverage(UVM_CVR_ADDR_MAP)); //during the test run, if user did not enable ADDR_MAP coverage
endfunction

virtual function void build(); //don't confuse this with build_phase, both are diffetent
   string s;


   regA_reg = regA::type_id::create("regA_reg");
   regA_reg.configure(this, null, "");
   regA_reg.build();	 
   regA_reg.add_hdl_path_slice("regA", 0,32);


   mem_map = create_map("mem_map", 'h0, 4, UVM_LITTLE_ENDIAN);
   mem_map.add_reg(regA_reg, 32'h5, "RW");//32'h5 is the address location of regA in DUT
   add_hdl_path("top.dut", "RTL");
   lock_model(); //once lock is done, no changes permitted after that.
endfunction
endclass
