# MIPS Single Cycle Processor

A Verilog implementation of a 32-bit single-cycle MIPS processor, developed as part of my Advanced Computer Architecture course. This project implements a basic MIPS architecture with support for fundamental instructions.

## Overview
This implementation includes:
- 32-bit single-cycle processor
- Basic MIPS instruction set support
- Core components:
  - ALU (Arithmetic Logic Unit)
  - Register File
  - Control Unit
  - Memory Units
  - Program Counter

## Project Structure
- `src/`: Contains all Verilog source files
  - `top.v`: Top-level module
  - `single_cycle_mips.v`: Main processor implementation
  - `alu.v`: Arithmetic Logic Unit
  - `control_unit.v`: Main control unit
  - `memory.v`: Instruction and data memory
  - `program_counter.v`: Program counter logic
  - `register_file.v`: Register file implementation
  - `utils.v`: Utility modules
  - `testbench.v`: Test implementation

## Academic Context
This project was developed as part of the Advanced Computer Architecture course, focusing on implementing fundamental computer architecture concepts through a practical MIPS processor design.

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details