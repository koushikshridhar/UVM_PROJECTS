class mem_adapter extends uvm_reg_adapter;
  `uvm_object_utils(mem_adapter)
   function new(string name = "mem_adapter");
      super.new(name);
   endfunction

  virtual function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);
    mem_tx mem_tx_h = mem_tx::type_id::create("mem_tx_h");
    mem_tx_h.wr_rd = (rw.kind == UVM_READ) ? 0 : 1;
    mem_tx_h.addr = rw.addr; //address taken from wb_map
    mem_tx_h.data = rw.data;
    return mem_tx_h;
  endfunction: reg2bus

  virtual function void bus2reg(uvm_sequence_item bus_item,
                                ref uvm_reg_bus_op rw);
    mem_tx mem_tx_h;
    if (!$cast(mem_tx_h, bus_item)) begin
      `uvm_fatal("NOT_MEM_TX_TYPE","Provided bus_item not correct type")
      return;
    end
    rw.kind = mem_tx_h.wr_rd ? UVM_WRITE : UVM_READ;
    rw.addr = mem_tx_h.addr;
    rw.data = mem_tx_h.data;
    rw.status = UVM_IS_OK;
  endfunction: bus2reg
endclass: mem_adapter

