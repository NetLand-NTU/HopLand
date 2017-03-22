function paramInit=parameterOptimization(maxIts,randomXInits,fittingData,fittingDataTemp,hopland,realTraj,weight)
    %
    disp('Parameter optimization...');
    orgiFitData=hopland.orgiFitData;
    developLine=hopland.developLine;
    
    %initilize parameters
    paramInit=initializeParam(orgiFitData);

    %% adaption
    learnRate = 0.3;
    N=size(orgiFitData,2);
    xReal=orgiFitData;
    savedResults=zeros(1,2);
    savedParam=zeros(1,length(paramInit));
    cc=1;


    [g1,xSimulate1,xSimulate,xSimulate2] = trySN(paramInit,randomXInits,fittingData,hopland,realTraj,weight);
    g0=g1;
    for its=1:maxIts    
        [g1,xSimulate1,xSimulate,xSimulate2] = trySN(paramInit,randomXInits,fittingData,hopland,realTraj,weight);
        x2=mycdfDiff(xSimulate1,xReal,realTraj,fittingDataTemp);
        savedResults(cc,:)=[g1,sum(x2)];
        savedParam(cc,:)=paramInit;
        cc=cc+1;

        %adapt learning rate
        if g1>g0
            learnRate=0.5*learnRate;
            paramInit=paramInitbak1;
            continue;
        elseif g1<g0
            learnRate=(1+0.02)*learnRate;
        end

        if g0-g1<10^(-5) && g0~=g1
            paramInit=paramInitbak1;
            break;
        end
        g0=g1;
        paramInitbak1=paramInit;

        if learnRate<10^(-6)
            paramInit=paramInitbak1;
            break;   
        end
        
        %      
        weightMatrix= zeros(size(xReal,2),size(xReal,2));
        count=1;
        for j=1:size(xReal,2)
            for i=1:j
                weightMatrix(i,j)=paramInit(count);
                weightMatrix(j,i)=weightMatrix(i,j);
                count=count+1;
            end
        end

        sigmaW =paramInit(((size(xReal,2)*size(xReal,2)+size(xReal,2))/2+1):((size(xReal,2)*size(xReal,2)+size(xReal,2))/2+size(xReal,2))); %
        Ttime=1;


        h=0.1;
        if Ttime/h<50
            h=Ttime/50;
        end
        
        %
        numPoints=length(developLine);    
        newTime=1:numPoints;

        allF=zeros(size(xSimulate2));
        for i=1:size(xSimulate2,1)
            allF(i,:)=F(xSimulate2(i,:),fittingData);
        end

        %
        da_i=zeros(1,N);        
        dI_i=zeros(1,N);
        dC_i=zeros(1,N);
        dw_ij=zeros(1,(N*N+N)/2);

        count=1;  
        for genei=1:N
            temp=xSimulate2( newTime,genei)';

            %
            ai=0;ii=0;ci=0;
            for i=1:numPoints
                if i==1
                    iii=2;
                else 
                    iii=i;
                end
               ai=ai+weight(i)*(realTraj(genei,i)-temp(i))*h*sum(xSimulate2(1:(newTime(iii)-1),genei));                          
               ii=ii+weight(i)*(realTraj(genei,i)-temp(i))*h*(newTime(iii)-1);
               if newTime(iii)-1==1
                    ci=ci+weight(i)*(realTraj(genei,i)-temp(i))*h*(weightMatrix(genei,:)*(allF(1:(newTime(iii)-1),:))');
               else
                   ci=ci+weight(i)*(realTraj(genei,i)-temp(i))*h*(weightMatrix(genei,:)*sum(allF(1:(newTime(iii)-1),:))');
               end
            end
            da_i(genei)=-2/N*ai;            
            dI_i(genei)=2/N*ii;
            dC_i(genei)=2/N*ci;


            %
            for j=1:genei
                wij=0;
                for i=1:numPoints
                    if i==1
                        iii=2;
                    else
                        iii=i;
                    end
                    wij=wij+weight(i)*(realTraj(genei,i)-temp(i))*h*sigmaW(genei)*sum(allF(1:(newTime(iii)-1),j));
                end
                dw_ij(count)=2/N*wij;
                count=count+1;
            end 
        end

        paramInit1 = paramInit+learnRate*[dw_ij,dC_i,da_i,dI_i]';
        k=(N*N+N)/2;
        negIndex=find(paramInit1((k+1):end)<=0)+k;
        paramInit1(negIndex)=paramInit(negIndex);
        paramInit=paramInit1;

    end

    %%
    [a,I]=min(sum(savedResults'));
    paramInit=savedParam(I,:);
    disp('done');

end
