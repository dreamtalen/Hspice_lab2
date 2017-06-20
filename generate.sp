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

.SUBCKT INV A Y nfinn=2 nfinp=2
xnmos Y A GND GND lnfet l=length nfin=nfinn
xpmos Y A VDD VDD lpfet l=length nfin=nfinp
.ENDS

.SUBCKT GENERATE A B CLK G nfinn=finn nfinp=finp
xpmos1 C CLK VDD VDD lpfet l=length nfin=nfinp
xpmos2 C F VDD VDD lpfet l=length nfin=nfinp

X_INV1 C F INV

xnmos1 C A D GND lnfet l=length nfin=nfinn
xnmos2 D B E GND lnfet l=length nfin=nfinn
xnmos3 E CLK GND GND lnfet l=length nfin=nfinn

X_INV2 C G INV

.ENDS

X1 A B CLK G GENERATE

VDD VDD GND 'SUPPLY'
VCLK CLK GND PULSE 0 'SUPPLY' 50ps 15ps 15ps 470ps 1ns
VINA A GND PULSE 0 'SUPPLY' 50ps 15ps 15ps 1970ps 4ns
VINB B GND PULSE 0 'SUPPLY' 50ps 15ps 15ps 3970ps 8ns

.tran 1ps 16ns 
.op all 

.end