function [startRefRange,cellStates,selectedGeneNames,filteredExpData,developLine,cellLabels]=ProcessYan(ifNormaliseData,ifFilterGenes,SelectedGenesIndex)
    %load data 
    load('./sample_data/yan2013/yan2013Data.mat');

    % genes, labels, geneExpData, cellStates
    count=tabulate(pro.cell_stage);
    cellStates=count(:,2);
    geneExpData=pro.expr;
    startRefRange=1:cellStates(1);
    numGenes=length(pro.gnames);
    developLine=[0,1/6,2/6,3/6,4/6,5/6,6/6];
    cellLabels=pro.cell;


    %% Step 0: Process data
    if ifNormaliseData
        geneExpData = zscore(geneExpData);
    end

    %filter genes
    if ifFilterGenes
        ends=cumsum(cellStates)';
        starts=[1,ends(1:end-1)+1];

        selectedIndex=1:size(geneExpData,2);
        for i=1:length(cellStates)-1
            for j=i+1:length(cellStates)
                [pvalues, tscores] = mattest(geneExpData(starts(i):ends(i),:)', geneExpData(starts(j):ends(j),:)');
                [pFDR, qvalues] = mafdr(pvalues);
                selectedIndex=intersect(selectedIndex,find(qvalues<0.1));
            end
        end
    elseif ~exist('SelectedGenesIndex')
        selectedIndex=1:numGenes;
    else
        selectedIndex = SelectedGenesIndex;
    end

    filteredExpData=geneExpData(:,selectedIndex);
    selectedGeneNames=pro.gnames(selectedIndex);


end