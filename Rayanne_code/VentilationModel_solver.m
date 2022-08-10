function VentilationModel_solver(NP)

global Ks Vstar RV
global Amus f  T FRC Rsd Rsm %NP
global cF dF k
global gamma alpha VC 
global i tog Pao

tstep=0.005;
tprev=0;
tnext=tprev+T;
periods=[tprev tnext];
tspan = [tprev:tstep:tnext];
ppp=length(tspan);

Pel0=0.954; % %%% Pel0 for low Cw is 2.015; 2.015;%
Pve0 = 0;

Init=[Pel0 Pve0];
times=0;
sols=Init;

Pmussave=0;
VAminsave=[];
Cdynsave=[];

options = [];

% Solving system of DEs for each breathing cycle
for i=1:NP
    try
        [time,sol]=ode15s(@VentilationModel,tspan,Init,options,T,tprev); %,options
        times=[times;time(2:end)];  %save times current cycle
        sols=[sols; sol(2:end,:)];  %save state solutions current cycle
        Init=[sol(end,1:2)];        %update initial conditions
        Peltemp=sol(1:end,2);       %extract Pel over current cycle 
        maxPel=max(Peltemp);        %extract max Pel current cycle
        minPel=min(Peltemp);        %extract min Pel current cycle
        endPel=Peltemp(end);        %extract final Pel current cycle
        Frectemp=alpha+(gamma-alpha)./(1+exp(-(Peltemp-cF)/dF)); %calculate frac rec current cycle
        %minFrec=min(Frectemp);      %extract min frac rec alveoli current cycle
        %endFrec=Frectemp(end);      %extract end frac rec alveoli current cycle
        Veltemp=VC*(1-exp(-k*Peltemp)); %calculate Vel current cycle
        VAtemp=Frectemp.*Veltemp+RV;    %calculate VA (alveolar volume) current cycle
        VAmax=max(VAtemp);          %extract max VA current cycle
        VAmin=min(VAtemp);          %extract min VA current cycle
        Cdyn=(VAmax-VAmin)/(maxPel-minPel); %calculate "dymamic" lung compliance over current cycle
        VT=VAmax-VAmin;             %calculate tidal volume
        VE=VT*f*60;                 %calculate minute ventilation
        VAminsave=[VAminsave;VAmin];    %save min VA current cycle
        Cdynsave=[Cdynsave;Cdyn];       %save Cdyn current cycle
        %%% Toggle for muscle pressure driver function
        if tog == 1
            for j=1:length(tspan)-1
                Pmussave = [Pmussave;VarFreqCosPmus(tspan(j)-tprev,T)]; %variable frequency
            end
        elseif tog==2
            Pmustemp=(Amus*cos(2*pi*f*(tspan-tprev)) + -Amus)'-0; %constant frequency
            Pmussave=[Pmussave; Pmustemp(2:end)];
        elseif tog==3
            Pmussave=[Pmussave;ones(ppp-1,1)*-Amus]; %constant
        elseif tog==4
            Pmussave = 0;
        end
        if mod(i,5)==0
            disp([i,VAmax*1000,VAmin*1000,f,VT*1000,VE*1000,Cdyn*1000,minPel])
        end
        tprev = tnext;
        tnext=tprev+T;
        tspan = [tprev:tstep:tnext];
        ppp=length(tspan);
        pend=periods(end)+T;
        periods=[periods pend];
    catch
        disp([i,VAmax*1000,VAmin*1000,f,VT*1000,VE*1000,Cdyn*1000,minPel])
        time=[]; sol=[];
        break
    end
end

disp(['disp([i,VAmax*1000,VAmin*1000,f,VT*1000,VE*1000,Cdyn*1000,minPel])'])
disp([times(end)]);

t=times;
Pel=sols(:,1);  Pve=sols(:,2);

Frec=alpha+(gamma-alpha)./(1+exp(-(Pel-cF)./dF));
Vel=VC*(1-exp(-k*Pel));
VA=Frec.*Vel+RV;

Rs = Rsd*exp(Ks*(VA-RV)./(Vstar-RV))+Rsm;
Pldyn=Pel+Pve;
PA=Pldyn+Pmussave;

Pao_dyn = stepfun(t,8,30,0);
Vdot=(Pao + Pao_dyn -PA)./Rs;


%%%%%%% FIGURES %%%%%%%  Laura didn't change any of these

set(groot,'defaultLineLineWidth',2, 'defaulttextInterpreter', 'latex', ...
    'defaultAxesFontSize', 16, 'defaultLegendInterpreter', 'latex')

figure
plot(VA*1000,Vdot*1000);%,'.')
xlabel('$V_A$')
ylabel('$\dot{V}$')

figure
plot(t,Rs,'.')
ylabel('$R_s$')
 xlabel('$t$')
grid on
%return

figure
plot(VA,Rs,'.')
ylabel('$R_s$')
 xlabel('$V_a$')
% ylabel('Pu')
grid on

load PVcurves.mat

start=T/tstep+1;

figure
subplot(411)
plot(t,PA,'.'); ylabel('$P_A$ (cmH$_2$O)'); %xlabel('time (s)')
% axis([0 NP -2 2])
subplot(412)
plot(t,Pel,'.'); ylabel('$P_{el}$ (cmH$_2$O)'); %xlabel('time (s)')
% axis([0 NP -10 0])
subplot(413)
plot(t,VA*1000,'.'); ylabel('$V_A$ (ml)'); %xlabel('time (s)')
% axis([0 NP 25 40])
subplot(414)
plot(t,-Vdot*1000,'.'); ylabel('$\dot{V}$ (ml/s)'); xlabel('time (s)')
% axis([0 NP -40 50])

figure
plot(Pel_range(2001:end), ...
    VA_range(2001:end)*1000,'r',Ptot(start:end),VolN(start:end)*1000,'g', ...
    'linewidth', 3); %,Pldyn(start:end)+Pcw(start:end),VA(start:end),'.'
hold on
plot(Pldyn(start:end),VA(start:end)*1000,'k','LineWidth',3)%'Color',[.6 .6 .6],
plot(P_FRC,FRC*1000,-P_FRC,FRC*1000,'Color',[.4 .4 .4],'Linestyle',':')
%title('$V$'); %,,'Ptot v. VA',
xlabel('Pressure (cm H$_2$O)', 'fontsize', 24)
ylabel('Volume (mL)', 'fontsize', 24)
axis([-5 35 RV*1000 60])%TLC0*1000
%line([0 0],[0 60],'Color',[.7 .7 .7])
%line([-5 35],[FRC*1000 FRC*1000],'Color',[.4 .4 .4],'Linestyle',':')
legend('Lung','Respiratory', ...
    'Ventilation','Location','Southeast', 'fontsize', 24);

% Pplmin=min(Ppl(start:end)); Pplmax=max(Ppl(start:end));
Vdotmin=min(Vdot(start:end)); Vdotmax=max(Vdot(start:end));

% save biomarkers10.mat VAmin VAmax minPel maxPel Pplmin Pplmax Vdotmin Vdotmax
% save states_highCw_normRu_0Pao.mat t Pmussave Ppl PA VA Vdot Pldyn


