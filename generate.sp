.TITLE Single generate
.lib "/home/wjin/dmtalen/hspice/Hspice_lab1/PTM/models" ptm16lstp
.options acct list post runlvl=6
.global vdd gnd
.TEMP 85
.param supply=0.85

.param finp=10
.param finn=30
.param length=20n
.param times_stable = 1

.SUBCKT GENERATE A B CLK G nfinn=finn nfinp=finp
xpmos1 1 CLK VDD VDD lpfet l=length nfin=nfinp
xpmos2 1 4 VDD VDD lpfet l=length nfin=nfinp
xpmos3 4 1 VDD VDD lpfet l=length nfin=5
xpmos4 G 4 VDD VDD lpfet l=length nfin=5
xnmos1 1 A 2 GND lnfet l=length nfin=nfinn
xnmos2 2 B 3 GND lnfet l=length nfin=nfinn
xnmos3 3 CLK GND GND lnfet l=length nfin=nfinn
xnmos4 4 1 GND GND lnfet l=length nfin=5
xnmos5 G 1 GND GND lnfet l=length nfin=5
.ENDS

X1 A B CLK G GENERATE

VDD VDD GND 'SUPPLY'
VCLK CLK GND PULSE 0 'SUPPLY' 50ps 15ps 15ps 470ps 1ns
VINA A GND PULSE 0 'SUPPLY' 50ps 15ps 15ps 1970ps 4ns
VINB B GND PULSE 0 'SUPPLY' 50ps 15ps 15ps 3970ps 8ns

.tran 1ps 16ns 
.op all 

.end