fig1 = tiledlayout(1,4);

l1 = 1200;
l2 = 3000;

nexttile
imshow(im0(l1:l2,l1:l2,:))

% Create the label
annotation('textbox',[0.07 0.7 0.156 0.11],'Color',[1 1 1],...
    'VerticalAlignment','middle',...
    'String','Initial Tissue Image',...
    'HorizontalAlignment','center',...
    'FontSize',28,...
    'FontName','Times New Roman',...
    'FitBoxToText','off',...
    'BackgroundColor',[0.149019607843137 0.149019607843137 0.149019607843137]);

nexttile
imshow(imEntropy(l1:l2,l1:l2))
% Create the label
annotation('textbox',[0.3 0.7 0.156 0.11],'Color',[1 1 1],...
    'VerticalAlignment','middle',...
    'String','Entropy Filtered Image',...
    'HorizontalAlignment','center',...
    'FontSize',28,...
    'FontName','Times New Roman',...
    'FitBoxToText','off',...
    'BackgroundColor',[0.149019607843137 0.149019607843137 0.149019607843137]);


nexttile
imshow(im1(l1:l2,l1:l2))
% Create the label
annotation('textbox',[0.5 0.7 0.156 0.11],'Color',[1 1 1],...
    'VerticalAlignment','middle',...
    'String','Otsu Thresholding',...
    'HorizontalAlignment','center',...
    'FontSize',28,...
    'FontName','Times New Roman',...
    'FitBoxToText','off',...
    'BackgroundColor',[0.149019607843137 0.149019607843137 0.149019607843137]);


nexttile
imshow(imSk(l1:l2,l1:l2))

% Create the label
annotation('textbox',[0.75 0.7 0.156 0.11],'Color',[1 1 1],...
    'VerticalAlignment','middle',...
    'String','Skeletonized Image',...
    'HorizontalAlignment','center',...
    'FontSize',28,...
    'FontName','Times New Roman',...
    'FitBoxToText','off',...
    'BackgroundColor',[0.149019607843137 0.149019607843137 0.149019607843137]);


% Create arrow 1
annotation('textarrow',[0.24 0.28],...
    [0.52 0.52],'LineWidth',20,'HeadWidth',50,...
    'HeadLength',30);

% Create arrow 2
annotation('textarrow',[0.48 0.52],...
    [0.52 0.52],'LineWidth',20,'HeadWidth',50,...
    'HeadLength',30);

% Create arrow 3
annotation('textarrow',[0.72 0.76],...
    [0.52 0.52],'LineWidth',20,'HeadWidth',50,...
    'HeadLength',30);


% The schematic shows our process for producing the centerlines for the
% tissue which we use for calculating the tissue width and length. First,
% we apply an entropy filter using a structuring element of $5 \mu m$ to
% the image to prepare the image for binarization. Then, we use the default
% thresholding algorithm on MATLAB (Otsu) to binazrize the image. Lastly,
% we skeletonize the image to extract the tissue centerlines. The images
% shown here are zoomed in to show details and help with visibility of the centerlines. 


