.TITLE Single dot_p
.lib "/home/wjin/dmtalen/hspice/Hspice_lab1/PTM/models" ptm16lstp
.options acct list post runlvl=6
.global vdd gnd
.TEMP 85
.param supply=0.85

.param finp=10
.param finn=30
.param length=20n
.param times_stable = 1

.SUBCKT DOT_P P1 P2 CLK P_OUT nfinn=finn nfinp=finp
xpmos1 1 CLK VDD VDD lpfet l=length nfin=nfinp
xpmos2 1 4 VDD VDD lpfet l=length nfin=nfinp
xpmos3 4 1 VDD VDD lpfet l=length nfin=3
xpmos4 P_OUT 1 VDD VDD lpfet l=length nfin=3
xnmos1 1 P1 2 GND lnfet l=length nfin=nfinn
xnmos2 2 P2 GND GND lnfet l=length nfin=nfinn
xnmos4 4 1 GND GND lnfet l=length nfin=3
xnmos5 P_OUT 1 GND GND lnfet l=length nfin=3
.ENDS

X_DOT_P A B CLK G DOT_P

VDD VDD GND 'SUPPLY'
VCLK CLK GND PULSE 0 'SUPPLY' 50ps 15ps 15ps 470ps 1ns
VINA A GND PULSE 0 'SUPPLY' 50ps 15ps 15ps 1970ps 4ns
VINB B GND PULSE 0 'SUPPLY' 50ps 15ps 15ps 3970ps 8ns

.tran 1ps 16ns 
.op all 

.end