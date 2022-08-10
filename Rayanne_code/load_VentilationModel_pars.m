% close all

global Rsd Ks Rsm Vstar RV TLC 
global Cve Rve FRC VC 
global RR f T Amus cF dF k
global beta gamma alpha Pao

 
Pao = 0; % airway opening pressure
Amus  = 15;

cF =.1;
dF = .5;
beta=0.01;
gamma = 1;%*.99;
alpha=((1+exp(cF/dF))*beta-gamma)/exp(cF/dF);
k=0.07;

FRC   = .001*24.89; %in Liters .001*28.1; 
RV    = .001*23;
TLC   = .001*63;
VC  = TLC-RV;
RR      = 60;
f       = RR/60;  
T       = 1/f;

Rsm    = 12;
Rsd    = 20;
Ks    = -15;
Vstar = TLC;
Cve   = 0.005;
Rve   = 20;

