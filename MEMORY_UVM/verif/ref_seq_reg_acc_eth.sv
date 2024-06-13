class wb_reg_wr_rd_rm_seq extends wb_proc_base_seq;
uvm_reg mac_regs[$]; //Queue of uvm_reg
uvm_reg_data_t ref_data; //will be used for compare purpose
rand uvm_reg_data_t data; //will be used for compare purpose
uvm_reg_data_t miicommand_wr_data; //will be used for compare purpose
uvm_status_e status;

`uvm_object_utils(wb_reg_wr_rd_rm_seq)
`NEW_OBJ

task body;
  mac_reg_block reg_block;
  string reg_name;
  uvm_reg_addr_t addr;
  int errors; //used for couting errors
  super.body;
  uvm_resource_db#(mac_reg_block)::read_by_name("GLOBAL", "MAC_RM", reg_block, this);
  reg_block.get_registers(mac_regs); //getting all register handles in mac_regs
  	//mac_regs is a queue of '21 register handles'

  // Set errors to 0
  errors = 0;
//repeat(10) begin
  mac_regs.shuffle();
  foreach(mac_regs[i]) begin
      if(!this.randomize()) begin
        `uvm_error("body", "randomization error")
      end
	  //addr = mac_regs[i].get_address();
	  //if (addr == 32'hb) begin
	  //	data[0] = 0;
	  //end
	  //reg_name = mac_regs[i].get_name();
	  //if (reg_name == "miicommand") begin
	  //	data[0] = 0;
	  //end
	  //if (data[0] == 1) we should make sure that miistatus[1][2] both should be made 1
	  	//update the register model, so that miistatus[2:1] = 2'b11
	  reg_name = mac_regs[i].get_name();
	  if (reg_name == "miicommand") begin
		//data[1:0] = 2'b11;
	  	miicommand_wr_data = data;
		$display("writing data=%h to miicommand", miicommand_wr_data);
	  end
	  if (reg_name == "txbdnum") begin
	  	if (data > 8'h80) data = 8'h7F;
	  end
      mac_regs[i].write(status, data, .parent(this)); //performing write
	  	//uvm_reg_rw kind of object => adapter
  end
  //whenever miicommand_wr_data[0] is made 1 => nvalid_stat and busy_stat to go high
  if (miicommand_wr_data[0] == 1) begin
  	reg_block.miistatus.predict(3'b110); //updating the register model value for miistatus
		//this will update m_desired_value = 3'b110
  end
  mac_regs.shuffle();
  foreach(mac_regs[i]) begin
      ref_data = mac_regs[i].get(); //getting the value stored in register model
	  //gives us m_desired-value (always we predicted it)
      mac_regs[i].read(status, data, .parent(this)); //get the register value from DUT register
	  //design value will come(110), it will be compared ag
      if(ref_data != data) begin
        `uvm_error("REG_TEST_SEQ:", $sformatf("get/read: Read error for %s: Expected: %0h Actual: %0h", mac_regs[i].get_name(), ref_data, data))
		errors++;
      end
  end
//end //5 times repeat loop
endtask: body
endclass

