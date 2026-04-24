# OSprojekat
# OSprojekat

A bare-metal operating system kernel for the **RISC-V** architecture, developed as a university project at ETF (Electrical Engineering Faculty). The kernel is written in RISC-V Assembly and C++, and runs on the **QEMU** RISC-V virtual machine.

***

## Overview

This project implements a minimal kernel from the ground up, targeting the RISC-V ISA. It covers low-level bootstrapping, memory layout management via a custom linker script, and kernel-mode execution on QEMU. The project is part of the Operating Systems (OS) course curriculum.

## Project Structure

```
OSprojekat/
├── src/            # C++ kernel source files
├── h/              # Header files
├── lib/            # Library/support code
├── build/src/      # Compiled output objects
├── kernel.asm      # RISC-V Assembly entry point and low-level routines
├── kernel.ld       # Linker script — maps kernel to 0x80000000
├── kernel          # Compiled kernel binary (ELF)
├── Makefile        # Build system
├── .gdbinit        # GDB configuration for debugging
└── .gdbinit.tmpl-riscv  # GDB template for RISC-V remote debugging
```

## Architecture

| Property        | Value                          |
|-----------------|-------------------------------|
| Target ISA      | RISC-V (64-bit)               |
| Emulator        | QEMU (`-kernel` mode)         |
| Entry point     | `_entry` at `0x80000000`      |
| Languages       | RISC-V Assembly, C++          |
| Build system    | GNU Make                      |

The linker script (`kernel.ld`) places the kernel binary at physical address `0x80000000`, which is where QEMU's `-kernel` flag jumps on boot. Memory sections are laid out in order: `.text` → `.rodata` → `.data` → `.bss`.

## Prerequisites

Make sure the following tools are installed:

- `riscv64-unknown-elf-gcc` — RISC-V cross-compiler toolchain
- `qemu-system-riscv64` — QEMU RISC-V emulator
- `make` — GNU Make
- `gdb-multiarch` — for debugging (optional)

On Ubuntu/Debian:

```bash
sudo apt install gcc-riscv64-unknown-elf qemu-system-misc make gdb-multiarch
```

## Building

```bash
make
```

This compiles all Assembly and C++ sources and links them into the `kernel` ELF binary using `kernel.ld`.

To clean build artifacts:

```bash
make clean
```

## Running

```bash
make run
```

This launches the kernel in QEMU. Internally, it runs something equivalent to:

```bash
qemu-system-riscv64 -machine virt -bios none -kernel kernel -nographic
```

## Debugging with GDB

The `.gdbinit` file is pre-configured for remote debugging via QEMU's GDB stub.

**Terminal 1 — start QEMU with GDB server:**
```bash
make run-gdb
```

**Terminal 2 — attach GDB:**
```bash
gdb-multiarch kernel
```

GDB will automatically connect to `localhost:1234` and load symbols from the kernel ELF.

## License

See [LICENSE](LICENSE) for details.

## Author

**Andrej Veličkov**  
ETF Belgrade — Operating Systems course project
