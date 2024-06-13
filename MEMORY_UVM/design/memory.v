module memory(clk_i, rst_i, addr_i, wdata_i, rdata_o, wr_rd_i, valid_i, ready_o);
//1kb
//input and outputs
input clk_i, rst_i;
input [`ADDR_WIDTH-1:0] addr_i; //size of vector? how many bits required to access memory locations
input [`WIDTH-1:0] wdata_i;
output reg [`WIDTH-1:0] rdata_o;
input wr_rd_i, valid_i;
output reg ready_o;

reg [31:0] regA;//register declaration

//1kb memory, 16 bit width
reg [`WIDTH-1:0] mem[`DEPTH-1:0]; //64*16 =1024bits = 1kb
integer i;

always @(posedge clk_i) begin //==> Verilog
if (rst_i == 1) begin
	for (i = 0; i < `DEPTH; i=i+1) mem[i] = 0;
	rdata_o = 0;
	ready_o = 0;
end
else begin
	if (valid_i == 1) begin
		ready_o = 1;
		if (wr_rd_i == 1) begin
			if(addr_i == 5) begin
				regA = wdata_i;
				$display("DESIGN WRITE\t\taddr=%h,wdata=%h",addr_i,wdata_i);
			end
			else begin
				mem[addr_i] = wdata_i;
				$display("DESIGN WRITE\t\taddr=%h,wdata=%h",addr_i,wdata_i);
			end
		end
		else begin
			if(addr_i == 5) begin
				rdata_o = regA;
			end
			else begin
				rdata_o = mem[addr_i];
				//$display("READ\t\taddr=%h,rdata=%h",addr_i,rdata_o);
			end
		end
	end
	else begin
		ready_o = 0;
	end
end
end
endmodule

