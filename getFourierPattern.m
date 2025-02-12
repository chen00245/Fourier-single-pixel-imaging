function [ Pattern ] = getFourierPattern( amp, mRow, nCol, fx, fy, initPhase )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    PATTERN_GENERATION_MODE = 1;
    
    switch PATTERN_GENERATION_MODE
        case 1
            fxArr = fftshift([0:nCol-1] / nCol);
            fyArr = fftshift([0:mRow-1] / mRow);
            
            iRow = find(fyArr == fy);
            jCol = find(fxArr == fx);
            
            spec = zeros(mRow, nCol);
            spec(iRow,jCol) = amp * mRow * nCol * exp(1i*initPhase);
            Pattern = (amp + amp * real(ifft2(ifftshift(spec)))) / 2;
        case 2
            [X,Y]=meshgrid(linspace(0,nCol-1,nCol), linspace(0,mRow-1,mRow));
            Pattern = (amp*exp(1i*(2*pi*(fx*X+fy*Y)+initPhase))+1)/2;
            Pattern = real(Pattern);
    end
    
end

