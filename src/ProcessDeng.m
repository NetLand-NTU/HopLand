function [startRefRange,cellStates,selectedGeneNames,filteredExpData,developLine,cellLabels]=ProcessDeng(ifNormaliseData,ifFilterGenes,SelectedGenesIndex)
    %load data 
    load('./sample_data/deng2014/deng2014PData.mat');

    %     %                     Value    Count   Percent
%     %                    Zygote        4      1.26%
%     %             2-cell embryo        8      2.52%
%     %   Early 2-cell blastomere        8      2.52%
%     %     Mid 2-cell blastomere       12      3.79%
%     %    Late 2-cell blastomere       10      3.15%
%     %         4-cell blastomere       14      4.42%
%     %         8-cell blastomere       47     14.83%
%     %        16-cell blastomere       58     18.30%
%     %     Early blastocyst cell       43     13.56%
%     %       Mid blastocyst cell       60     18.93%
%     %      Late blastocyst cell       30      9.46%
%     %                fibroblast       10      3.15%
%     %               adult liver       13      4.10%

    % genes, labels, geneExpData, cellStates
    count=tabulate(pro.cell_stage);
    cellStates=[count(2:end,2);count(1,2)];
    geneExpData=pro.expr;
    startRefRange=1:cellStates(1);
    numGenes=length(pro.gname);
    developLine=[0,0.7/7,1/7,1.2/7,2/7,3/7,4/7,5/7,5.5/7,6/7,7/7];
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
    selectedGeneNames=pro.gname(selectedIndex);
    
   
end