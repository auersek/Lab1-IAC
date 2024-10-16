#!/bin/bash

#cleanup
rm -rf obj_dir
rm -f counter.vcd

# run verilator for verilog to c++, include c++ testbench
verilator -Wall --cc --trace counter.sv --exe counter_tb.cpp

# build c++ with verilator
make -j -C obj_dir/ -f Vcounter.mk Vcounter

obj_dir/Vcounter



