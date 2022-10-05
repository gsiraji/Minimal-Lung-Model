% find the first empty row in the Excel sheet
startingIndx = findEmptyRow('tissue_image_data.xlsx');
%%
% loop over all slide ID's and calculate stats
for slide = 11
    % loop over all images belonging to slide ID
    for slideId = 1:2
        % +1 the index
        processedImages = slideId+startingIndx;
        % find the corresponding image by title
        imageTitle = strcat(num2str(slide),'-',num2str(slideId));
        try
            im1 = imread(imageTitle+".tif");
        catch
            warning('Read all existing files.')
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
        day = 7;
        % set the correct range for inserting table in sheet
        range1 = strcat('A',num2str(processedImages),':I',num2str(processedImages));
        Table1 = table(day, slide,slideId,fraction,r1,r2,length1,area1,width);
        writetable(Table1, 'tissue_image_data.xlsx', 'Range',...
            range1,'WriteVariableNames',0)
        % save the binary image (entropy filtered)
        save(imageTitle+".mat","imEr")
    end
end


function rowIndx = findEmptyRow(fileName)
tempT = readtable(fileName);
rowIndx = size(tempT,1);
end
