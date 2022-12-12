function Rmidpoint = Requiv(area1, totalArea,R_equiv)

% calculate the cumulative area
[area,indx] = sort(area1);
R_equiv = R_equiv(indx);
cmArea = cumsum(area);
% calculate the half area
midPoint = totalArea/2;
%  % find the closest value in cumulative area % %
% first find the distance
distCmArea = abs(cmArea - midPoint);
% now calculate the index for...
% minimum which is the closest value
[~, minIndx] = min(distCmArea,[] ,'all');
% find the Requivalent corresponding to...
% the midpoint in total tissue area
Rmidpoint = R_equiv(minIndx);
