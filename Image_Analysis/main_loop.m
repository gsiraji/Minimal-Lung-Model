% find the first empty row in the Excel sheet
sheetRowNum = findEmptyRow('tissue_image_data.xlsx');
%% Main Loop

slideVec = 25:27;
slideIdVec = 1:5;
binIm = 1;
day = 0;
writeT = 0;
imageProcess(slideVec, slideIdVec, day,...
    binIm, writeT, sheetRowNum)





%% Functions

function rowIndx = findEmptyRow(fileName)
tempT = readtable(fileName);
rowIndx = size(tempT,1);
end