% find the first empty row in the Excel sheet
sheetRowNum = 213;% findEmptyRow('tissue_image_data.xlsx');
addpath("/Users/tfai/Documents/research_misc/wimb2022/images/MLI_old_tiff/MLI_old_D7")
%% Main Loop

slideVec = 15:20;
slideIdVec = 1:5;
N = 10;


day = 0;
writeT = 1;
imageProcess(slideVec, slideIdVec, day,...
    writeT, sheetRowNum, N)





%% Functions

function rowIndx = findEmptyRow(fileName)
tempT = readtable(fileName);
rowIndx = size(tempT,1);
end