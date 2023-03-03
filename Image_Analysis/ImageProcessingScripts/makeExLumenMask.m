
% this mask is used for visualization purposes
% to double check that the code is working
mask1 = zeros(size(im1));

for pixelListIndx = exLumens'

    mask1(CC.PixelIdxList{1,pixelListIndx}) = 1;

end