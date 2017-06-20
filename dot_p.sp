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

.SUBCKT INV A Y nfinn=2 nfinp=2
xnmos Y A GND GND lnfet l=length nfin=nfinn
xpmos Y A VDD VDD lpfet l=length nfin=nfinp
.ENDS

.SUBCKT DOT_P P1 P2 CLK P_OUT nfinn=finn nfinp=finp
xpmos1 A CLK VDD VDD lpfet l=length nfin=nfinp
xpmos2 A C VDD VDD lpfet l=length nfin=nfinp

X_INV1 A C INV

xnmos1 A P1 B GND lnfet l=length nfin=nfinn
xnmos2 B P2 GND GND lnfet l=length nfin=nfinn

X_INV2 A P_OUT INV

.ENDS

X_DOT_P A B CLK G DOT_P

VDD VDD GND 'SUPPLY'
VCLK CLK GND PULSE 0 'SUPPLY' 50ps 15ps 15ps 470ps 1ns
VINA A GND PULSE 0 'SUPPLY' 50ps 15ps 15ps 1970ps 4ns
VINB B GND PULSE 0 'SUPPLY' 50ps 15ps 15ps 3970ps 8ns

.tran 1ps 16ns 
.op all

.end