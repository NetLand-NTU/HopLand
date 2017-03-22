function analysisInteractions(selectedGeneNames,paramInit,numTop)
    numGenes=length(selectedGeneNames);

    %
    weightMatrix= zeros(numGenes);
    count=1;
    for j=1:numGenes
        for i=1:j
            weightMatrix(i,j)=paramInit(count);
            weightMatrix(j,i)=weightMatrix(i,j);
            count=count+1;
        end
    end

%     if numGenes>50
%         disp('Too much genes to plot!');
%     end

    %%
    figure;
    h=bar3(weightMatrix);
    for n=1:numel(h)
        cdata=get(h(n),'zdata');
        set(h(n),'cdata',cdata,'facecolor','interp')
    end

    %%
    temp1=reshape(weightMatrix,1,numGenes^2);
    [Y1,I1]=sort(abs(temp1),'descend');    
    
    [row,col]=ind2sub(size(weightMatrix), I1);
    a=[row',col'];
    a=sort(a,2);
    a=unique(a,'rows','stable');
    toplist=a(1:numTop,:);

    count=1;
    while count<numTop
        disp(sprintf('#%d %s   %s',count,selectedGeneNames{toplist(count,1)},selectedGeneNames{toplist(count,2)}));       
        count=count+1;
    end

end