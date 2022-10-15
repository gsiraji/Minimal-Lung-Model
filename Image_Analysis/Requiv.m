% Requiv.m

CC = bwconncomp(~imEr,8);

%%
areaCC = regionprops(CC,'Area');
%%
histogram(sqrt([areaCC.Area]/pi)/6.8,20)

%%

Requ = (sqrt([areaCC.Area]/pi)/6.8);

%%
totalArea = sum([areaCC.Area],'all');
cmArea = cumsum([areaCC.Area]);

totalArea/2;

midCmArea = cmArea(and(cmArea > totalArea/2 - 15000,cmArea < totalArea/2 + 15000 ));
Requ((cmArea == midCmArea))

%%
plot(cmArea);hold on
