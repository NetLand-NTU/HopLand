function [startRefRange,cellStates,selectedGeneNames,filteredExpData,developLine,cellLabels]=ProcessSyn(ifNormaliseData,ifFilterGenes,SelectedGenesIndex)
    datasetID=input('Enter the set # [1-5]:');
    
    if datasetID==1
        folderName='csvtest_3279';
    elseif datasetID==2
        folderName='csvtest_3551';
    elseif datasetID==3
        folderName='csvtest_5001';
    elseif datasetID==4
        folderName='csvtest_5081';
    elseif datasetID==5
        folderName='csvtest_8971';
    else
        disp('Invalid number');
    end
    
    targetFile=strcat('./sample_data/syntheticData/',folderName,'.mat');
    load(targetFile);
    
    
    realtime=SynData.realtime;
    geneExpData=SynData.expr;
    numCells=size(geneExpData,1);
    numGenes=length(SynData.genenames);

    %create 10 segments
    a=min(realtime):(max(realtime)-min(realtime))/10:max(realtime);
    [N,X]=hist(realtime,a);
    cellStates= N;    
    startRefRange=1:cellStates(1);
    developLine=0:1/(length(cellStates)-1):1;
    cellLabels=realtime;
    
    %% Step 0: Process data
    if ifNormaliseData
        geneExpData = zscore(geneExpData);
    end
    
    %filter genes
    if ifFilterGenes
        ends=cumsum(cellStates);
        starts=[1,ends(1:end-1)+1];

        selectedIndex=1:size(geneExpData,2);
        for i=1:length(cellStates)-1
            for j=i+1:length(cellStates)
                [pvalues, tscores] = mattest(geneExpData(starts(i):ends(i),:)', geneExpData(starts(j):ends(j),:)');
                [pFDR, qvalues] = mafdr(pvalues);
                selectedIndex=intersect(selectedIndex,find(qvalues<0.05));
            end
        end
    elseif ~exist('SelectedGenesIndex')
        selectedIndex=1:numGenes;
    else
        selectedIndex = SelectedGenesIndex;
    end

    filteredExpData=geneExpData(:,selectedIndex);
    selectedGeneNames=SynData.genenames(selectedIndex);
    
%     % way2
%     values=std(geneExpData);
%     percentile=20; %percentile to remove
%     Y = prctile(values,percentile);
%     selectedIndex=find(values>=Y);
%     length(selectedIndex)
end