# Cryptographic Coprocessor
---
A 16-bit dedicated hardware module that executes cryptographic operations alongside the main CPU. By shifting these workloads from software to hardware, it efficiently handles the computationally intensive operations underlying cryptographic primitives, including:
- **Arithmetic operations** (ADD, SUB)
- **Bitwise logic** (AND, OR, XOR, NOT)
- **Bit manipulation** (rotations and shifts)
- **Non-linear substitution** (LUT-based transformations)

# The Case for Hardware Acceleration
**Cryptographic processes are highly repetitive**, demanding hundreds of thousands of calculations every second. Offloading this workload to purpose-built hardware provides several distinct advantages:
- **Near-Instant Processing:** Complex mathematical operations can be resolved in a single clock cycle.
- **CPU Offloading:** Frees up the main processor to handle other critical system tasks.
- **Maximized Throughput:** Dramatically increases the volume and speed of data being processed. 
- **Enhanced Security:** Guarantees constant-time execution, which protects the system against timing-based side-channel attacks.

# Architecture
---
**Schematic**
<img src="Assets\Co-Processor.png" width="100%" height="390px" />

**Block diagram**
```
					┌───────────────────────────────────────────────┐
                    │                                               │
  clk ─────────────►│                 Co_Processor                  │
  rst ─────────────►│                (Top Entity)                   │
  CTRL[3:0] ───────►│                                               │
  Ra[3:0] ─────────►│                                               │
  Rb[3:0] ─────────►│                                               │
  Rd[3:0] ─────────►│                                               │
                    └──────────────┬────────────────────────────────┘
                                   │
                                   ▼
                    ┌───────────────────────────────┐
                    │                               │
  clk ─────────────►│         Register_16x16        │
  rst ─────────────►│        (Register_File)        │
  write_en ────────►│       Asynchronous Read       │
  Ra[3:0] ─────────►│       Synchronous Write       │
					│                               │ 
  Rb[3:0] ─────────►│  Ra ──► SRCa ──► src_a[15:0]  │
  Rd[3:0] ─────────►│  Rb ──► SRCb ──► src_b[15:0]  │
                    │  Rd ◄── RES  ◄── result[15:0] │
                    │                               │
                    └────────┬───────────┬──────────┘
                             │           │
                 src_a[15:0] │           │ src_b[15:0]
                             ▼           ▼
                    ┌───────────────────────────────────────────┐
                    │                                           │
                    │           Combinational_Logic             │
                    │               (comb_logic)                │
                    │                                           │
                    │  ┌────────────────────────────────────┐   │
                    │  │             ALU_unit               │   │
  A_BUS (src_a) ───►│  │              (ALU)                 │   │
  B_BUS (src_b) ───►│  │                                    │   │
  CTRL[3:0] ───────►├──┼────────────────┬─ out2_ALU[15:0]   │   │
                    │  └────────────────┼───────────────────┘   │
                    │                   │                       │
                    │  ┌────────────────┼───────────────────┐   │
                    │  │            SHIFT_unit              │   │
  B_BUS (src_b) ───►│  │             (shifter)              │   │
  CTRL[3:0] ───────►├──┼────────────────┬─ out3_shf[15:0]   │   │
                    │  └────────────────┼───────────────────┘   │
                    │                   │                       │
                    │  ┌────────────────┼───────────────────┐   │
                    │  │             LUT_unit               │   │
  A_BUS[7:0] ──────►│  │       (non_linear_lookup)          │   │
  CTRL[3:0] ───────►├──┼────────────────┬─LUT_out[7:0]      │   │
                    │  └────────────────┼───────────────────┘   │
                    │                   │                       │
                    │             out1_LUT[15:0]                │
                    │         (A_BUS[15:8] & LUT_out)           │
                    │                   │                       │
                    │          ┌────────▼───────┐               │
                    │          │ Control_Logic  │               │
  CTRL[3:0] ───────►│          │     (MUX)      │               │
                    │          └────────┬───────┘               │
                    │                   │                       │
                    └───────────────────┼───────────────────────┘
                                        │
                                        ▼
                                    RES[15:0]
                                        │
                                        │ mapped to `result`
                                        ▼
                                 Register_16x16 ◄─ Write-back
```

# Getting started
---
1. **Clone the repo**
```
git clone https://github.com/Ma7moudEGY/Cryptographic-Coprocessor.git
```

2. **Create a new Active-HDL workspace**
	File -> New -> Workspace.

3. **Add the source files**
	Right click your design -> Add files
	Go to the cloned `src/` folder -> Select all `.vhd` files -> Open
4. **Set the compilation order**
	Design -> Compilation Order -> Use this exact order:
```
1. half_adder.vhd
2. full_adder.vhd
3. N_bit_adder.vhd
4. ALU.vhd
5. shifter.vhd
6. non_linear_lookup.vhd
7. register.vhd
8. comb_logic.vhd
9. co_processor.vhd
10. test_program.vhd
```
5. Compile.
	Press F11 or Design -> Compile All.
6. Run.