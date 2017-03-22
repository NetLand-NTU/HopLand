function plotGeneExpOnLandscape(hopland,geneIndex)
    model=hopland.model;
    expressionData=hopland.orgiFitData;
    ENERGYLAND=hopland.ENERGYLAND;
    X=hopland.X;
    Y=hopland.Y;

    
    temp=expressionData(:,geneIndex);
    maxValue=max(temp);
    minValue=min(temp);
    intervals=linspace(minValue,maxValue,11);
    
    
    
    figure;
    contourf(X,Y,ENERGYLAND,20,'LineStyle','none');
    colormap(gray)
    colorbar
    xlabel('Component 1');
    ylabel('Component 2');
    
    %colors
    colors=linspace(0,1,10);
    
    %plot
    hold on;
    for i=1:length(intervals)-1
        indexes=find(temp<=intervals(i+1) & temp>=intervals(i));
        plot(model.X(indexes,1),...
            model.X(indexes,2),...
            's','MarkerSize',3,'MarkerEdgeColor',[1,colors(i),colors(i)],'MarkerFaceColor',[1,colors(i),colors(i)]);
    end
 

end