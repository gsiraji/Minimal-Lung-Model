close all

global  tog

tog=4; % 1 for VarFreq, 2 for cosine, 3 for constant, 4 for zero

load_VentilationModel_pars
NP=15; %Number of periods
VentilationModel_solver(NP) 
