function [realTraj,weight]=generateTraj(hopland)
    orgiFitData=hopland.orgiFitData;
    cellStates=hopland.cellStates;
    %
    numTimePoints=length(cellStates);
    realTraj=zeros(size(orgiFitData,2),numTimePoints);
    weight=zeros(size(orgiFitData,2),numTimePoints);
    for i=1:size(orgiFitData,2)
        geneID=i;
        realTraj(i,1)=mean(orgiFitData(1:cumsum(cellStates(1)),geneID));
        weight(i,1)=1./std(orgiFitData(1:cumsum(cellStates(1)),geneID));
        for j=2:numTimePoints
            realTraj(i,j)=mean(orgiFitData((sum(cellStates(1:(j-1)))+1):sum(cellStates(1:j)),geneID));
            weight(i,j)=1./std(orgiFitData((sum(cellStates(1:(j-1)))+1):sum(cellStates(1:j)),geneID));
        end
    end
    weight(weight>10)=10;
end