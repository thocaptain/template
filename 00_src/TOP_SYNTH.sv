// Top-level wrapper for FPGA synthesis (map board pins here)
module TOP_SYNTH (
  input  logic        CLOCK_50,
  input  logic [3:0]  KEY,
  output logic [17:0] LEDR
);

  logic [31:0] data;

  top u_top (
    .i_clk   (CLOCK_50),
    .i_rst_n (KEY[0]  ),
    .o_data  (data    )
  );

  assign LEDR = data[31:14];

endmodule
