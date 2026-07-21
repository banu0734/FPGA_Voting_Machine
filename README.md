# FPGA-Based Electronic Voting Machine using Verilog HDL

A multi-party Electronic Voting Machine (EVM) implemented using **Verilog HDL** and deployed on the **Digilent Basys3 FPGA**. The project demonstrates FPGA-based digital system design with reliable vote registration, hardware debouncing, and real-time vote display. The same RTL was also configured for the **OpenLane ASIC flow**, showing compatibility with both FPGA prototyping and ASIC implementation.

---

## Project Overview

Electronic Voting Machines provide a reliable and efficient alternative to traditional paper ballots by reducing manual counting errors and improving result accuracy. This project implements a digital voting machine capable of recording votes for five independent parties.

The complete design is written in Verilog HDL and implemented on the Basys3 FPGA board. The project also includes an OpenLane configuration to demonstrate ASIC synthesis compatibility using the Sky130 Process Design Kit (PDK).

---

## Features

- Five-party voting system
- Single vote registration for each valid button press
- Hardware button debouncing
- Individual vote counters
- Dynamic seven-segment display output
- FPGA implementation on Basys3
- OpenLane ASIC synthesis support

---

## Hardware

| Component | Description |
|-----------|-------------|
| FPGA Board | Digilent Basys3 |
| FPGA Device | Xilinx Artix-7 XC7A35T |
| Inputs | Push Buttons |
| Outputs | Four-Digit Seven Segment Display |

---

## Software & Tools

- Verilog HDL
- Xilinx Vivado 2023.2
- OpenLane
- Sky130 Open PDK

---

## Repository Structure

```text
FPGA-Voting-Machine/
│
├── README.md
│
├── src/
│   └── top.v
│
├── constraints/
│   └── basys3.xdc
│
├── simulation/
│   └── tb_top.v
│
├── openlane/
│   └── config.json
│
└── images/
    ├── synth.png
    └── basys3_output.jpg
```

---

## Design Flow

```
Verilog RTL
      │
      ▼
RTL Simulation
      │
      ▼
Logic Synthesis
      │
      ▼
Vivado Implementation
      │
      ▼
Bitstream Generation
      │
      ▼
Basys3 FPGA Validation
      │
      ▼
OpenLane ASIC Configuration
```

---

## Design Architecture

The voting machine is composed of several functional blocks:

- Button Debounce
- Edge Detection
- Vote Counter
- Display Selector
- Binary to BCD Converter
- Seven Segment Controller
- Clock Divider

These modules are integrated through the top-level RTL module.

---

## Working Principle

Each push button corresponds to a political party. When a button is pressed, the debounce circuit removes switch bounce before generating a single pulse. This pulse increments the selected party's vote counter exactly once.

Using the slide switches on the Basys3 board, the vote count of any party can be selected and displayed on the onboard seven-segment display.

---

# RTL Synthesis

The RTL schematic generated from the Verilog design.

<p align="center">
<img src="images/synth.png" width="850">
</p>

---

# FPGA Hardware Validation

The design was synthesized, implemented, and successfully validated on the Digilent Basys3 FPGA board.

<p align="center">
<img src="images/basys3_output.jpg" width="600">
</p>

---

## Source Files

| File | Description |
|------|-------------|
| top.v | Complete Verilog RTL Design |
| basys3.xdc | FPGA Pin Constraints |
| tb_top.v | Functional Testbench |
| config.json | OpenLane Configuration |

---

## Running the Project

### Vivado

1. Create a new RTL project.
2. Add the source file.
3. Add the Basys3 constraint file.
4. Run synthesis.
5. Run implementation.
6. Generate the bitstream.
7. Program the Basys3 FPGA.

### OpenLane

1. Place the RTL source in the `src` directory.
2. Update the OpenLane configuration if required.
3. Execute the OpenLane flow using the provided `config.json`.

---

## Future Improvements

- Password-protected voting
- External memory for vote storage
- UART-based result transmission
- LCD/OLED display
- Wireless monitoring
- AES-based secure voting
- Full ASIC implementation

---

## Author

**Banushree**
