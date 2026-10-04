#include "tb_common.h"

static const vluint64_t MAX_CYCLES = 100;

int main(int argc, char **argv) {
  VerilatedFstC *vtrace;
  Vtop *dut = dut_init(argc, argv, &vtrace);

  printf("\nRunning tb_top (%llu cycles)\n", static_cast<unsigned long long>(MAX_CYCLES));

  while (sim_unit < MAX_CYCLES)
    dut_clock(dut, vtrace);

  // Counter starts after 2 reset cycles
  unsigned int expected = MAX_CYCLES - 2;
  unsigned int actual   = dut->o_data;

  if (actual != expected) {
    printf("  o_data = 0x%08X, expected 0x%08X\n", actual, expected);
    print_failed("tb_top");
    finish(dut, vtrace, false);
  }

  printf("  o_data = 0x%08X\n", actual);
  print_passed("tb_top");
  finish(dut, vtrace, true);
  return 0;
}
