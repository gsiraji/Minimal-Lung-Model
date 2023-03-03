function imageProcess(slideVec, slideIdVec, day, writeT,doFilter, sheetRowNum, N)

%%
% loop over all slide ID's and calculate stats
for slide = slideVec
    % loop over all images belonging to slide ID
    for slideId = slideIdVec
        
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

        % set the row index for where the tables will be written to
        sheetRowNum = 1+sheetRowNum;
        

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
%         length1 = lengths(sheetRowNum-1);
        length1 = sum(imSk,'all');
        % calculate the width from TFA and centerline length
        width = area1/length1;

        CC = bwconncomp(~im1,8);

        Thresh = 0;% (pi*(34*4)^2);
        

        % % calculate the stored statistics % %
        % how many components/lumens
        % calculate the area of each connected component
        [number_of_lumens, totalArea, areaList] = count_lumens(CC,Thresh);

        % calculate the mean equivalent radius
        R_equiv = sqrt(areaList/pi); %/6.8;
        meanR_equiv = mean(mean(R_equiv));

        % calculate the radius corresponding...
        % to the midpoint in total area
        Rmidpoint = Requiv(areaList, totalArea,R_equiv);

        % calculate a measure of crimpiness
        T_tilde = (length1/number_of_lumens)^2/(pi*totalArea/number_of_lumens);

        % calculate the area of the widest tissue sections
        areas = pruningAreas(im1,N);
   
        % % Save Data: Table and Binary Image  % %

        % set the correct range for inserting table in sheet
        switch writeT
            case 1
                range1 = strcat('B',num2str(sheetRowNum),':V',num2str(sheetRowNum));
                Table1 = table(day, slide,slideId,fraction,...
                    length1,width,number_of_lumens,meanR_equiv,Rmidpoint,T_tilde,areas');
                writetable(Table1, 'image_data_complete_oldMLI.xlsx', 'Range',...
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
