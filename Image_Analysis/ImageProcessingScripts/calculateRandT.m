% function calculateRandT(slideVec, slideIdVec,rowNum)
rowNum = 105;
slideVec = 16:47;
slideIdVec = 1:12;
tic
% loop over all slide ID's and calculate stats
for slide = slideVec
    % loop over all images belonging to slide ID
    for slideId = slideIdVec
        % find the corresponding image by title
        imageTitle = strcat(num2str(slide),'-',num2str(slideId));
        try
            im1 = load(imageTitle+".mat");
            im1 = im1.imEr;
        catch
            warning('Path not added or read all existing files.')
            break
        end
        % +1 the index
        rowNum = 1+rowNum;
        % calculate the length of the centerline
        imSk = bwskel(im1);
        length1 = sum(imSk,'all');
        % calculate the connected components
        CC = bwconncomp(~im1,8);
        % calculate the area of each connected component
        areaCC = regionprops(CC,'Area');
        % calculate the total area 
        totalArea = sum([areaCC.Area],'all');

        % % calculate the stored statistics % %
        % how many components/lumens
        number_of_lumens = CC.NumObjects;

        % calculate the mean equivalent radius
        R_equiv = sqrt([areaCC.Area]/pi)/6.8;
        meanR_equiv = mean(R_equiv);

        % calculate the radius corresponding...
        % to the midpoint in total area
        Rmidpoint = Requiv([areaCC.Area], totalArea,R_equiv);

        % calculate a measure of crimpiness
        T_tilde = (length1/number_of_lumens)^2/(pi*totalArea/number_of_lumens);

        % % Save Data: Table % %

        % set the correct range for inserting table in sheet
        range1 = strcat('A',num2str(rowNum),':F',num2str(rowNum));
        Table1 = table(slide,slideId,number_of_lumens,meanR_equiv,Rmidpoint,T_tilde);
        writetable(Table1, 'tissue_image_stats.xlsx', 'Range',...
            range1,'WriteVariableNames',0)
    end
    num2str(slide)+" done"
end
toc