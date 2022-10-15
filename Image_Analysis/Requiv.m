% Requiv.m

CC = bwconncomp(~imEr,8);

%%
areaCC = regionprops(CC,'Area');
%%
histogram(sqrt([areaCC.Area]/pi)/6.8,20)

%%

mean(sqrt([areaCC.Area]/pi)/6.8)