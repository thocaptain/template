#define MAX_SIM 200
void set_random(Vtop *dut, vluint64_t sim_unit) {
			dut -> rst_ni = (sim_unit > 4);
			dut -> sel_i =rand()%8;
			dut -> wren =rand()%2;
			dut -> addr= rand()%8;
			dut -> wdata = 0x32920301;;
}
