# Synchronous-FIFO-UVM-
UVM Testbench for synchronus fifo

I have written a testbench for synchronous fifo in which I'm running my testbench starting from fifo being empty then I have written data into it until the fifo is full, then I have read from it until fifo is empty again, while reading I have compared whether the data which I'm reading is same as what I have written previously.

## 🛠️ Usage Instructions

This project uses a `Makefile` to automate compilation, simulation, and coverage reporting using **QuestaSim**.

### 📄 Basic Targets

| Target          | Description                                                                 |
|------------------|-----------------------------------------------------------------------------|
| `make`           | Compile and run simulation                                                  |
| `make run`       | Same as `make`                                                              |
| `make coverage`  | Run simulation with coverage enabled and generate text + HTML reports       |
| `make clean`     | Remove all generated files (logs, reports, UCDB, compiled libraries, etc.) |

---

### 🔹 Run without coverage

```bash
make SRC=my_test.sv TOP=my_top
