close all
clear all

global  tog

tog=2; % 1 for VarFreq, 2 for cosine, 3 for constant

load_VentilationModel_pars
NP=3; %Number of periods
VentilationModel_solver(NP) 
