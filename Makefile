# The files
FILES		= src/adder.vhdl \
                src/alu.vhdl \
                src/and8.vhdl \
                src/negate.vhdl \
                src/not8.vhdl \
                src/or8.vhdl \
                src/xor8.vhdl
SIMDIR		= sim
SIMFILES	= test/alu_tb.vhdl

# GHDL
GHDL_CMD	= ghdl
GHDL_FLAGS	= --ieee=synopsys --warn-no-vital-generic
GHDL_WORKDIR = --workdir=sim --work=work
GHDL_STOP	= --stop-time=40ns

# The commands
all:
	make compile
	make run

compile:
	mkdir -p sim
	ghdl -a $(GHDL_FLAGS) $(GHDL_WORKDIR) $(FILES)
	ghdl -a $(GHDL_FLAGS) $(GHDL_WORKDIR) $(SIMFILES)
	ghdl -e $(GHDL_FLAGS) $(GHDL_WORKDIR) alu_tb

run:
	ghdl -r $(GHDL_FLAGS) $(GHDL_WORKDIR) alu_tb

clean:
	$(GHDL_CMD) --clean --workdir=sim
