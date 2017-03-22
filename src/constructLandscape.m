function [model,energyLand,ENERGYLAND,X,Y]=constructLandscape(paramInit,fittingData,hopland)
    orgiFitData=hopland.orgiFitData;
    
    %learning model
    [model,Y]=runGPLVM(orgiFitData,'linear','isomap',20); %isomap

    %% plot mapping
    close all;
    %plotMappingResult(model,cellStates,1,1); %style=1
%     hopland.model=model;
%     plotMappingResult(hopland,1,1);

    %% land energy
    m=size(orgiFitData,2);
    weightMatrix= zeros(m);
    count=1;
    for j=1:m
        for i=1:j
            weightMatrix(i,j)=paramInit(count);
            weightMatrix(j,i)=weightMatrix(i,j);
            count=count+1;
        end
    end
    

    A=paramInit( ((m*m+m)/2+m+1):((m*m+m)/2+2*m));
    sigma=paramInit( ((m*m+m)/2+m*2+1):((m*m+m)/2+3*m))';   
    W=weightMatrix;
    
    if hopland.ifTimeseries == 0 
        sigma=0;
    end
    if size(sigma,1) ~= 1
        sigma=sigma';
    end

    YpredReal = gpOut(model, model.X);
    energyLand=zeros(1,size(YpredReal,1));
    for ii=1:size(YpredReal,1)
        temp=YpredReal(ii,:);
        fx=F(temp,fittingData);
        invFx=0;
        parfor genei=1:size(YpredReal,2)
            f = @(xGene,fittingData,genei)inverseF(xGene,fittingData,genei);
            invFx = invFx+A(genei)*integral(@(x)f(x,fittingData,genei), 0, fx(genei)); %invfx=inverseF(x,fittingData);
        end
        energyLand(ii) = -0.5 * fx * W * fx' + invFx - sum(fx.*sigma);
    end
    
    %% generate mesh landscape
    topMax=max(model.X);
    minMin=min(model.X);

    n=30;
    i_start=minMin(1)-(topMax(1)-minMin(1))/4;
    i_end=topMax(1)+(topMax(1)-minMin(1))/4;

    j_start=minMin(2)-(topMax(2)-minMin(2))/4;
    j_end=topMax(2)+(topMax(2)-minMin(2))/4;

    [X,Y] = meshgrid(i_start:(i_end-i_start)/n:i_end, j_start:(j_end-j_start)/n:j_end);
    Xpred=zeros((n+1)*(n+1),2);k=1;
    for i=i_start:(i_end-i_start)/n:i_end
        for j=j_start:(j_end-j_start)/n:j_end
            Xpred(k,:)=[i,j];
            k=k+1;
        end
    end

    Ypred = gpOut(model, Xpred);
    ENERGYLAND=zeros(n+1,n+1);
    for ii=1:n+1
        parfor jj=1:n+1
            temp=Ypred((jj-1)*(n+1)+ii,:);
            fx=F(temp,fittingData);
            invFx=0;
            for genei=1:size(Ypred,2)
                f = @(xGene,fittingData,genei)inverseF(xGene,fittingData,genei);
                invFx = invFx+A(genei)*integral(@(x)f(x,fittingData,genei), 0, fx(genei)); %invfx=inverseF(x,fittingData);
            end           
            ENERGYLAND(ii,jj) = -0.5 * fx * W * fx' + invFx - sum(fx.*sigma);
        end
    end
    
end