%cdf x is the time series, time*genes; i is the ith gene; 
function diffTraj=mytrajDiff(xSimulate,realTraj,weight)
    numPoints=size(realTraj,2);

    diffTraj=1/numPoints*1/size(realTraj,1)*sum((xSimulate'-realTraj).^2.*weight,2);

end