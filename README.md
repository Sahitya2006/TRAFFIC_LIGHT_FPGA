# TRAFFIC_LIGHT_FPGA
This project implements a traffic light controller using VHDL. It cycles through North-South (NS) and East-West (EW) traffic lights with an emergency override that forces all signals to red. The design is simulated in ModelSim.

Features
FSM-based design with states:

NS_GREEN, NS_YELLOW, EW_GREEN, EW_YELLOW, ALL_RED

Emergency input forces ALL RED state

Testbench included for simulation

Waveform visualization in ModelSim



PROJECT STRUCTURE 

traffic_light.vhd       -- Main design (FSM)
traffic_light_tb.vhd    -- Testbench for simulation
README.md               -- Documentation



Expected Waveform
Normal cycle:

NS → Green → Yellow → Red

EW → Green → Yellow → Red

Emergency:

Both NS and EW → Red

Cycle resumes from NS Green after emergency ends



License
MIT License — free to use and modify.
