# Makefile to compile and run UVM testbench with Questa

# Config
SIM = questa
TEST_NAME ?= mem_wr_rd_test
TOP_MODULE = tb_top
FLIST = flist.svh
LOG_DIR = logs

# Compiler & Simulator settings for Questa
ifeq ($(SIM), questa)
	BUILD_CMD   = vlog
	SIM_CMD     = vsim
	BUILD_OPTS  = -sv -timescale=1ns/1ps
	BUILD_OPTS += -work work -l $(LOG_DIR)/compile.log

	SIM_OPTS    = -c -voptargs=+acc
	SIM_OPTS   += -lib work $(TOP_MODULE)
	SIM_OPTS   += +UVM_TESTNAME=$(TEST_NAME)
	SIM_OPTS   += -l $(LOG_DIR)/sim.log
	SIM_OPTS   += -do "run -all; quit -f"
endif

# Checks
check:
	@if [ ! -f $(FLIST) ]; then \
		echo "❌ ERROR: '$(FLIST)' not found. It must be named exactly 'flist.svh'."; \
		exit 1; \
	fi

check_top_module:
	@echo "🔎 Verifying top module '$(TOP_MODULE)' exists in source files..."
	@grep -r "module[[:space:]]\+$(TOP_MODULE)\b" . --include=\*.sv > /dev/null || \
	{ echo "❌ ERROR: Top module '$(TOP_MODULE)' not found in source files."; exit 1; }

# Targets
build: check | $(LOG_DIR)
	@echo "🚧 Compiling..."
	$(BUILD_CMD) $(BUILD_OPTS) +incdir+. $(FLIST)

	$(MAKE) check_top_module

run: build
	@echo "🎬 Simulating..."
	$(SIM_CMD) $(SIM_OPTS)

clean:
	@echo "🧹 Cleaning up..."
	rm -rf work $(LOG_DIR) transcript *.wlf *.vcd

$(LOG_DIR):
	mkdir -p $(LOG_DIR)

all: clean build run
