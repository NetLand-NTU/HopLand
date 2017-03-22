%cdf x is the time series, time*genes; i is the ith gene; 
function diffCDF=mycdfDiff(xSimulate,xReal,realTraj,fittingDataTemp)
    xRealNorm=xReal;
    
    numPoints=size(realTraj,2);
    

    %%
    diffCDF=zeros(1,size(xRealNorm,2));
    for genei=1:size(xRealNorm,2)
        temp=xSimulate(genei,:)';
            
        % hist
        [Y,I1]=sort(temp);
        [Y2,I2]=sort(I1);
        
        %[N2,X]=hist(xReal(:,genei),Y);
        %DF_real=cumsum(N2/sum(N2));
        p = fittingDataTemp((genei-1)*3+1,:);
        len=4-length(find(p==0));
        

        MU = fittingDataTemp((genei-1)*3+2,1:len)';
        if len==1
            SIGMA = cat(3,fittingDataTemp((genei-1)*3+3,1));
        elseif len==2
            SIGMA = cat(3,fittingDataTemp((genei-1)*3+3,1),fittingDataTemp((genei-1)*3+3,2));
        elseif len==3
            SIGMA = cat(3,fittingDataTemp((genei-1)*3+3,1),fittingDataTemp((genei-1)*3+3,2),fittingDataTemp((genei-1)*3+3,3));
        elseif len==4
            SIGMA = cat(3,fittingDataTemp((genei-1)*3+3,1),fittingDataTemp((genei-1)*3+3,2),fittingDataTemp((genei-1)*3+3,3),fittingDataTemp((genei-1)*3+3,4));
        end
        p = fittingDataTemp((genei-1)*3+1,1:len)';
        obj = gmdistribution(MU,SIGMA,p);
        DF_real= cdf(obj,Y);

        N1=hist(xSimulate(:,genei),Y);
        DF=cumsum(N1/sum(N1));
        
        diffs=(DF_real'-DF).^2;
        
        diffCDF(genei)=sum(diffs);
    end
    
    diffCDF=diffCDF/size(xRealNorm,2)/numPoints;
    

end