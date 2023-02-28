function calculateAreas(slideVec, slideIdVec, day, writeT, sheetRowNum)
%%% commented out areas
%%
% loop over all slide ID's and calculate stats
for slide = slideVec
    % loop over all images belonging to slide ID
    for slideId = slideIdVec
        
        % find the corresponding image by title
        imageTitle = strcat(num2str(slide),'-',num2str(slideId));

                try
                    im1 = load(imageTitle+".mat").im1;
                catch
                    warning('Path not added or read all existing files.')
                    break
                end

        % +1 the index
        sheetRowNum = 1+sheetRowNum;
        

        % calculate the area of the widest tissue sections
        areas = pruningAreas(im1,1);

        % % Save Data: Table  % %

        % set the correct range for inserting table in sheet
        switch writeT
            case 1
                range1 = strcat('I',num2str(sheetRowNum),':M',num2str(sheetRowNum));
                Table1 = table(day, slide,slideId,areas');
                writetable(Table1, 'image_data_areas.xlsx', 'Range',...
                    range1,'WriteVariableNames',0)
        end
       
    end
    num2str(slide)+" done"
end
