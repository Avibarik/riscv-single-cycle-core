# riscv-single-cycle-core
A 32-bit Single-Cycle RISC-V (RV32I) processor core implemented in Verilog HDL and verified with Icarus Verilog and GTKWave.  Project README.md Template
# 32-Bit Single-Cycle RISC-V (RV32I) Processor

A modular hardware implementation of a single-cycle 32-bit RISC-V integer processor core (`RV32I`) written in Verilog HDL. The core is simulated and verified using open-source EDA tools (Icarus Verilog, GTKWave) and targeted for FPGA synthesis with Intel Quartus Prime.

---

## 🛠️ Modules Implemented

- [x] **32-Bit ALU (`ALU.v`):** 
  - Arithmetic operations: Addition (`ADD`), Subtraction (`SUB`) using 2's complement logic.
  - Bitwise logical operations: `AND`, `OR`.
  - Multiplexer-based data path controlled via `ALUControl` signals.
- [ ] **Register File (`RegFile.v`):** 32 general-purpose 32-bit registers with dual asynchronous read ports and synchronous write port.
- [ ] **Instruction & Data Memory:** Separate Harvard architecture memories for instructions and runtime data.
- [ ] **Control Unit (`Control_Unit.v`):** Opcode and instruction decoder for datapath control signals.
- [ ] **Immediate Generator (`Imm_Gen.v`):** Decodes and sign-extends I-, S-, B-, and U-type immediates.
- [ ] **Top-Level Datapath (`RISCV_Top.v`):** Full integration of the single-cycle execution datapath.



1. **Compile the design and testbench:**
   ```bash
   iverilog -o alu_sim tb_ALU.v ALU.v
