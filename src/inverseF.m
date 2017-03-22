% x is a float 
function invfx=inverseF(xValue,fittingData,genei)
    %old
    invfx = -fittingData(2,genei)*log(1./xValue-1)+fittingData(1,genei); %1/(1+exp(-(x(gene)-mixedmu)/mixedtheta));
    %new
%     syms x
%     invfx=double(subs(fittingDataInverse{genei},x,xValue));
end