function P=VarFreqCosPmus(t,T)

% global i
PmusMin=-4.2;%-7.4;%-6.4*1.1;
p0=0;

Ti=T*.4;
Te=T*.6;
tau=T/5;
% if i==1
    if (t >= 0) && (t <= Ti)
        P = p0+(PmusMin-p0)*0.5*(1-cos(pi*t./Ti));  % Ts = TM in thesis
%         P = p0-PmusMin/(Ti*Te)*t.^2+PmusMin*T/(Ti*Te)*t;
%           P = 0+PmusMin*t/Ti;
    elseif (t > Ti) && (t <= Ti+Te);
%         P = PmusMin;
        P = p0+(PmusMin-p0)*0.5*(cos((pi./Te)*(t-Ti))+1);
%         P = PmusMin/(1-exp(-Te/tau))*(exp(-(t-Ti)/tau)-exp(-Te/tau));
%         P=0+-PmusMin*(t-T)/(T-Ti);
%         P = p0-PmusMin/(Ti*Te)*t.^2+PmusMin*T/(Ti*Te)*t;
    else
        P = p0;
    end
% else
%     if (t >= 0) && (t <= Ti)
%         P = p0+(PmusMin-p0)*0.5*(1-cos(pi*t./Ti))*.1;  % Ts = TM in thesis
%     elseif (t > Ti) && (t <= Ti+Te)
%         P = p0+(PmusMin-p0)*0.5*(cos((pi./Te)*(t-Ti))+1)*.1;
%     else
%         P = p0;
%     end
% end
    