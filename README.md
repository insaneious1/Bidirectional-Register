# Bidirectional-Register

# Overview
This project implements an 8-bit bidirectional register module capable of executing read operations from any one of the registers and write operations into any of the four 8-bit registers. The design utilizes two multiplexers (MUX) and demultiplexers (DEMUX) to select the required register for performing read and write operations.

# Features
- # 8-bit Bidirectional Registers:
-  Supports both read and write operations.
- # Read from Any Register:
- Allows reading data from any of the four 8-bit registers.
- # Write to Any Register:
- Enables writing data into any of the four 8-bit registers.
- # Multiplexers and Demultiplexers:
- Utilizes two MUX and DEMUX to select the appropriate register for read and write operations.
# Components
- # 8-bit Registers:
- Four 8-bit registers to hold data.
- # Multiplexer (MUX):
- Selects the register to read from.
- Directs the selected register's output to the read data bus.
- # Demultiplexer (DEMUX):
- Selects the register to write to.
- Routes the write data bus to the selected register.
- # Bidirectional Register :
- manages the read write operations through the inout port.
