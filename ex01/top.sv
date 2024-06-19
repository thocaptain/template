module top #(
  parameter DM_ADDRESS = 14
)(
  input logic clk_i,
  input logic rst_ni,
  input logic [2:0] sel_i,    
  input logic wren, // comes from control unit
  input logic [DM_ADDRESS-1:0] addr, // Read / Write address - 14 LSB bits of the ALU output
  input logic [31:0] wdata, // Write Data
  
  output logic [31:0] rdata // Read Data
);

data_memory dut(
  .clk_i(clk_i),
  .rst_ni(rst_ni),
  .sel_i(sel_i),
  .wren(wren),
  .addr(addr),
  .wdata(wdata),
  .rdata(rdata)  
);
 
endmodule : top





