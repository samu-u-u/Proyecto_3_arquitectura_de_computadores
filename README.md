# Pochoco SoC & Espino Core

Canales: [Twitch](https://www.twitch.tv/samuel_vallette) [YouTube](https://www.youtube.com/@Samuel_Vallette)

stack: `C` `C++` `Verilog` `Python` `Bash` `RISC-V` `FPGA` `ASIC`

An ASIC/SoC journey from RTL to GDSII with a RISC-V microarchitecture built from scratch — no soft cores, no ARMs, no nonsense. Created for the Arquitectura de Computadores course at Universidad de los Andes (Chile).

[![GoBoard](https://img.shields.io/badge/Demo-GoBoard_2.0-005555?style=for-the-badge&logo=github&logoColor=white)](https://github.com/mndxs/GoBoard2) [![ASIC](https://img.shields.io/badge/ASIC-GF180MCU-800000?style=for-the-badge&logo=github&logoColor=white)](https://github.com/google/gf180mcu-pdk)

[GoBoard 2.0 initial project here](https://github.com/samu-u-u/Proyecto_1_Arquitectura)

---

## Proyecto 3 — Flujo ASIC (LibreLane + GF180MCU)

El proyecto lleva el SoC desde el RTL modificado del Proyecto 2 hasta un **GDSII** (macro digital con celdas estándar) usando el flujo abierto **LibreLane** y el **PDK GF180MCU**.

### Versiones exactas usadas en la corrida final

| Componente | Versión / Revisión |
|---|---|
| LibreLane | devshell `librelane-devshell-x86_64.AppImage` (imagen oficial de LibreLane) |
| Gestor de entornos (Ciel) | `pip install ciel`, PDK `gf180mcuD` |
| PDK GF180MCU | revisión `792ef67037d74c8c51811eab3ce23cf793491296` |
| Biblioteca de celdas estándar | `gf180mcu_fd_sc_mcu7t5v0` |
| Diseño final | `asic_rom_top`, CLOCK_PERIOD = 100 ns (10 MHz), FP_CORE_UTIL = 40 % |

### Instalación de LibreLane (desde cero)

Requisitos del sistema (Ubuntu/Debian):

```
sudo apt-get install -y build-essential python3 python3-venv python3-pip curl make git uidmap openssh-client
sudo apt-get install -y libfuse2t64 || sudo apt-get install -y libfuse2
```

Instalar Ciel y habilitar el PDK:

```
python3 -m venv ~/ciel-venv
~/ciel-venv/bin/pip install --upgrade ciel
~/ciel-venv/bin/ciel enable --pdk gf180mcu 792ef67037d74c8c51811eab3ce23cf793491296
```

Descargar el devshell AppImage de LibreLane y darle permisos de ejecución:

```
chmod a+x ~/librelane-devshell-x86_64.AppImage
```

### Ejecutar la corrida final

```
git clone https://github.com/samu-u-u/Proyecto_3_arquitectura_de_computadores.git ~/Proyecto_3
cd ~/Proyecto_3
~/librelane-devshell-x86_64.AppImage      # entra al entorno con LibreLane
librelane config_rom.yaml                 # corrida final: a_T100_U40 (T=100 ns, U=40 %)
```

La corrida se considera cerrada cuando LibreLane termina el flujo con DRC y LVS limpios, sin violaciones de antena sin justificar, y cumpliendo setup y hold (WNS ≥ 0 y TNS = 0) en los corners exigidos.

### Corridas del espacio de diseño (exploración)

| Config | Corrida | Qué explora |
|---|---|---|
| `config_rom.yaml` | a_T100_U40 | Corrida final (ROM, T=100 ns, U=40 %) |
| `config_ff.yaml` | ff_T100_U40 | Estrategia de memoria con flip-flops |
| `c_a_U30/U50/U60.yaml` | a_U30/50/60 | Barrido de utilización 30–60 % |
| `c_a_T50/T25/T15.yaml` | a_T50/25/15 | Barrido de frecuencia (20/40/67 MHz) |

Las métricas verificadas de las 8 corridas están en `reports/metricas_*.json`.

### Regenerar el programa desde game.s

```
cd sw
make game    # assembler propio (tools/assembler.py): game.s -> game.hex
```

La ROM combinacional (`game_rom.v`) se genera desde el mismo assembler a partir de `game.s` (estrategia de memoria a); la memoria unificada de flip-flops se genera como `game_ffmem.v` (estrategia b). Ambas están incluidas ya generadas en `sw/`.

---

## GoBoard 2.0 Journey

The GoBoard 2.0 is an affordable FPGA development board designed to make **hands-on hardware design** accessible to everyone. It features an **ICE40UP5K FPGA**, 8 user LEDs, 4 buttons, 7-segment displays and Pmod connectors.

### Repository Layout

```
rtl/        # ESPINO SoC design (Verilog)
sw/         # RISC-V assembler, game & test programs
tools/      # Development tools & scripts
makefile    # Build & simulation scripts
```

### Progress Journey (Proyecto 1, revamp in Proyecto 2, ASIC in Proyecto 3)

- [x] **assembler.s** - A custom RISC-V assembler that reads assembly files and generates machine code for our core (hex files)
- [x] **ESPINO Core** - RISC-V microarchitecture from scratch (RV32I, 4-stage pipeline, data forwarding, hazard detection, ...)
- [x] **Verilog UART** - Custom UART with configurable baud rate (115200-9600)
- [x] **Pochoco SoC** - ESPINO core, UART, RAM memory, GPIO, 7-seg displays, buttons, memory-mapped peripherals
- [x] **game_top** - The famous "Reflex game" built on Pochoco SoC, from game.s assembly
- [x] **RTL -> ASIC** - ASIC adaptation: game.s ROM (game_rom.v), unified FF memory (game_ffmem.v), SPI module, peripheral registers, reduced data RAM, asic_rom_top / asic_ff_top

### The Pochoco SoC powering the ESPINO core

| Spec              | Value |
|-------------------|-------|
| Core              | ESPINO (RV32I, custom pipeline) |
| Clock             | 25 MHz (FPGA) / 10 MHz (ASIC, T = 100 ns) |
| RAM               | 32 KB (BRAM, FPGA) / reduced data RAM (ASIC) |
| UART              | 115200 baud |
| GPIO              | 4 LEDs, 4 buttons, 2x 7-segment displays |
| Program           | game.hex (assembled from game.s) |

### Additional Features

- **FPGA Prototyping**: Full support for the GoBoard 2.0 (ICE40UP5K)
- **ASIC Flow**: Complete RTL-to-GDSII flow using LibreLane & GF180MCU PDK
- **Automated Build**: One command to assemble, compile and flash
- **Unit Tests**: Test programs for each SoC feature
- **Simulation**: Icarus Verilog testbenches for RTL and gate-level

### Challenges

- Building a RISC-V assembler entirely from scratch
- Designing a custom core with pipelining, forwarding & hazard management
- Memory-mapped I/O with custom peripherals
- Migrating from FPGA primitives (BRAM, $readmemh) to ASIC structures (ROM, reduced RAM)
- Timing closure across multiple corners and utilization targets

## How to Build (for GoBoard 2.0)

**For the original GoBoard build, this project assumes the ICE40UP5K toolchain:**

```
make all    # assemble game & compile RTL
make flash  # flash the board
```

## Unit Tests

Run all tests:
```
make test
```

Run a specific test:
```
make test3
make test9
```

## Run Simulation

```
make sim
```

## Acknowledgments

This project was inspired by the [GoBoard 2.0](https://github.com/mndxs/GoBoard2) project and developed as part of the Arquitectura de Computadores course at Universidad de los Andes, Chile.

## Developer Group

- Samuel Vallette ([samu-u-u](https://github.com/samu-u-u))
- Arantxa Toledo
- Agustín Alvarez

---

*Proyecto 3: Arquitectura de Computadores — Universidad de los Andes, Chile. Semestre 2026-2.*
