% find the first empty row in the Excel sheet
sheetRowNum = 207;% findEmptyRow('tissue_image_data.xlsx');
% addpath("/Users/tfai/Documents/research_misc/wimb2022/images/MLI_old_tiff/MLI_old_D0")
%% Main Loop

% ratLoop(dat0,0,34)



slideVec = 1:24;
slideIdVec = 1:10;

% N used to calculate the area of...
% the widest tissue sections
N = 10;

doFilter = 0;
day = 7;
writeT = 1;
% imageProcess(slideVec, slideIdVec, day,...
%     writeT, doFilter, sheetRowNum, N)

% calculateAreas(slideVec, slideIdVec, day,...
%     writeT, sheetRowNum)

lumenCorrection(slideVec,slideIdVec,day,writeT,sheetRowNum)

%%
% T = readtable("image_data_complete_oldMLI.xlsx");
% lengths = T{:,6};

%% Functions

function rowIndx = findEmptyRow(fileName)
tempT = readtable(fileName);
rowIndx = size(tempT,1);
end