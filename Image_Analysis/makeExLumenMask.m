mask1 = zeros(size(im1));

for pixelListIndx = exLumens'

    mask1(CC.PixelIdxList{1,pixelListIndx}) = 1;

end