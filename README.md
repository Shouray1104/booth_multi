# Booth's Multiplier (4-bit Signed) – Verilog Implementation

This project provides a Verilog implementation of Booth’s algorithm for multiplying two signed 4-bit numbers using 2’s complement arithmetic. It demonstrates a hardware-level approach to signed multiplication, useful for both learning and practical digital design.

---

## Files Included

- `booths_multiplier.v` – The main module implementing Booth’s multiplication using a finite state machine.
- `tb_booths_multiplier.v` – A testbench for simulating and verifying the functionality of the multiplier.

---

## How It Works

The design operates on a pair of signed 4-bit inputs: the multiplicand and the multiplier. Booth’s algorithm examines two bits (`Q0` and a saved bit `Q-1`) to decide whether to add, subtract, or perform no operation on the accumulator.

After each operation, an arithmetic right shift is applied to the accumulator and multiplier, and the process repeats for a fixed number of cycles (four in this case). The final 8-bit signed result is then output.

---

## Simulation and Output

To simulate:

1. Use any standard Verilog simulator (such as ModelSim, Icarus Verilog, or Vivado).
2. Compile both files.
3. Run the testbench and observe output in the console or waveform viewer.


---

## Notes

- Designed for 4-bit signed inputs. It can be extended to support larger widths.
- Follows a basic state machine with IDLE, RUN, and DONE states for control.
- The product output is 8-bit signed to accommodate the full result range.

---

## About Booth’s Algorithm

Booth’s algorithm is widely used in digital multipliers for signed integers. It reduces the number of arithmetic operations needed, particularly when the multiplier contains runs of 1’s, making it more efficient than basic shift-and-add methods.


