addpath('src')

%% load samples
dataset='SyntheticData'; %deng2014_1,SyntheticData,guo2010,LPS,HSMM,ES_MEF,yan2013
hopland=LoadProcessedData(dataset); 

%% load user data
% % uncomment this section 
% % the name of the dataset
% hopland.dataset=dataset;
% % time series or stages used for comparison only 
% % e.g. [1,1,1,1,2,2,3,3,3,3,3] different number indicates different stages
% % or different types of cells
% hopland.cellLabels=cellLabels;
% % selected genes
% hopland.selectedGeneNames=selectedGeneNames;
% % processed gene expression data matrix with samples as row, genes as col
% hopland.orgiFitData=filteredExpData;
% 
% % set 1 if the dataset contains timporal information, otherwise set 0
% hopland.ifTimeseries=1;
% 
% if hopland.ifTimeseries == 1
%     % the cell indexes used to generate initial states
%     % leave it empty if the dataset doesn't contain the time information
%     % e.g. [1,2,3,4] using the first four samples as the reference
%     hopland.startRefRange=startRefRange;
%     % num of cells in each state in chronological order (only required for traning)
%     % samples in the datamatrix filteredExpData should be in the same order
%     % leave it empty if the dataset doesn't contain the time information
%     % e.g. if cellLabel=[1,1,1,1,2,2,3,3,3,3,3], then cellState=[4,2,5] 
%     hopland.cellStates=cellStates;    
%     % timporal information for training the data (0-1)
%     % the time intervals between two stages
%     % leave it empty if the dataset doesn't contain the time information
%     % e.g. [0,0.1667,0.3333,0.5000,0.6667,0.8333,1.0000] 
%     hopland.developLine=developLine;    
% end

%%
%the start point to calculate the distance
givenStartPoint=1;
%if calculate the correlation coefficients
ifdoComparison=1;

%% RUN HopLand
hopland=runHopLand(hopland,givenStartPoint,ifdoComparison);
    
%% PLOT
plotMappingResult(hopland,1,1);
plotMappingResult3D(hopland,1);
plotMappingResult2DGray(hopland,0);


%% Significant interactions
numTop=20;
analysisInteractions(hopland.selectedGeneNames,hopland.paramInit,numTop);


%% Map gene expression on the landscape
geneIndex=13; 
plotGeneExpOnLandscape(hopland,geneIndex);

