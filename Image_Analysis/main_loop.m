for slideId = 1:9
day = 1;
slide = 11;
% slideId = 3;
processedImages = slideId+30;
imageTitle = strcat(num2str(slide),'-',num2str(slideId));
range1 = strcat('A',num2str(processedImages),':I',num2str(processedImages));
im1 = imread(imageTitle+".tif");
r = 34;
se = strel('disk', r,4);
imEnt = entropyFilter(r, im1);
imEr = imerode(imEnt,se);

imSk = bwskel(imEr);
% imshowpair(im1,imEr,'montage')
area1 = sum(imEr,'all');
fraction = area1/numel(imEr) ;
length1 = sum(imSk,'all');
lengthOverArea = length1/area1;
Table1 = table(day, slide,slideId,fraction,r,r,length1,area1,lengthOverArea);
% writetable(Table1, 'tissue_image_data.xlsx', 'Range',...
%     range1,'WriteVariableNames',0)
end
