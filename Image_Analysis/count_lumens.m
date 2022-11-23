function [number_of_lumens, totalArea] = count_lumens(CC,Threshold)
numPixels = cellfun(@numel,CC.PixelIdxList);
idx = find(numPixels >= Threshold);
number_of_lumens = length(idx);
totalArea = sum(numPixels(idx),'all');