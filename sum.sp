.TITLE Single sum
.lib "/home/wjin/dmtalen/hspice/Hspice_lab1/PTM/models" ptm16lstp
.options acct list post runlvl=6
.global vdd gnd vss
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

.SUBCKT SUM C_IN S0 S1 CLK CLK_D SUM_OUT nfinn=finn nfinp=finp
xpmos1 A CLK VDD VDD lpfet l=length nfin=400
xnmos1 A C_IN B GND lnfet l=length nfin=5
xnmos2 B CLK GND GND lnfet l=length nfin=5

xpmos2 C CLK VDD VDD lpfet l=length nfin=nfinp
xnmos3 C C_IN D GND lnfet l=length nfin=nfinn
xnmos4 D S1 E GND lnfet l=length nfin=nfinn
xnmos5 E CLK GND GND lnfet l=length nfin=nfinn

xpmos3 F CLK_D VDD VDD lpfet l=length nfin=nfinp
xpmos4 F G VDD VDD lpfet l=length nfin=2
X_INV1 F G INV
xnmos6 F A H GND lnfet l=length nfin=10
xnmos7 H S0 I GND lnfet l=length nfin=50
xnmos8 I CLK_D GND GND lnfet l=length nfin=50

xpmos5 SUM_OUT F VDD VDD lpfet l=length nfin=nfinp
xnmos9 SUM_OUT F J GND lnfet l=length nfin=nfinn
xnmos10 J C GND GND lnfet l=length nfin=nfinn
xpmos6 SUM_OUT C VDD VDD lpfet l=length nfin=nfinp

.ENDS

X_SUM C_IN S0 S1 CLK CLK_D SUM_OUT SUM

VDD VDD GND 'SUPPLY'
VSS GND VSS '0'
VCLK CLK GND PULSE 0 'SUPPLY' 50ps 15ps 15ps 470ps 1ns
VCLK_D CLK_D GND PULSE 0 'SUPPLY' 59ps 15ps 15ps 470ps 1ns
VINC C_IN GND PULSE 0 'SUPPLY' 50ps 15ps 15ps 970ps 2ns
VINS0 S0 GND PULSE 0 'SUPPLY' 50ps 15ps 15ps 1970ps 4ns
VINS1 S1 GND PULSE 0 'SUPPLY' 2050ps 15ps 15ps 1970ps 4ns



.tran 1ps 16ns 
.op all 
.measure TRAN power_vdd AVG P(VDD) FROM=0ns TO=4ns
.measure TRAN power_gnd AVG P(GND) FROM=0ns TO=4ns

.end