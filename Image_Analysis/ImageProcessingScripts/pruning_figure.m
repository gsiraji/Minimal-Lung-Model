
%
%
%
titles = ["(a)","(b)","(c)","(d)"];
tz = tiledlayout(1,4);
tz.Padding = "tight";
tz.TileSpacing = 'tight';
% function areas = pruningAreas(im1,N)
% initiate the array of remaining tissue areas
areas=ones(N+1,1);
% store the tissue area first
areas(1,1)=bwarea(im1);
nexttile
imshow(im1(l1:l2,l1:l2))
title(titles(1),"FontSize",24,"FontName","Times","Position",[0.3 1])
for i=1:N
    % construct a structuring element (radius in um)
    se = strel("disk",round(6.8*5*i));
    % apply erosion and dilation... 
    % to only leave out the wider tissue
    area1 = imerode(im1,se);
    area1 = imdilate(area1,se);
    nexttile
    imshow(area1(l1:l2,l1:l2))
    title(titles(i+1),"FontSize",24,"FontName","Times","Position",[0.3 1])
    % store the remaining area
    areas(i+1,1)=bwarea(area1);
end