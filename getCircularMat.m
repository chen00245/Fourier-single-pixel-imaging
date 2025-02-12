%% By Zibang Zhang
% Initialized on XX/XX/XXXX
% Revised on 25/09/2021. mRow ~= nCol supported
% Revised on 14/02/2022. rewritten, much faster, simplier

function [ CircularMat ] = getCircularMat( mRow, nCol)
xArr = [1:nCol];
yArr = [1:mRow];
CenterX = round(nCol/2) + 1;
CenterY = round(mRow/2) + 1;

[xGrid, yGrid] = meshgrid(xArr, yArr);

xGrid = xGrid - CenterX;
yGrid = yGrid - CenterY;

[thetaGrid, rhoGrid] = cart2pol(xGrid, yGrid);

WeightGrid = 10000 * rhoGrid + thetaGrid;
[Val, Ind] = sort(WeightGrid(:));

CircularMat = zeros(mRow,nCol);
for index = 1:mRow*nCol
   CircularMat(Ind(index)) = index;    
end




% % if radius is not a positive number, the code will generate a circular
% % path full of a matrix
% % Check pre-generated data
% CenterX = round(nCol/2) + 1;
% CenterY = round(mRow/2) + 1;
% Radius = 0;
% 
% if mRow > nCol
%     nPixel = mRow;
% else
%     nPixel = nCol;
% end
% 
% Center2TopDistance = abs(CenterY - 1 + 1) ;
% Center2BottomDistance  = abs(CenterY - nPixel + 1);
% Center2LeftDistance = abs(CenterX - 1 + 1);
% Center2RightDistance = abs(CenterX - nPixel + 1);
% 
% MaxDistanceX = max([Center2LeftDistance Center2RightDistance]);
% MaxDistanceY = max([Center2TopDistance Center2BottomDistance]);
% 
% FullRadius = round(sqrt((MaxDistanceX+1).^2  + (MaxDistanceY+1) .^ 2));
% 
% [CenteredCircularPath, CenteredCircularCX, CenteredCircularCY] = getCenteredCircularPath(FullRadius);
% 
% [MROW, NCOL] = size(CenteredCircularPath);
% yArr = [1:MROW];
% xArr = [1:NCOL];
% [xGrid, yGrid] = meshgrid(xArr, yArr);
% 
% if Radius > 0
%     CenteredCircularPath((xGrid - CenteredCircularCX).^2 + ...
%         (yGrid - CenteredCircularCY).^2 > Radius^2) = 0;
% end
% 
% % Resizing
% CircularMat = imresize(CenteredCircularPath, [mRow nCol], 'nearest');
% CircularMat = rot90(CircularMat, 2);
% 
% %% Reorder
% [CircularPathValSorted, CircularPathValSortedInd] = sort(CircularMat(:));
% 
% if length(unique(CircularPathValSorted)) ~= mRow*nCol
%     error('Error occured in circular path generation. \n length(unique(CircularPathValSorted)) ~= mRow*nCol');
% end
% 
% CircularPath1D = zeros(mRow * nCol, 1);
% for iElement = 1:mRow*nCol
%     CircularPath1D(CircularPathValSortedInd(iElement)) = iElement;
% end
% 
% CircularMat = reshape(CircularPath1D, [mRow nCol]);
% 
% end
% 
% function [CenteredCircularPath, CenteredCircularCX, CenteredCircularCY] = getCenteredCircularPath(Radius)
% mRow = 2 * Radius + 3;
% nCol = mRow;
% 
% CenteredCircularCX = round(mRow/2);
% CenteredCircularCY = round(nCol/2);
% 
% xArr = [1:nCol];
% yArr = [1:mRow];
% [xGrid, yGrid] = meshgrid(xArr, yArr);
% 
% xGrid = xGrid - CenteredCircularCX;
% yGrid = yGrid - CenteredCircularCY;
% 
% [thetaGrid, rhoGrid] = cart2pol(xGrid, yGrid);
% 
% rhoGridArr = sort(unique(rhoGrid(:)));
% thetaGridArr = sort(unique(thetaGrid(:)));
% 
% CenteredCircularPath = zeros(mRow, nCol);
% flagMat = zeros(mRow, nCol);
% count = 1;
% for iRho = 1:length(rhoGridArr)
%     thisRho = rhoGridArr(iRho);
%     thetaArr = sort(unique(thetaGrid(rhoGrid == thisRho)));
%     
%     for itheta = 1:length(thetaArr)
%         [jCol, iRow] = pol2cart(thetaArr(itheta), thisRho);
%         jCol = round(jCol) + CenteredCircularCY;
%         iRow = round(iRow) + CenteredCircularCX;
%         if flagMat(iRow, jCol) == 0
%             CenteredCircularPath(iRow, jCol) = count;
%             count = count + 1;
%         end
%     end
% end
% 
% end
% 
