function [dpdt] =VentilationModel(t,p,T,tprev)

global Ks Vstar RV
global Amus f Cve Rve Rsd Rsm
global cF dF k beta gamma alpha VC 
global tog Pao

Pel = p(1);
Pve = p(2);

Pao_dyn = stepfun(t,8,30,0);

%%% Toggle for muscle pressure drive function
if tog==1
    Pmus=VarFreqCosPmus(t-tprev,1/f);
elseif tog==2
    Pmus = (Amus*cos(2*pi*f*(t-tprev)) + -Amus)-0;
elseif tog==3
    Pmus = -Amus;
elseif tog==4
    Pmus = 0;
end

Frec=alpha+(gamma-alpha)./(1+exp(-(Pel-cF)/dF));
Vel=VC*(1-exp(-k*Pel));
VA=Frec*Vel+RV;

CA = VC*k*exp(-Pel*k)*((gamma + exp(-cF/dF)*(gamma - beta*(exp(cF/dF) + 1)))/(exp(-(Pel - cF)/dF) + 1) -...
    exp(-cF/dF)*(gamma - beta*(exp(cF/dF) + 1))) +...
    (exp(-(Pel - cF)/dF)*(gamma + exp(-cF/dF)*(gamma - beta*(exp(cF/dF) + 1)))*(VC - VC*exp(-Pel*k)))/(dF*(exp(-(Pel - cF)/dF) + 1)^2);

Pldyn=Pel+Pve;
PA=Pldyn+Pmus;

Rs =  Rsd*exp(Ks*(VA-RV)/(Vstar-RV))+Rsm;
Vdot=(Pao+Pao_dyn-PA)/Rs;

dpdt = [(Vdot)/CA; ...            %Pel
        (Vdot-Pve/Rve)/Cve];          %Pve

