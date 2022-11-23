function imageProcess(slideVec, slideIdVec, day, writeT,doFilter, sheetRowNum, N)
%%% commented out areas
%%
% loop over all slide ID's and calculate stats
for slide = slideVec
    % loop over all images belonging to slide ID
    for slideId = slideIdVec
        % +1 the index
        sheetRowNum = 1+sheetRowNum;
        % find the corresponding image by title
        imageTitle = strcat(num2str(slide),'-',num2str(slideId));
        
        switch doFilter
            case 1
                try
                    im1 = imread(imageTitle+".tif");
                catch
                    warning('Path not added or read all existing files.')
                    break
                end
            case 0
                try
                    im1 = load(imageTitle+".mat").im1;
                catch
                    warning('Path not added or read all existing files.')
                    break
                end

        end
        
        % apply the entropy filter w structuring element of radius r1
        r1= 34; %5um
        switch doFilter
            case 1
                im1 = entropyFilter(r1, im1);
        end
        % calculate the tissue fraction area (TFA)
        area1 = sum(im1,'all');
        fraction = area1/numel(im1) ;
        % create the skeleton to calculate the length1 of the centerline
        imSk = bwskel(im1);
        length1 = sum(imSk,'all');
        % calculate the width from TFA and centerline length
        width = area1/length1;

        CC = bwconncomp(~im1,8);
        % calculate the area of each connected component
        areaCC = regionprops(CC,'Area');
        areaFiltered = [areaCC.Area];
        areaFiltered = (areaFiltered > (pi*(34*4)^2)); %20 um
        % calculate the total area 
        totalArea = sum([areaCC.Area],'all');

        % % calculate the stored statistics % %
        % how many components/lumens
        number_of_lumens = length(areaFiltered);

        % calculate the mean equivalent radius
        R_equiv = sqrt(areaFiltered/pi)/6.8;
        meanR_equiv = mean(mean(R_equiv));

        % calculate the radius corresponding...
        % to the midpoint in total area
        Rmidpoint = Requiv(areaFiltered, totalArea,R_equiv);

        % calculate a measure of crimpiness
        T_tilde = (length1/number_of_lumens)^2/(pi*totalArea/number_of_lumens);

        % calculate the area of the widest tissue sections
%         areas = pruningAreas(im1,N);
          areas = zeros(N,1);   
        % % Save Data: Table and Binary Image  % %

        % set the day, currently manually
        % update to do: find the day from the lookup table
%         day = 0;
        % set the correct range for inserting table in sheet
        switch writeT
            case 1
                range1 = strcat('A',num2str(sheetRowNum),':V',num2str(sheetRowNum));
                Table1 = table(day, slide,slideId,fraction,r1,...
                    length1,width,number_of_lumens,meanR_equiv,Rmidpoint,T_tilde,areas');
                writetable(Table1, 'tissue_image_corrected_lumens.xlsx', 'Range',...
                    range1,'WriteVariableNames',0)
        end
        % save the binary image (entropy filtered)
        switch doFilter
            case 1
                switch day
                    case 0
                        save("binaryImagesOldMLI/"+imageTitle+".mat","im1")
                    case 7
                        save("binaryImagesOldMLI/D7/"+imageTitle+".mat","im1")
                end
        end
    end
    num2str(slide)+" done"
end
