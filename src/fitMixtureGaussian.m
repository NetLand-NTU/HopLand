function [fittingData,fittingDataTemp]=fitMixtureGaussian(hopland)
    orgiFitData=hopland.orgiFitData;
    
    %
    fittingData=zeros(2,size(orgiFitData,2));
    fittingData(1,:)=mean(orgiFitData);
    fittingData(2,:)=std(orgiFitData);
    
    %
    fittingDataTemp=cell(1,size(orgiFitData,2));
    
    seed = 1;
    s = RandStream('mt19937ar','Seed',seed);
    opts = statset('Streams',s, 'MaxIter', 2000);

    for geneID=1:size(orgiFitData,2)        
         
        aicScores = zeros(1,4);
        bicScores = zeros(1,4);
        results=cell(1,4);
        for k=1:4           
            gmm = gmdistribution.fit(orgiFitData(1:end,geneID),k,'Options',opts,'Regularize',0.000001);
            aicScores(k) = gmm.AIC;
            bicScores(k) = gmm.BIC;
            results{k}=gmm;
        end
        [a,k]=min(aicScores);
        
        
        %check
        threshold=0.05;
        gmm=results{k};
        if k==2
            if gmm.PComponents(1)<threshold || gmm.PComponents(2)<threshold
                k=1;
            end
        elseif k==3
            if gmm.PComponents(1)<threshold || gmm.PComponents(2)<threshold || gmm.PComponents(3)<threshold
                k=2;
                gmm=results{2};
                if gmm.PComponents(1)<threshold || gmm.PComponents(2)<threshold
                    k=1;
                end
            end
        elseif k==4
            if gmm.PComponents(1)<threshold || gmm.PComponents(2)<threshold || gmm.PComponents(3)<threshold || gmm.PComponents(4)<threshold 
                k=3;
                gmm=results{3};
                if gmm.PComponents(1)<threshold || gmm.PComponents(2)<threshold || gmm.PComponents(3)<threshold
                    k=2;
                    gmm=results{2};
                    if gmm.PComponents(1)<threshold || gmm.PComponents(2)<threshold
                        k=1;
                    end
                end
            end
        end
        
        %final fitting
        if k<4
            fittingDataTemp{geneID}=[results{k}.PComponents,zeros(1,4-k);
                results{k}.mu',zeros(1,4-k);
                results{k}.Sigma(:,:),zeros(1,4-k)];
        else        
            fittingDataTemp{geneID}=[results{k}.PComponents;
                results{k}.mu';
                results{k}.Sigma(:,:)];
        end       
        
        
        fprintf('%s Gene#%i: k=%i\n','Processing ',geneID,k);
    end
    
    
    fittingDataTemp=cell2mat(fittingDataTemp');

end