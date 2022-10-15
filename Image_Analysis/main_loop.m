% find the first empty row in the Excel sheet
startingIndx = findEmptyRow('tissue_image_data.xlsx')+1;
%%
% loop over all slide ID's and calculate stats
for slide = 45:47
    % loop over all images belonging to slide ID
    for slideId = 1:5
        % +1 the index
        sheetRowNum = slideId+startingIndx;
        % find the corresponding image by title
        imageTitle = strcat(num2str(slide),'-',num2str(slideId));
        try
            im1 = imread(imageTitle+".tif");
        catch
            warning('Path not added or read all existing files.')
            break
        end
        % apply the entropy filter w structuring element of radius r1
        r2 = 0;
        r1= 34; %5um
        imEr = entropyFilter(r1, im1);
        % calculate the tissue fraction area (TFA)
        area1 = sum(imEr,'all');
        fraction = area1/numel(imEr) ;
        % create the skeleton to calculate the length1 of the centerline
        imSk = bwskel(imEr);
        length1 = sum(imSk,'all');
        % calculate the width from TFA and centerline length
        width = area1/length1;

        % % Save Data: Table and Binary Image  % %

        % set the day, currently manually
        % update to do: find the day from the lookup table
        day = 0;
        % set the correct range for inserting table in sheet
        range1 = strcat('A',num2str(sheetRowNum),':I',num2str(sheetRowNum));
        Table1 = table(day, slide,slideId,fraction,r1,r2,length1,area1,width);
        writetable(Table1, 'tissue_image_data.xlsx', 'Range',...
            range1,'WriteVariableNames',0)
        % save the binary image (entropy filtered)
        save(imageTitle+".mat","imEr")
    end
    startingIndx = sheetRowNum - 1;
    num2str(slide)+" done"
end


function rowIndx = findEmptyRow(fileName)
tempT = readtable(fileName);
rowIndx = size(tempT,1);
end
