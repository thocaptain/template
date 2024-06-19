module data_memory #(
  parameter DM_ADDRESS = 14,
  parameter DATA_W = 8
)(
  input logic clk_i,
  input logic rst_ni,
  input logic [2:0] sel_i,    
  input logic wren, // comes from control unit
  input logic [DM_ADDRESS-1:0] addr, // Read / Write address - 9 LSB bits of the ALU output
  input logic [31:0] wdata, // Write Data
  
  output logic [31:0] rdata // Read Data
);
      
  logic [DATA_W-1:0] mem [(2**DM_ADDRESS)-1:0];
  //integer j;     
  always_ff @(posedge clk_i) begin
    if(!rst_ni) begin
      //for (j=0; j < (2**DM_ADDRESS); j=j+1)
        //mem[j] <= 8'b0;
      mem[0] <= 0;
      end
    else 
      if (wren == 1) begin
        if(sel_i == 3'b000)    //sw
          begin
           mem[addr] <= wdata[7:0];
           mem[addr+1] <= wdata[15:8];
           mem[addr+2] <= wdata[23:16];
           mem[addr+3] <= wdata[31:24];
          end
        else if(sel_i == 3'b001)	//sb
          mem[addr] <= wdata[7:0];
        else if(sel_i == 3'b010)    //sh
          begin
            mem[addr] <= wdata[7:0];
            mem[addr+1] <= wdata[15:8];            
          end                
      end
  end
  
  always_comb begin 
    //lw
    rdata = {mem[addr+3],mem[addr+2],mem[addr+1],mem[addr]};
    //lbu
    if(sel_i == 3'b100) 
       rdata = {24'b0,mem[addr]};
    //lhu
    else if(sel_i == 3'b101)
       rdata = {16'b0,mem[addr+1],mem[addr]};
    //lb
    else if(sel_i == 3'b110)
      begin
        if (mem[addr][7]==1'b1)
           rdata = {-24'b1,mem[addr]};
        else 
           rdata = {24'b0,mem[addr]};
      end
    //lh
    else if(sel_i == 3'b111)
      begin
        if (mem[addr+1][7]==1'b1)
           rdata = {-16'b1,mem[addr+1],mem[addr]};
        else 
           rdata = {16'b0,mem[addr+1],mem[addr]};
      end
  end

  
      
endmodule : data_memory
  
