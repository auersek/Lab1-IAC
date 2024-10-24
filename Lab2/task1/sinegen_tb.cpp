#include "Vsinegen.h"
#include "verilated.h"
#include "verilated_vcd_c.h"
#include "vbuddy.cpp"

int main(int argc, char **argv, char **env) {
    int i;
    int clk;

    Verilated::commandArgs(argc, argv);
    // init top verilog instance
    Vsinegen* sin = new Vsinegen;

    // init trace dump
    Verilated::traceEverOn(true);
    VerilatedVcdC* tfp = new VerilatedVcdC;
    sin->trace (tfp, 99);
    tfp->open ("sinegen.vcd");

    // init vbuddy
    if(vbdOpen()!=1) {
        return -1;
    }
    vbdHeader("Lab 2: Sinegen");

    // initialize simulation inputs
    sin->clk = 1;
    sin->rst = 0;
    sin->en = 1;
    sin->incr = 3;

    // run simulation for many clock cycles
    for (i = 0; i < 30000; i++) {

        // dump variables into VCD file and toggle clock
        for (clk = 0; clk < 2; clk++) {
            tfp->dump(2 * i + clk);
            sin->clk = !sin->clk;
            sin->eval();
        }

        sin->k = vbdValue();

        // sin->dout = vbdValue();
        vbdPlot(int(sin->dout), 0, 255);
        vbdCycle(i+1);

        if ((Verilated::gotFinish()) || (vbdGetkey()=='q')) 
        exit(0);   

        // Reset after 15 cycles
        sin->rst = (i == 15);

        if (Verilated::gotFinish()) exit(0);
    }

    vbdClose();
    tfp->close();
    exit(0);
}