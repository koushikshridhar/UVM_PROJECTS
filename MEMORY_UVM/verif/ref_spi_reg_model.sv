/*#############################################################################################
#                                                   					      #
#                                                   					      #
#############      Copyright (C) 2012-2017 VLSIGuru Training Institute        #################
#                                                   					      #
###### www.vlsiguru.com | contact@vlsiguru.com | +91-9986194191 | Horamavu, Bangalore  ########
#                                                   					      #
###### This Code is proprietery of VLSIGuru Training Institute. This code can't be reused #####
###### or distributed without prior consent from VLSIGuru Training Institute.           #######
#                                                   					      #
#                                                   					      #
##############################################################################################*/
// spi_reg_pkg
//----------------------------------------------------------------------
package spi_reg_pkg;

  import uvm_pkg::*;
  `include "uvm_macros.svh"

  /* DEFINE REGISTER CLASSES */

   //--------------------------------------------------------------------
   // rxtx0
   //--------------------------------------------------------------------
   class rxtx0 extends uvm_reg;
      `uvm_object_utils(rxtx0)

      rand uvm_reg_field F;

      //--------------------------------------------------------------------
      // new
      //--------------------------------------------------------------------
      function new(string name = "rxtx0");
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
   //--------------------------------------------------------------------
   // rxtx1
   //--------------------------------------------------------------------
   class rxtx1 extends uvm_reg;
      `uvm_object_utils(rxtx1)

      rand uvm_reg_field F;

      //--------------------------------------------------------------------
      // new
      //--------------------------------------------------------------------
      function new(string name = "rxtx1");
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
   //--------------------------------------------------------------------
   // divider
   //--------------------------------------------------------------------
   class divider extends uvm_reg;
      `uvm_object_utils(divider)

      rand uvm_reg_field ratio;  //ratio is same as divider value

      //--------------------------------------------------------------------
      // new
      //--------------------------------------------------------------------
      function new(string name = "divider");
         super.new(name, 16, UVM_NO_COVERAGE); //divider coverage is not implmeneted
      endfunction

      //--------------------------------------------------------------------
      // build
      //--------------------------------------------------------------------
      virtual function void build();
         ratio = uvm_reg_field::type_id::create("ratio");
         ratio.configure(this, 16, 0, "RW", 0, 16'hffff, 1, 1, 1);
      endfunction
   endclass
   //--------------------------------------------------------------------
   // ss
   //--------------------------------------------------------------------
   class ss extends uvm_reg;
      `uvm_object_utils(ss)  //slave select:

      rand uvm_reg_field cs;

      //have we accessed all Chip selects?
      covergroup cs_cov; //which all Chip selects have been accessed
        option.per_instance = 1;
        CS0: coverpoint cs.value[0];
        CS1: coverpoint cs.value[1];
        CS2: coverpoint cs.value[2];
        CS3: coverpoint cs.value[3];
        CS4: coverpoint cs.value[4];
        CS5: coverpoint cs.value[5];
        CS6: coverpoint cs.value[6];
        CS7: coverpoint cs.value[7];
      endgroup: cs_cov
      //--------------------------------------------------------------------
      // new
      //--------------------------------------------------------------------
      function new(string name = "ss");
         super.new(name, 8, build_coverage(UVM_CVR_FIELD_VALS));
         if(has_coverage(UVM_CVR_FIELD_VALS)) begin //is the test being run have UVM_CVR_FIELD_VALS also enabled?
           cs_cov = new;
           set_coverage(UVM_CVR_FIELD_VALS);
         end
      endfunction
      // sample - only called if this register is accessed
      function void sample(uvm_reg_data_t data,
                           uvm_reg_data_t byte_en,
                           bit            is_read,
                           uvm_reg_map    map);
        if(get_coverage(UVM_CVR_FIELD_VALS)) begin
          cs_cov.sample();
        end
      endfunction: sample

      // sample_values - this only gets called if this
      //                 regi
      function void sample_values();
        super.sample_values();
        $display("In sample_values coverage enable bit %0b", get_coverage(UVM_CVR_FIELD_VALS));
        if(get_coverage(UVM_CVR_FIELD_VALS))
          cs_cov.sample();
      endfunction: sample_values

      //--------------------------------------------------------------------
      // build
      //--------------------------------------------------------------------
      virtual function void build();
         cs = uvm_reg_field::type_id::create("cs");
         cs.configure(this, 8, 0, "RW", 0, 8'h00, 1, 1, 1); //8'h00 is coming from the spec.
      endfunction
   endclass
   //--------------------------------------------------------------------
   // rxtx2
   //--------------------------------------------------------------------
   class rxtx2 extends uvm_reg;
      `uvm_object_utils(rxtx2)

      rand uvm_reg_field F;

      //--------------------------------------------------------------------
      // new
      //--------------------------------------------------------------------
      function new(string name = "rxtx2");
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
   //--------------------------------------------------------------------
   // rxtx3
   //--------------------------------------------------------------------
   class rxtx3 extends uvm_reg;
      `uvm_object_utils(rxtx3)

      rand uvm_reg_field F;

      //--------------------------------------------------------------------
      // new
      //--------------------------------------------------------------------
      function new(string name = "rxtx3");
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
   //--------------------------------------------------------------------
   // ctrl
   //--------------------------------------------------------------------
   class ctrl extends uvm_reg;
      `uvm_object_utils(ctrl)

      uvm_reg_field reserved;
      rand uvm_reg_field ass;
      rand uvm_reg_field ie;
      rand uvm_reg_field lsb;
      rand uvm_reg_field tx_neg;
      rand uvm_reg_field rx_neg;
      rand uvm_reg_field go_bsy;
      uvm_reg_field reserved2;
      rand uvm_reg_field char_len;

      covergroup ass_cov; //which all Chip selects have been accessed
        option.per_instance = 1;
        ASS: coverpoint ass.value[0];
      endgroup: ass_cov

      covergroup ctrl_field_cg; //which all Chip selects have been accessed
        option.per_instance = 1;
        ASS: coverpoint ass.value[0];
        IE: coverpoint ie.value[0];
        LSB: coverpoint lsb.value[0];
        CHAR_LEN: coverpoint char_len.value[6:0] {
    		bins LENGTH[] = {0, 1, [31:33], [63:65], [95:97], 126, 127};
		}
		ASS_X_IE: cross ASS, IE;
		LSB_X_CHAR_LEN : cross LSB, CHAR_LEN;
      endgroup: ctrl_field_cg

      //--------------------------------------------------------------------
      // new
      //--------------------------------------------------------------------
      function new(string name = "ctrl");
         super.new(name, 14, build_coverage(UVM_CVR_FIELD_VALS));
         if(has_coverage(UVM_CVR_FIELD_VALS)) begin //is the test being run have UVM_CVR_FIELD_VALS also enabled?
           ass_cov = new;
           ctrl_field_cg = new;
           set_coverage(UVM_CVR_FIELD_VALS);
         end
      endfunction

      // sample - only called if this register is accessed
      function void sample(uvm_reg_data_t data,
                           uvm_reg_data_t byte_en,
                           bit            is_read,
                           uvm_reg_map    map);
        if(get_coverage(UVM_CVR_FIELD_VALS)) begin
          ass_cov.sample();
          ctrl_field_cg.sample();
        end
      endfunction: sample

      //--------------------------------------------------------------------
      // build
      //--------------------------------------------------------------------
      virtual function void build();
         ass = uvm_reg_field::type_id::create("ass");
         ie = uvm_reg_field::type_id::create("ie");
         lsb = uvm_reg_field::type_id::create("lsb");
         tx_neg = uvm_reg_field::type_id::create("tx_neg");
         rx_neg = uvm_reg_field::type_id::create("rx_neg");
         go_bsy = uvm_reg_field::type_id::create("go_bsy");
         reserved2 = uvm_reg_field::type_id::create("reserved2");
         char_len = uvm_reg_field::type_id::create("char_len");

         ass.configure(this, 1, 13, "RW", 0, 1'b0, 1, 1, 0);
         ie.configure(this, 1, 12, "RW", 0, 1'b0, 1, 1, 0);
         lsb.configure(this, 1, 11, "RW", 0, 1'b0, 1, 1, 0);
         tx_neg.configure(this, 1, 10, "RW", 0, 1'b0, 1, 1, 0);
         rx_neg.configure(this, 1, 9, "RW", 0, 1'b0, 1, 1, 0);
         go_bsy.configure(this, 1, 8, "RW", 0, 1'b0, 1, 1, 0);
         //go_bsy.configure(this, 1, 8, "WO", 0, 1'b0, 1, 1, 0); //WO will ensure that, this specific bit testing gets skipped in bit bash test
         reserved2.configure(this, 1, 7, "RW", 0, 1'b0, 1, 0, 0);
         char_len.configure(this, 7, 0, "RW", 0, 7'b0000000, 1, 1, 0);


      endfunction
   endclass
   //All register definitions are completed


  //
  // This is a register access covergroup within a wrapper class
  //
  // This will need to be called by the block sample method
  //
  // One will be needed per map
  //
  class SPI_APB_reg_access_wrapper extends uvm_object;

  `uvm_object_utils(SPI_APB_reg_access_wrapper)

  covergroup ra_cov(string name) with function sample(uvm_reg_addr_t addr, bit is_read);

  option.per_instance = 1;
  option.name = name;

  // To be generated:
  //
  // Generic form for bins is:
  //
  // bins reg_name = {reg_addr};
  ADDR: coverpoint addr {
    bins rxtx0 = {'h0};
    bins rxtx1 = {'h4};
    bins rxtx2 = {'h8};
    bins rxtx3 = {'hc};
    bins ctrl = {'h10};
    bins divider = {'h14};
    bins ss = {'h18};
  }

  // Standard code - always the same
  RW: coverpoint is_read {
    bins RD = {1};
    bins WR = {0};
  }

  // To be generated:
  //
  // Generic form for the ignore bins is:
  //
  // ignore_bins write_only = binsof(ADDR) intersect {write_only_addr, write_only_addr ...} && binsof(RW) intersect {1};
  // ignore_bins read_only = binsof(ADDR) intersect {read_only_addr, read_only_addr ...} && binsof(RW) intersect {0};
  ACCESS: cross ADDR, RW;
  //ACCESS: cross ADDR, RW {
  //	option.weight = 3;
  //}

  endgroup: ra_cov

  function new(string name = "SPI_APB_reg_access_wrapper");
    ra_cov = new(name);
  endfunction

  function void sample(uvm_reg_addr_t offset, bit is_read);
    ra_cov.sample(offset, is_read);
  endfunction: sample

endclass: SPI_APB_reg_access_wrapper



  /* REGISTER MAP */
   //-------------------------------------------------------------------
   // spi_reg_block
   //--------------------------------------------------------------------
   class spi_reg_block extends uvm_reg_block;
      `uvm_object_utils(spi_reg_block)

      rand rxtx0 rxtx0_reg;
      rand rxtx1 rxtx1_reg;
      rand rxtx2 rxtx2_reg;
      rand rxtx3 rxtx3_reg;
      rand ctrl ctrl_reg;
      rand divider divider_reg;
      rand ss ss_reg;

      uvm_reg_map APB_map; // Block map => SPI Controller has APB interface, this interface will be sued for programming the regsiters

      // Wrapped APB register access covergroup
      SPI_APB_reg_access_wrapper SPI_APB_access_cg;

      //--------------------------------------------------------------------
      // new
      //--------------------------------------------------------------------
      function new(string name = "spi_reg_block");
         super.new(name, build_coverage(UVM_CVR_ADDR_MAP)); //during the test run, if user did not enable ADDR_MAP coverage
      endfunction

      //--------------------------------------------------------------------
      // build
      //--------------------------------------------------------------------
      virtual function void build(); //don't confuse this with build_phase, both are diffetent
         string s;

         if(has_coverage(UVM_CVR_ADDR_MAP)) begin //did user enable ADDR_MAP during test case build_phase ? by calling include_coverage(UVM_CVR_ADDR_MAP)
           SPI_APB_access_cg = SPI_APB_reg_access_wrapper::type_id::create("SPI_APB_access_cg");
           set_coverage(UVM_CVR_ADDR_MAP);
         end
		 //if (get_coverage(UVM_CVR_ADDR_MAP)) begin
		 //	$display("Coverage is enabeld for UVM_CVR_ADDR_MAP");
		 //end

	 //rxtx0, rxtx1, rxtx2, rxtx3 are stored in rx[127:0] register declarion in design

         rxtx0_reg = rxtx0::type_id::create("rxtx0");
         rxtx0_reg.configure(this, null, "");
         rxtx0_reg.build();	 
         for(int i = 0; i < 32; i++) begin
           $sformat(s, "rx[%0d]", i);
           rxtx0_reg.add_hdl_path_slice(s, i, 1);
         end

         rxtx1_reg = rxtx1::type_id::create("rxtx1");
         rxtx1_reg.configure(this, null, "");
         rxtx1_reg.build();	 
         for(int i = 32; i < 64; i++) begin
           $sformat(s, "rx[%0d]", i);
           rxtx1_reg.add_hdl_path_slice(s, i-32, 1);
         end

         rxtx2_reg = rxtx2::type_id::create("rxtx2");
         rxtx2_reg.configure(this, null, "");
         rxtx2_reg.build();	 
         for(int i = 64; i < 96; i++) begin
           $sformat(s, "rx[%0d]", i);
           rxtx2_reg.add_hdl_path_slice(s, i-64, 1);
         end

         rxtx3_reg = rxtx3::type_id::create("rxtx3");
         rxtx3_reg.configure(this, null, "");
         rxtx3_reg.build();	 
         for(int i = 96; i < 128; i++) begin
           $sformat(s, "rx[%0d]", i);
           rxtx3_reg.add_hdl_path_slice(s, i-96, 1);
         end

         ctrl_reg = ctrl::type_id::create("ctrl");
         ctrl_reg.configure(this, null, "");
         ctrl_reg.build();	 
         ctrl_reg.add_hdl_path_slice("ctrl", 0, 14);

         divider_reg = divider::type_id::create("divider");
         divider_reg.configure(this, null, "");
         divider_reg.build();	 
         divider_reg.add_hdl_path_slice("divider", 0, 16);  //top_tb.DUT.divider

         ss_reg = ss::type_id::create("ss");
         ss_reg.configure(this, null, "");
         ss_reg.build();	 
         ss_reg.add_hdl_path_slice("ss", 0, 8);   //top_tb.DUT.ss

         APB_map = create_map("APB_map", 'h0, 4, UVM_LITTLE_ENDIAN);
         APB_map.add_reg(rxtx0_reg, 32'h00000000, "RW");
         APB_map.add_reg(rxtx1_reg, 32'h00000004, "RW");
         APB_map.add_reg(rxtx2_reg, 32'h00000008, "RW");
         APB_map.add_reg(rxtx3_reg, 32'h0000000c, "RW");
         APB_map.add_reg(ctrl_reg, 32'h00000010, "RW");
         APB_map.add_reg(divider_reg, 32'h00000014, "RW");
         APB_map.add_reg(ss_reg, 32'h00000018, "RW");
         add_hdl_path("top_tb.DUT", "RTL");
		 //overall hierarchy of divider: top_tb.DUT.divider = 100 => divider register gets updated with 100 value
         lock_model(); //once lock is done, no changes permitted after that.
      endfunction

      function void sample(uvm_reg_addr_t offset, bit is_read, uvm_reg_map  map);
        if(get_coverage(UVM_CVR_ADDR_MAP)) begin
          if(map.get_name() == "APB_map") begin
            SPI_APB_access_cg.sample(offset, is_read);
          end
        end
      endfunction: sample
   endclass
endpackage

