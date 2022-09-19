%% entropyFilter.m

% input: 
%           im1: the lung slide image
%           r: radius of the structuring element     
%           T: binarization threshold
% output: 
%           entropyIm: the binazrized entropy filtered figure
%
% Last edit: Gess Kelly, Aug 29 2022


function entropyIm = entropyFilter(r, im1, varargin)

% allTitles = {'original', 'filter'};
    % % % 
    im1 = im1(:,:,1:3);
    % % %
    se = strel('disk', r,4);
    % apply the entropy filter
    imEntropy = entropyfilt(im1, se.Neighborhood);
    % rescale the entropy filtered image
    imEntropy = (rescale(imEntropy));
    % grayscale the image
    imGray = rgb2gray(imEntropy);
    % binarize the entropy filtered grayscale image
    switch nargin
        case 2
            entropyIm = imbinarize(imGray);
%             entropyIm = imerode(entropyIm,se);
        case 3
            entropyIm = imbinarize(imGray,varargin{1});
%             entropyIm = imerode(entropyIm,se);
    end
    
end