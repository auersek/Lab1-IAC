#!/bin/bash

# Cleanup previous build artifacts
rm -rf obj_dir
rm -f sin.vcd

# Run Verilator for Verilog to C++, including C++ testbench and all required modules
verilator -Wall --cc --trace sinegen.sv counter.sv rom.sv clkdiv.sv --exe sinegen_tb.cpp

# Build the C++ code using the generated makefile
make -j -C obj_dir/ -f Vsinegen.mk Vsinegen

# Run the compiled Verilated model
obj_dir/Vsinegen


# ls /dev/tty.u*

