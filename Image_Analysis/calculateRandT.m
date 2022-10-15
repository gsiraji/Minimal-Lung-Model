% function calculateRandT(slideVec, slideIdVec,rowNum)
rowNum = 5;
slideVec = 2:47;
slideIdVec = 1:12;
tic
% loop over all slide ID's and calculate stats
for slide = slideVec
    % loop over all images belonging to slide ID
    for slideId = slideIdVec
        % +1 the index
        rowNum = 1+rowNum;
        % find the corresponding image by title
        imageTitle = strcat(num2str(slide),'-',num2str(slideId));
        try
            im1 = load(imageTitle+".mat");
            im1 = im1.imEr;
        catch
            warning('Path not added or read all existing files.')
            break
        end
        % 
        % calculate the connected components
        CC = bwconncomp(~im1,8);
        % how many components/lumens
        number_of_lumens = CC.NumObjects;
        % calculate the area of each connected component
        areaCC = regionprops(CC,'Area');
        % calculate the mean equivalent radius
        R_equiv = mean(sqrt([areaCC.Area]/pi)/6.8);
        % % Save Data: Table % %

        % set the correct range for inserting table in sheet
        range1 = strcat('A',num2str(rowNum),':D',num2str(rowNum));
        Table1 = table(slide,slideId,number_of_lumens,R_equiv);
        writetable(Table1, 'tissue_image_stats.xlsx', 'Range',...
            range1,'WriteVariableNames',0)
    end
    num2str(slide)+" done"
end
toc