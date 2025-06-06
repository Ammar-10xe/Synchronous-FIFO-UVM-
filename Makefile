# Makefile for QuestaSim Simulation (Generic)

# Variables (can be overridden via command-line)
SRC      ?= test.sv
TOP      ?= tb
UCDB     ?= coverage.ucdb
TEXT_RPT ?= coverage_report.txt
HTML_DIR ?= html_report

# Targets

all: run

run: compile simulate

compile:
	vlib work
	vmap work work
	vlog $(SRC)

simulate:
	vsim -c $(TOP) -do "run -all; quit"

coverage: compile_cov simulate_cov report_txt report_html

compile_cov:
	vlib work
	vmap work work
	vlog -cover bcf +acc $(SRC)

simulate_cov:
	vsim -coverage -c $(TOP) -do "coverage save -onexit $(UCDB); run -all; quit"

report_txt:
	vcover report $(UCDB) -details -output $(TEXT_RPT)

report_html:
	vcover report $(UCDB) -html -output $(HTML_DIR)

clean:
	rm -rf work transcript *.log *.ucdb *.ini *.txt $(HTML_DIR)

