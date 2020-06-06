#!/bin/bash

# Compile
iverilog \
    -g2012 \
    -o instr_mem_tb.vvp \
    instr_mem_tb.sv \
    ../../rtl/instr_mem.sv

# Simulate
vvp instr_mem_tb.vvp > instr_mem_tb.log