# six-instructions-micro

Six instructions microprocessor written in VHDL based on VAHID example (chapter 8)

It has four main parts, divided in subparts:

1. Data memory (**MD.vhd**)
2. Instruction memory (**MI.vhd**)
3. Datapath (**BO.vhd**)
    - Multiplexer 3x1 (**MUX.vhd**)
    - Register files (**BANCOREG.vhd**)
    - ALU (**ULA16bits.vhd**)
4. Control unit
    - PC (**PC.vhd**)
    - IR (**IR.vhd**)
    - Controller (basically the FSM) (**BC.vhd**) (**FSM1.vhd**)

This project was implemented in Quartus II. So one might open the project file '**MICRO.qpf**' and the components would be the .vhd files.

The file **MICROcdivisor.vhd** uses an external clock with 1 second of period that was used basically to observe the operation in the lab.

**BCBO.vhd** is the connection between the datapath and the control unit.

On **MI.vhd** (instruction memory), we have a simple algorithm to be performed by the microprocessor. The data memory has an array of integers and we want to know how many elements are equal to 3.

<p align="center">
  <img src="https://user-images.githubusercontent.com/69206952/180585765-cbe16999-927d-4949-8718-deba0dda361d.png"/>
</p>

## RTL Views

- LEDs were used to visualize results and operation in the lab.

### Top view

<p align="center">
  <img src="https://user-images.githubusercontent.com/69206952/180586377-89d64e6a-a75b-45bb-80fa-3e7b9ffbc2ae.png"/>
</p>

### Connections between control and datapath

<p align="center">
  <img src="https://user-images.githubusercontent.com/69206952/180586441-93e1a875-6c47-4b96-a8d3-00be3ddc3dfe.png"/>
</p>

### Data memory

<p align="center">
  <img src="https://user-images.githubusercontent.com/69206952/180586467-86fac656-07fb-4028-b842-60fdab7200f3.png"/>
</p>

### Instruction memory

<p align="center">
  <img src="https://user-images.githubusercontent.com/69206952/180586486-45c12a1c-2d49-4079-902b-07d497d4e89e.png"/>
</p>


