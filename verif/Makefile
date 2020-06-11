# Testbench name
TB = mips_processor_tb

# Simulation compiler
CC = iverilog
FLAGS = -Wall -g2012

# Simulator
VVP = vvp

# Waveform viewer
WAVE = gtkwave

# Library directory
LDIR = ../rtl

all: compile wave

compile: $(TB).sv $(LDIR)/*.sv
	$(CC) $(FLAGS) -o $(TB).vvp $(TB).sv $(LDIR)/*.sv
	$(VVP) $(TB).vvp > $(TB).log

wave:
	$(WAVE) waveform.vcd

.PHONY: clean

clean:
	rm -f $(TB).log $(TB).vvp waveform.vcd