function plotMappingResult(hopland,style,ifCreateNewFigure)   
    cellStates=hopland.cellStates;
    model=hopland.model;
    %
    if ifCreateNewFigure
        figure;
    else
        hold on
    end
    
    if style==0
        %colors
        colors=linspace(0,1,length(cellStates));
        
        %plot
        h(1)=plot(model.X(1:cellStates(1),1),model.X(1:cellStates(1),2),...
            's','MarkerSize',3,'MarkerEdgeColor',[1,colors(1),colors(1)],'MarkerFaceColor',[1,colors(1),colors(1)]);
        hold on
        for i=1:length(cellStates)-1
            h(i+1)=plot(model.X(sum(cellStates(1:i))+1:sum(cellStates(1:(i+1))),1),...
                model.X(sum(cellStates(1:i))+1:sum(cellStates(1:(i+1))),2),...
                's','MarkerSize',3,'MarkerEdgeColor',[1,0,0],'MarkerFaceColor',[1,colors(i+1),colors(i+1)]);
        end
    elseif style==1
        %colors
        colors=setColors(length(cellStates));
        
        %plot
        h(1)=plot(model.X(1:cellStates(1),1),model.X(1:cellStates(1),2),...
            's','MarkerSize',7,'MarkerEdgeColor',colors(1,:),'MarkerFaceColor',colors(1,:));
        hold on
        for i=1:length(cellStates)-1
            h(i+1)=plot(model.X(sum(cellStates(1:i))+1:sum(cellStates(1:(i+1))),1),...
                model.X(sum(cellStates(1:i))+1:sum(cellStates(1:(i+1))),2),...
                's','MarkerSize',7,'MarkerEdgeColor',colors(i+1,:),'MarkerFaceColor',colors(i+1,:));
        end
        
    end

    
    %add legend
    lgd = num2str((1:length(cellStates))','Stage %d');
    legend(h,lgd,'Location','SouthEast')
    legend('boxoff')
    
%     set(gca,'xtick',-inf:inf:inf);
%     set(gca,'ytick',-inf:inf:inf);

end

