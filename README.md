# Single_Cycle_Microprocessor



Single-Cycle RISC-V Microprocessor
This repository contains the Verilog implementation of a single-cycle Reduced Instruction Set Computer, Fifth Edition (RISC-V) microprocessor. This design aims to provide a fundamental understanding of CPU architecture by demonstrating a simplified yet functional processor core capable of executing a subset of the RISC-V instruction set.

1. Introduction to RISC-V Architecture
The RISC-V instruction set architecture (ISA) is an open-source, extensible ISA developed by the University of California, Berkeley. Its key design principles emphasize simplicity, modularity, and extensibility, making it ideal for both academic study and industrial application. Unlike proprietary ISAs, RISC-V offers a royalty-free alternative, fostering innovation and collaboration in hardware design.

Key Features of RISC-V:

Reduced Instruction Set: Employs a small, optimized set of instructions, typically of fixed length, which simplifies instruction decoding and execution.

Load/Store Architecture: Memory access is restricted to explicit load and store instructions, while all other operations are performed on registers. This simplifies the control unit and pipeline design.

Orthogonal Instruction Set: Instructions are designed such that their fields (e.g., opcode, register specifiers) are largely independent, reducing complexity and improving encoding efficiency.

Modularity: The base ISA (RV32I for 32-bit integers, RV64I for 64-bit integers) can be extended with standard extensions for features like multiplication/division (M), atomic operations (A), floating-point operations (F, D, Q), and compressed instructions (C).

2. Single-Cycle Design Philosophy
A single-cycle microprocessor is the simplest form of CPU design, where every instruction completes its execution within a single clock cycle. While this approach is straightforward to understand and implement, it comes with performance limitations.

Advantages:

Simplicity: Each instruction's execution path is fully contained within one clock cycle, eliminating the need for complex control logic associated with pipelining or multi-cycle designs.

Ease of Debugging: Since there are no inter-stage dependencies or pipeline hazards, debugging is significantly simplified.

Disadvantages:

Low Performance: The clock cycle time is dictated by the longest instruction's execution path. This means that simpler, faster instructions must wait for the full cycle duration, leading to inefficient utilization of the clock cycle. For instance, a simple register-to-register addition will take as long as a complex memory access instruction.

Resource Inefficiency: All functional units (e.g., ALU, memory, register file) are utilized for only a fraction of the clock cycle, leading to idle periods and underutilization.

3. Microarchitecture Overview
The single-cycle RISC-V microprocessor is composed of several key functional blocks, each responsible for a specific stage of instruction execution. The general flow of an instruction involves fetching it from memory, decoding its operation, executing the operation, accessing data memory (if required), and finally writing the result back to the register file.

Instruction Fetch (IF):

Program Counter (PC): Holds the address of the current instruction. It's updated to PC + 4 for sequential instruction execution or to a target address for branches/jumps.

Instruction Memory: Stores the program instructions and provides the instruction at the address specified by the PC.

Instruction Decode (ID):

Control Unit: Decodes the opcode and funct fields of the instruction to generate control signals for all other functional units. These signals determine the operation of the ALU, register write enable, memory read/write, etc.

Register File: Contains a set of general-purpose registers. The decode stage reads the values of source registers specified by the instruction.

Sign-Extend Unit: Extends immediate values to the full data width (e.g., 32 bits) for operations like addi or branch offsets.

Execute (EX):

Arithmetic Logic Unit (ALU): Performs arithmetic (addition, subtraction) and logical (AND, OR, XOR) operations as well as comparisons. The operation performed by the ALU is determined by the control unit.

ALU Control: Generates the specific control signals for the ALU based on the instruction type.

Memory Access (MEM):

Data Memory: Used for load and store operations. For load instructions, data is read from memory; for store instructions, data is written to memory.

Write Back (WB):

Register File Write: The result of the operation (from ALU or data memory) is written back to the destination register in the register file.

4. Instruction Set Supported (Example)
This implementation supports a subset of the RV32I instruction set, including but not limited to:

R-Type Instructions (Register-to-Register Operations):

ADD: Adds two register values.

SUB: Subtracts two register values.

AND: Performs bitwise AND on two register values.

OR: Performs bitwise OR on two register values.

XOR: Performs bitwise XOR on two register values.

I-Type Instructions (Immediate Operations / Loads):

ADDI: Adds a register value and an immediate.

LW: Loads a word from memory into a register.

S-Type Instructions (Stores):

SW: Stores a word from a register into memory.

SB-Type Instructions (Conditional Branches):

BEQ: Branches if two registers are equal.

UJ-Type Instructions (Unconditional Jumps):

JAL: Jump and link (stores PC + 4 in a register and jumps to a new address).

(Note: You should customize this list based on the actual instructions your design supports.)

5. Verilog Implementation Details
The design is implemented modularly in Verilog, with separate modules for each major functional block (e.g., program_counter, instruction_memory, register_file, alu, control_unit, data_memory). The top-level module (riscv_single_cycle.v) instantiates and connects these individual components, orchestrating the data flow and control signals for the single-cycle operation.

Key Modules:

pc.v: Program Counter module.

imem.v: Instruction Memory module.

reg_file.v: Register File module.

alu.v: Arithmetic Logic Unit module.

control_unit.v: Generates all control signals.

dmem.v: Data Memory module.

riscv_single_cycle.v: Top-level module connecting all components.

(You can expand on specific design choices, e.g., how the control unit decodes instructions, how forwarding or hazard detection would be handled in a more complex design, or any unique aspects of your implementation.)

6. Simulation and Testing
The design has been simulated and verified using [mention your simulator, e.g., Icarus Verilog, ModelSim, Vivado Simulator]. Test benches have been developed to exercise the supported instruction set and verify correct functionality.

*(You might briefly explain your testing methodology, e.g.,

Test Bench Generation: How test cases (assembly code) are converted into machine code for the instruction memory.

Expected Output Verification: How the simulation outputs (register file contents, memory contents) are compared against expected values.)*

7. Future Work
Possible future enhancements to this single-cycle RISC-V processor include:

Pipelining: Implementing a multi-stage pipeline to improve instruction throughput and overall performance. This would involve addressing pipeline hazards (data, control) through techniques like forwarding and stalling.

Additional Instruction Set Extensions: Supporting more complex instructions from other RISC-V extensions (e.g., M extension for multiplication/division, F extension for floating-point).

Interrupt Handling: Adding support for external interrupts and exception handling.

Cache Memory: Incorporating instruction and data caches to reduce memory access latency.

