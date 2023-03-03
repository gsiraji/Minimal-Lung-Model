% build the figure of largest components

function imBinarymaskfill = compFig(imBinary,n)
    CC4 = bwconncomp(imBinary,4);
    maskIdx = largeComps(CC4.PixelIdxList, n);
%     % show all the large components
    imBinarymask = zeros(size(imBinary));
    imBinarymask(maskIdx) = 1;
    % fill in the grains
    imBinarymaskfill = imfill(imBinarymask,'holes');
%     imshow(imBinarymaskfill)
%     title(strcat('$r = $',32, num2str(r)), 'fontsize', 24, 'fontname', 'Times New Roman', 'Interpreter','latex')

%     title(allTitles{i}, 'fontsize', 24, 'fontname', 'Times New Roman',...
%         'Interpreter','latex')

end