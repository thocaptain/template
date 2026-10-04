`include "timescale.svh"
`include "tlib.svh"

`define RESETPERIOD 55
`define FINISH      10000

module tbench
  import top_pkg::*;
();

// Wave dumping
  initial begin : proc_dump_wave
    $dumpfile("wave.vcd");
    $dumpvars(0, dut);
  end

  logic              i_clk;
  logic              i_rst_n;
/* verilator lint_off UNUSEDSIGNAL */
  logic [DATA_W-1:0] o_data;
/* verilator lint_on UNUSEDSIGNAL */

  initial tsk_clock_gen(i_clk);
  initial tsk_reset(i_rst_n, `RESETPERIOD);
  initial tsk_timeout(`FINISH);

  top dut (
    .*
  );

endmodule
