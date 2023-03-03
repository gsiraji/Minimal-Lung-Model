% this is the main loop to run 4 different types of analysis
% imageProcess(),calculateAreas(), and lumenCorrection() all
% process images with titles of the from slideVec-slideIdVec.tif
% or binary images of the format slideVec-slideIdVec.mat
% ratloop() processes data of the structure provided by Smith's group

% % %

% set the row number in the spreadsheet used for writing the data
sheetRowNum = 207;
%% set the necessary variables for processing

% set the image ID numbers corresponding to
%   1 unique rat
slideVec = 1:24;

% the images are cropped into up to 10
%   smaller images. Select a subset of 
%   these images
slideIdVec = 1:10;




%% Main Loop



% N used to calculate the area of...
% the widest tissue sections
N = 10;

% doFilter = 1 applies entropy filtration to tif files
doFilter = 0;

% set the age of the rats
day = 7;

% writeTable = 1 writes the data into the spreadsheet
writeT = 1;

%  choose what type of analysis you would like to do
pickTheAnalysis = 'imageProcess';

switch pickTheAnalysis

    % process tif or binary images
    case 'imageProcess'
    imageProcess(slideVec, slideIdVec, day,...
        writeT, doFilter, sheetRowNum, N)
    
    % calculate the results of the pruning algorithm
    case 'calculateAreas'
    calculateAreas(slideVec, slideIdVec, day,...
        writeT, sheetRowNum)
    
    % find the percentage of lumens that get cropped in each image
    case 'lumenCorrection'
    lumenCorrection(slideVec,slideIdVec,day,writeT,sheetRowNum);

    % extract the biomechanical data from the ventilation study
    case 'ratLoop'
        ratLoop(dat0,0,34)
end
