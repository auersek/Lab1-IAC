#!/bin/bash

# Cleanup previous build artifacts
rm -rf obj_dir
rm -f sin.vcd

# Run Verilator for Verilog to C++, including C++ testbench and all required modules
verilator -Wall --cc --trace sigdelay.sv counter.sv ram.sv --exe sigdelay_tb.cpp

# Build the C++ code using the generated makefile
make -j -C obj_dir/ -f Vsigdelay.mk Vsigdelay

# Run the compiled Verilated model
obj_dir/Vsigdelay


# ls /dev/tty.u*

