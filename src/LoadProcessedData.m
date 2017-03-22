function hopland=LoadProcessedData(dataset)
    if( strcmp(dataset,'guo2010') )
        [startRefRange,cellStates,selectedGeneNames,filteredExpData,developLine,cellLabels]=ProcessRobinson(1,0);
        hopland.ifTimeseries=1;
    elseif( strcmp(dataset,'deng2014_1') )
        %include fibroblast and adult liver  
        [startRefRange,cellStates,selectedGeneNames,filteredExpData,developLine,cellLabels]=ProcessDeng(1,1);
        hopland.ifTimeseries=1;
    elseif( strcmp(dataset,'yan2013') )
        %exclude fibroblast and adult liver
        [startRefRange,cellStates,selectedGeneNames,filteredExpData,developLine,cellLabels]=ProcessYan(1,1);
        hopland.ifTimeseries=1;        
    elseif( strcmp(dataset,'SyntheticData') )
        [startRefRange,cellStates,selectedGeneNames,filteredExpData,developLine,cellLabels]=ProcessSyn(0,0);
        hopland.ifTimeseries=1;
    elseif( strcmp(dataset,'LPS') )
        [startRefRange,cellStates,selectedGeneNames,filteredExpData,developLine,cellLabels]=ProcessLPS(0,1);
        hopland.ifTimeseries=0;
    elseif( strcmp(dataset,'HSMM') )
        [startRefRange,cellStates,selectedGeneNames,filteredExpData,developLine,cellLabels]=ProcessHSMM(0,1);
        hopland.ifTimeseries=0;
    elseif( strcmp(dataset,'ES_MEF') )
        [startRefRange,cellStates,selectedGeneNames,filteredExpData,developLine,cellLabels]=ProcessESMEF(0,0);
        hopland.ifTimeseries=0;
    end
    
    
    hopland.startRefRange=startRefRange;
    hopland.cellStates=cellStates;
    hopland.selectedGeneNames=selectedGeneNames;
    hopland.orgiFitData=filteredExpData;
    hopland.developLine=developLine;
    hopland.cellLabels=cellLabels;
    hopland.dataset=dataset;

end


%ProcessHSMM;
% ProcessDeng;
% ProcessSimulate;