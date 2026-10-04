module top
  import top_pkg::*;
(
  input  logic              i_clk,
  input  logic              i_rst_n,
  output logic [DATA_W-1:0] o_data
);

  always_ff @(posedge i_clk or negedge i_rst_n) begin
    if (!i_rst_n) o_data <= '0;
    else          o_data <= o_data + DATA_W'(1);
  end

endmodule
