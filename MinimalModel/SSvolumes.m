function F=SSvolumes(x)

global cc dc Vcmax  M VC cw dw aw bw
global Phalf Ptau beta gamma alpha RV k

Pel=x(1);
Vc=x(2);
M=0;%-1.85;%2.5;

alpha=((1+exp(Phalf/Ptau))*beta-gamma)/exp(Phalf/Ptau);
Frec=alpha+(gamma-alpha)./(1+exp(-(Pel-Phalf)/Ptau));
Vel=VC*(1-exp(-k*Pel));
VA=Frec*Vel+RV;

Pcw=cw+dw*log(exp((VA+Vc-aw)/bw)-1);
Ptm=cc-dc*log(Vcmax./Vc-1);
F(1)=(Pcw+M+Ptm);
F(2)=(Pcw+M+Pel);