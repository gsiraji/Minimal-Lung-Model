rowNum = 1;
slideVec = 35;
slideIdVec = [1];
N = 13;
for slide = slideVec
    for slideId = slideIdVec
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

        areas=ones(N,1);
        areas(1,1)=bwarea(im1);
        for i=11:N
            areas(i,1)=bwarea(imdilate(imerode(im1,strel("disk",round(6.8*5*i))),strel("disk",round(6.8*5*i))))
        end
%         plot(areas)


        range1 = strcat('A',num2str(rowNum),':L',num2str(rowNum));
        Table1 = table(slide,slideId,areas');
%         writetable(Table1, 'pruning_image_data.xlsx', 'Range',...
%             range1,'WriteVariableNames',0)
    end
    num2str(slide)+" done"

end
