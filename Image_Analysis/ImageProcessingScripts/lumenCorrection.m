% lumenCorrection.m
function lumenCorrection(slideVec, slideIdVec, day, writeT, sheetRowNum)
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
        

        CC = bwconncomp(~im1,8);

        Thresh = 0;% (pi*(34*4)^2);
        
        % find which lumens are cut with the boundaries of the image
        [exLumens,inLumens] = findExteriorLumens(CC);
        % % calculate the stored statistics % %
        % how many components/lumens
        % calculate the area of each connected component
        [~, ~, areaList] = count_lumens(CC,Thresh);
        
        % number of interior lumens
        num_int_lumens = length(inLumens);
        % number of interior lumens + (1/2) exterior lumens
        num_int_lumens_p_half_ext = length(inLumens)+length(exLumens)/2;
        % the area of each interior lumen
        areaList_int = areaList(inLumens);
        % the total area of all interior lumens
        total_int_area = sum(areaList_int,"all");
        % calculate the mean equivalent radius
        R_equiv_int = sqrt(areaList_int/pi); %/6.8;
        meanR_equiv_int = mean(mean(R_equiv_int));

        % calculate the radius corresponding...
        % to the midpoint in total area
        Rmidpoint_int = Requiv(areaList_int, total_int_area,R_equiv_int);
        
        % calculate a measure of crimpiness
        circularity = regionprops(CC,'Circularity');
        T_int = ones(1,num_int_lumens);
        for k = 1:num_int_lumens
            % the tortuosity is the inverse of 'circularity'
            % Perimeter^2/(4 pi Area)
            T_int(k) = 1./circularity(inLumens(k),1).Circularity;
        end
        % calculate the mean lumen toruosity
        T_int = mean(T_int);


        % % Save Data: Table  % %

        % set the correct range for inserting table in sheet
        switch writeT
            case 1
                range1 = strcat('I',num2str(sheetRowNum),':S',num2str(sheetRowNum));
                Table1 = table(day, slide,slideId,num_int_lumens_p_half_ext,num_int_lumens,total_int_area,...
                    meanR_equiv_int,Rmidpoint_int,T_int);
                writetable(Table1, 'interior_lumens_stats.xlsx', 'Range',...
                    range1,'WriteVariableNames',0)
        end
       
    end
    num2str(slide)+" done"
end
