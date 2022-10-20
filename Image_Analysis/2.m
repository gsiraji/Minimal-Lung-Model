allAreaData = readtable('pruning_image_data.xlsx');

plot(1:10, table2array(allAreaData(:,3:12)))


%%
addpath("tfai/Documents/research_misc/wimb2022/images/d7_tiff_11")


%%
im1 = imread("35-3.tiff");
%%
figure(2);imshow(im1)

