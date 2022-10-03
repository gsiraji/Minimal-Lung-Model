startingIndx = findEmptyRow('tissue_image_data.xlsx');
%%
for slideId = 1:10
day = 1;
slide = 27;
% slideId = 3;
processedImages = slideId+startingIndx;
imageTitle = strcat(num2str(slide),'-',num2str(slideId));
range1 = strcat('A',num2str(processedImages),':I',num2str(processedImages));
im1 = imread(imageTitle+".tif");
r2 = 0;
r1= 34; %5um
imEr = entropyFilter(r1, im1);
% se = strel('disk', r,4);imEr = imerode(imEnt,se);

imSk = bwskel(imEr);
% imshowpair(im1,imEr,'montage')
area1 = sum(imEr,'all');
fraction = area1/numel(imEr) ;
length1 = sum(imSk,'all');
lengthOverArea = length1/area1;
Table1 = table(day, slide,slideId,fraction,r1,r2,length1,area1,lengthOverArea);
writetable(Table1, 'tissue_image_data.xlsx', 'Range',...
    range1,'WriteVariableNames',0)
end


function rowIndx = findEmptyRow(fileName)

tempT = readtable(fileName);
rowIndx = size(tempT,1);

end
