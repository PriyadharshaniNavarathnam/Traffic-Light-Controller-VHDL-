# Traffic-Light-Controller-VHDL-
# Traffic Light Controller Using VHDL

This project demonstrates the design and implementation of a traffic light controller using VHDL programming. The system prioritizes vehicles on a hospital road over pedestrians waiting at a crossing, ensuring safe and efficient traffic flow.

---


---

## Introduction
The task is to design a traffic light controller for a highway and a road leading to a hospital. Pedestrian safety and vehicle priority are managed using input sensors and an FPGA board.

---

## Objective
- To design a traffic light system using VHDL programming.
- To implement the system on an FPGA board, interfacing it with sensors.
- To ensure safe and efficient management of vehicles and pedestrians.

---

## Components Used
- **FPGA Board**: For executing VHDL code.
- **Arduino Board**: For interfacing sensors.
- **Quartus Prime Software**: For simulating and synthesizing VHDL code.
- **Ultrasonic Sensors**: To detect vehicles and pedestrians.
- **LEDs**: To represent traffic lights.
- **Voltage Divider**: To match voltage levels between Arduino and FPGA.

---

## Methodology
1. **Research**: Conducted literature review to understand requirements and constraints.
2. **Design**:
   - Created a truth table to define input-output relationships.
   - Designed a state diagram to visualize transitions.
3. **Implementation**:
   - Developed VHDL code based on the truth table and state diagram.
   - Simulated the design in Quartus Prime.
   - Synthesized and debugged the code on an FPGA board.
4. **Integration**: Used Arduino to interface sensors with the FPGA.
5. **Testing**: Verified the functionality of the traffic light controller.

---

## Implementation Details
### Finite State Machine (FSM) Design
The system uses the following states:
1. **Green**: Default state; vehicles on the highway proceed.
2. **Yellow**: Transition state before turning red.
3. **Red**: Stops vehicles on the highway.
4. **AllowPedestrians**: Pedestrians are allowed to cross.
5. **Priority**: Vehicles from the hospital road are given priority.

### Key Features
- **Timer-Based Control**: Yellow light lasts for 3 seconds; pedestrian crossing is active for 20 seconds.
- **Sensor Inputs**:
  - `hospital_vehicles`: Detects vehicles on the hospital road.
  - `pedestrians_waiting`: Detects pedestrians at the crossing.

---

## VHDL Code Explanation
The code defines the following:
- **Inputs**:
  - `clk`: Clock signal.
  - `reset`: Resets the FSM.
  - `hospital_vehicles`: Sensor input for hospital vehicles.
  - `pedestrians_waiting`: Sensor input for waiting pedestrians.
- **Outputs**:
  - `traffic_light`: 3-bit signal representing light states (Green: `001`, Yellow: `010`, Red: `100`).
  - `pedestrian_crossing`: Indicates if pedestrians can cross.
- **FSM Logic**: Transition between states is governed by sensor inputs and timers.

---

## Challenges Faced
1. **Limited Knowledge**:
   - VHDL programming and FPGA usage required extensive learning.
2. **Voltage Mismatch**:
   - Resolved by using a voltage divider to adjust 5V Arduino output to FPGA's 3.3V input.
3. **Tool Familiarity**:
   - Gained expertise in Quartus Prime and ModelSim for simulation and synthesis.

---

## Conclusion
The system successfully prioritizes hospital road vehicles over pedestrians while maintaining safety and efficiency. This project provided valuable insights into VHDL programming, FPGA design, and system debugging.

---

## Future Enhancements
1. **Dynamic Timing**:
   - Adjust traffic light durations based on real-time traffic density.
2. **Integration with IoT**:
   - Use real-time data collection for improved traffic management.
3. **Advanced Sensors**:
   - Replace ultrasonic sensors with cameras for better accuracy.

---

## How to Run
1. Clone this repository:
   ```bash
   git clone <repository-url>
