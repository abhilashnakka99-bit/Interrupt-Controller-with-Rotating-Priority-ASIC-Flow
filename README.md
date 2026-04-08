#  Rotating-Priority-Interrupt-Controller-ASIC

##  Overview

This project implements a **rotating priority interrupt controller** using Verilog and completes the full **ASIC design flow (RTL to GDSII)** using Cadence Genus and Cadence Innovus.

The design ensures fair arbitration among multiple interrupt requests and achieves successful timing closure with zero violations.

---

##  Tools Used

* Verilog HDL
* Cadence Genus (Synthesis)
* Cadence Innovus (Place & Route)

---

##  Features

* Rotating priority mechanism (fair scheduling)
* Multiple interrupt request handling
* Synchronous digital design
* Optimized for timing and area

---

##  ASIC Design Flow

1. RTL Design (Verilog)
2. Testbench Simulation
3. Synthesis using Genus
4. Floorplanning
5. Placement
6. Clock Tree Synthesis (CTS)
7. Routing
8. Timing Analysis
9. GDSII Generation
RTL → Synthesis → Floorplanning → Placement → Clock Tree Synthesis → Routing → GDSII
---

##  Timing Results

* Setup WNS: **+5.555 ns**
* Hold WNS: **+0.020 ns**
* Total Negative Slack (TNS): **0**
* Violations: **0**

✅ Design meets all timing constraints successfully.

---

##  Design Rule Check (DRC)

* Max Capacitance Violations: **0**
* Max Transition Violations: **0**
* Max Fanout Violations: **0**

✅ No electrical violations observed.

---

##  Utilization

* Cell Density: **71%**

---

##  Clock Tree

* Balanced clock distribution achieved
* Minimal skew after CTS

---

## How to Run

Simulate using any Verilog simulator (ModelSim, etc.)
Use SDC constraints for synthesis in Cadence Genus
Perform place and route using Cadence Innovus

##  Results

###  Timing Analysis

![Timing](screenshots/<img width="886" height="657" alt="worstbestcase" src="https://github.com/user-attachments/assets/31810311-5d31-4f80-8813-9aca0003be8a" />
]()
)

###  Clock Tree

![Clock Tree](screenshots/<img width="1057" height="632" alt="image" src="https://github.com/user-attachments/assets/382f29cf-91af-401b-8877-79db829dd571" />
)

###  Path Histogram

![Histogram](screenshots/<img width="841" height="743" alt="timedebug" src="https://github.com/user-attachments/assets/38d3c842-fa38-46a2-93c8-674efd977de7" />
)

###  Layout

![Layout](screenshots/<img width="953" height="817" alt="layout" src="https://github.com/user-attachments/assets/eb5b0c31-a712-4487-81e0-6b2ef28db518" />
)

---

##  Project Structure

rtl/            → Verilog RTL code
testbench/      → Simulation testbench
constraints/    → SDC constraints
reports/        → Timing, area, power reports
layout/         → Final GDSII
screenshots/    → Output images

---

## 🎯 Conclusion

This project demonstrates a complete ASIC design cycle using industry-standard Cadence tools, achieving timing closure, clean DRC, and efficient layout implementation.

---

## 👨‍💻 Author

Abhilash Nakka


