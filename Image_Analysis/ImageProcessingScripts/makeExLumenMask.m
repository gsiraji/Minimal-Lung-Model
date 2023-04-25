function mask1 = makeExLumenMask(im1)
% this mask is used for visualization purposes
% to double check that the code is working

imbin = imbinarize(im1);
CC = bwconncomp(~imbin);
[exLumens,~] = findExteriorLumens(CC);
mask1 = zeros(size(imbin));

for pixelListIndx = exLumens'

    mask1(CC.PixelIdxList{1,pixelListIndx}) = 1;

end