function [startRefRange,cellStates,selectedGeneNames,filteredExpData,developLine,cellLabels]=ProcessESMEF(ifNormaliseData,ifFilterGenes,SelectedGenesIndex)
    %load data 
    load('./sample_data/ES_MEF/ES_MEFData.mat');

    % genes, labels, geneExpData, cellStates
    count=tabulate(pro.cell_stage);
    cellStates=count(:,2);
    geneExpData=pro.expr;
    startRefRange=1:cellStates(1);
    numGenes=length(pro.gnames);
    developLine=0;
    cellLabels=pro.cell_stage;
    
    %% Step 0: Process data
    if ifNormaliseData
        geneExpData = zscore(geneExpData);
    end
    
    %filter genes
    if ifFilterGenes
        [Y,I]=sort(var(geneExpData),'descend');
        SelectedGenesIndex=I(1:floor(I/10));
    end
    
    if ~exist('SelectedGenesIndex')
        selectedIndex=1:numGenes;
    else
        selectedIndex = SelectedGenesIndex;
    end
    
    filteredExpData=geneExpData(:,selectedIndex);
    selectedGeneNames=pro.gnames(selectedIndex);

end
