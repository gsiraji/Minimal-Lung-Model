% findEdgeLumens.m
% stores the indices for objects in CC that lie on the edges of the image
% 
% inputs:
%     CC - connected components structure from bwconncomp  
%     
% outputs:
%     exLumens - CC index of exterior lumens, ...
%     e.g. CC.PixelIdxList{1,exLumens'} ...
%     is Pixel Index List for exterior lumens 
%    
%     inLumens - CC index of interior lumens 
%
% by Gess Kelly (2023) for WiMB project



function [exLumens,inLumens] = findExteriorLumens(CC)

% create a vector of the linear indices of pixels...
% that lie on the boundary of the image
rows = CC.ImageSize(1,1);
cols = CC.ImageSize(1,2);
indices = [[ones(cols,1),(1:cols)'];[ones(cols,1).*(rows-1),(1:cols)'];[(1:rows)',ones(rows,1)];[(1:rows)',ones(rows,1).*(cols-1)]];
ind = sub2ind(size(im1),indices(:,1),indices(:,2));

% initiate the index vectors
exLumens = zeros(1,CC.NumObjects);
inLumens = zeros(1,CC.NumObjects);

% iterate over all objects in CC
for k = 1:CC.NumObjects
    
    % create an array of pixel indices of the kth object
    PixelList=CC.PixelIdxList{1,k};
    
    % see if any exterior pixel indices belong to PixelList
    C = intersect(PixelList,ind);
    % add the lumen indx to exLumens if it has boundary pixels
    if ~isempty(C)
        exLumens = [exLumens;k];
    else
        inLumens = [inLumens;k];
    end

end
% remove the zero elements from output arrays
inLumens = nonzeros(inLumens);
exLumens = nonzeros(exLumens);
