function [g,xSimulate1,xSimulate,xSimulate2] = trySN(paramInit,randomXInits,fittingData,hopland,realTraj,weight)
    %%
    orgiFitData=hopland.orgiFitData;
    developLine=hopland.developLine;

    %
    xReal=orgiFitData;
      
    weightMatrix=zeros(size(xReal,2),size(xReal,2));
    count=1;
    for j=1:size(xReal,2)
        for i=1:j
            weightMatrix(i,j)=paramInit(count);
            weightMatrix(j,i)=weightMatrix(i,j);
            count=count+1;
        end
    end
    
    sigmaW = paramInit(((size(xReal,2)*size(xReal,2)+size(xReal,2))/2+1):((size(xReal,2)*size(xReal,2)+size(xReal,2))/2+size(xReal,2))); %
    Ttime=1; 
    a=paramInit( ((size(xReal,2)*size(xReal,2)+size(xReal,2))/2+size(xReal,2)+1):((size(xReal,2)*size(xReal,2)+size(xReal,2))/2+2*size(xReal,2)));
    sigma=paramInit( ((size(xReal,2)*size(xReal,2)+size(xReal,2))/2+size(xReal,2)*2+1):((size(xReal,2)*size(xReal,2)+size(xReal,2))/2+3*size(xReal,2)));
    


 
%%
    if length(a)==1
        A = a*ones(1,size(xReal,2));        
    else
        A = a;       
    end
    
    if length(sigmaW)==1
        tempsigmaW = sigmaW*ones(size(xReal,2),size(xReal,2));
    elseif size(sigmaW,1)==1
        tempsigmaW = repmat(sigmaW',1,size(xReal,2));    
    else
        tempsigmaW = repmat(sigmaW,1,size(xReal,2));     
    end
     
    if length(sigma)==1
        sigma = sigma*ones(1,size(xReal,2));
    else
        sigma = sigma;       
    end
    
    
    xSimulate=cell(1,size(randomXInits,1));
    for timepoints=1:size(randomXInits,1)
        Xzero = randomXInits(timepoints,:); 
        xSimulate{timepoints}=hopfieldNetworkContinuousModel(weightMatrix, Ttime, sigma, A, tempsigmaW, Xzero, fittingData, developLine);
    end
    xSimulate1=cell2mat(xSimulate');
    
    xSimulate2=zeros(size(xSimulate{1}));
    for timepoints=1:size(randomXInits,1)
        xSimulate2=xSimulate2+xSimulate{timepoints};
    end
    xSimulate2=xSimulate2/size(randomXInits,1);
    

%%
    x1=mytrajDiff(xSimulate2,realTraj,weight);
%     x2=mycdfDiff(xSimulate1,xReal,realTraj,fittingDataTemp);
    g=sum(x1);
 

end

