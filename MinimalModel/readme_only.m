%%% README FILE

%%% necessary codes

% driver.m runs the whole code
% load_VentilationModel_pars.m loads all the parameters
% VentilationModel_solver.m runs the solver (ode15s) and plots
% VentilationModel.m is the ODE and auxiliary equations

% driver.m calls load_VentilationModel_pars.m and VentilationModel_solver.m
% VentilationModel_solver.m calls VentilationModel.m and uses PVcurves.mat



%%% other codes, remove?

% VarFreqCosPmus.m is a cosine-based diaphragm pressure function with
% variable inspiration/expiration fraction

% SSvolumes.m calculates the steady-state volumes of Pel and Vc according
% to a constant airflow (M). This code is probably irrelevant now.

% test_curves_preterm.m creates the the lung and chest wall compliance curves 
% then calculates FRC (volume) at Pel=0, which is the volume where Pchest
% + Plung = 0 and the curves mirror each other over the P axis. The file
% PVcurves.mat stores these curves and FRC information.