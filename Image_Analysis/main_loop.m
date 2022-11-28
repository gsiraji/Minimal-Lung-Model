% find the first empty row in the Excel sheet
sheetRowNum = 69;% findEmptyRow('tissue_image_data.xlsx');
% addpath("/Users/tfai/Documents/research_misc/wimb2022/images/MLI_old_tiff/MLI_old_D7")
%% Main Loop

slideVec = 15:23;
slideIdVec = 1:5;

% N used to calculate the area of...
% the widest tissue sections
N = 10;

doFilter = 0;
day = 0;
writeT = 1;
imageProcess(slideVec, slideIdVec, day,...
    writeT, doFilter, sheetRowNum, N,lengths)

%%
% T = readtable("image_data_complete_oldMLI.xlsx");
% lengths = T{:,6};

%% Functions

function rowIndx = findEmptyRow(fileName)
tempT = readtable(fileName);
rowIndx = size(tempT,1);
end