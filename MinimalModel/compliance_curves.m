% close all
clear all

TLC=.001*63; 
RV=.001*23; 
VC=(TLC-RV);

alpha_cw=0.25;%
volume0Pres=(alpha_cw*VC+RV);
aw=RV;
cw=0;
dw=2*1.2*.2;
bw=alpha_cw*VC/(log(1+exp(-cw/dw)));

Pel=[-20:.01:35]';
Pcw=[-20:.01:35]';
Phalf =.1;
Ptau =.5;
beta=.01;
gamma =1;
k=0.07;

alpha=((1+exp(Phalf/Ptau))*beta-gamma)/exp(Phalf/Ptau);
Frec=alpha+(gamma-alpha)./(1+exp(-(Pel-Phalf)/Ptau));
Vel=VC*(1-exp(-k*Pel));
VA=Frec.*Vel+RV;
Vcw=aw+bw*log(1+exp((Pcw-cw)/dw));

itemp_start=find(Pcw==-15)
iVcw_start=find(abs(Vcw-Vcw(itemp_start))<0.0005, 1, 'last' ); %volume Vcw at that index
iVA_start=find(abs(VA-Vcw(itemp_start))<.0005, 1, 'last' ); %volume VA at the same index

itemp_end=find(abs(Vcw-TLC)<0.02,1, 'last');
iVcw_end=find(abs(Vcw-Vcw(itemp_end))<0.01, 1, 'last' );
iVA_end=find(abs(VA-Vcw(itemp_end))<1, 1, 'last' );

pcwt=Pcw(iVcw_start:iVcw_end);
vcwt=Vcw(iVcw_start:iVcw_end);
pelt=Pel(iVA_start:iVA_end);
vat=VA(iVA_start:iVA_end);

VolN=linspace(min(vat),max(vat),3000);
PelN=interp1(vat,pelt,VolN);
PcwN=interp1(vcwt,pcwt,VolN);
Ptot=PelN+PcwN;

index=find(abs(Ptot)<0.01,1,'last');
FRC=VolN(index);
P_FRC=PelN(index);

Pel_range=Pel;Vcw_range=Vcw;VA_range=VA;
save PVcurves.mat Pel_range Vcw_range VA_range Ptot VolN FRC P_FRC

figure
plot(Pcw,Vcw,'b',Pel(2001:end),VA(2001:end),'r',Ptot,VolN,'m');%Pel,Vel+RV,'g',
hold on
plot(PcwN(index),FRC,'k*',PelN(index),FRC,'k*')
axis([-10 35 RV TLC])
line([0 0],[0 TLC],'Color',[.7 .7 .7])
line([-10 35],[RV RV],'Color',[.4 .4 .4],'Linestyle','--')
line([-10 35],[FRC FRC],'Color',[.4 .4 .4],'Linestyle',':')
xlabel('Pressure')
ylabel('Volume, ml')
legend('Chest wall','Lung','Total (chest plus lung)','FRC','Location','best')


