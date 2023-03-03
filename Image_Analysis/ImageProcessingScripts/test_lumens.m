function test_lumens(CC,im1)

N = 5;
um = 5*N;
i = 1;
% tiledlayout(1,N,"TileSpacing","tight","Padding","tight")


for thresh = um.*((34^2)*pi)
    tic
    % x30 faster
    numPixels = cellfun(@numel,CC.PixelIdxList);
    idx = find(numPixels >= thresh);
    length(idx);
    sum(numPixels(idx),'all') 
    toc
    
    tic

    areaCC = regionprops(CC,'Area');
    areaFiltered = [areaCC.Area];
    areaFiltered = areaFiltered(areaFiltered >= thresh);
    sum(areaFiltered) %20 um
    % calculate the total area
    sum([areaCC.Area],'all');
    toc

%     BW = zeros(size(im1));
%     for k = idx
%         BW(CC.PixelIdxList{k}) = 1;
%     end

%     nexttile
% 
%     imshowpair(~im1,BW)
%     title("$\geq$ "+num2str(um(i))+" $um$ radius, " + num2str(length(idx))+ " components", "Interpreter","latex")
%     i = i+1;
end