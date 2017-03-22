function plotMappingResult3D(hopland,style)
    model=hopland.model;
    cellStates=hopland.cellStates;
    ENERGYLAND=hopland.ENERGYLAND;
    energyLand=hopland.energyLand;
    X=hopland.X;
    Y=hopland.Y;

    %
    figure;
    %mesh grid
    surf(X,Y,(ENERGYLAND))
    colorbar
    shading interp
    hold on
    
    %experimental points
    if style==0
        %colors
        colors=linspace(0,1,length(cellStates));

        %plot
        h(1)=plot3(model.X(1:cellStates(1),1),model.X(1:cellStates(1),2),energyLand(1:cellStates(1)),...
            's','MarkerSize',3,'MarkerEdgeColor',[1,colors(1),colors(1)],'MarkerFaceColor',[1,colors(1),colors(1)]);
        hold on
        for i=1:length(cellStates)-1
            h(i+1)=plot3(model.X(sum(cellStates(1:i))+1:sum(cellStates(1:(i+1))),1),...
                model.X(sum(cellStates(1:i))+1:sum(cellStates(1:(i+1))),2),...
                energyLand(sum(cellStates(1:i))+1:sum(cellStates(1:(i+1)))),...
                's','MarkerSize',3,'MarkerEdgeColor',[1,colors(i+1),colors(i+1)],'MarkerFaceColor',[1,colors(i+1),colors(i+1)]);
        end
    elseif style==1
        %colors jet
        colors=setColors(length(cellStates));
        
        %plot
        h(1)=plot3(model.X(1:cellStates(1),1),model.X(1:cellStates(1),2),energyLand(1:cellStates(1)),'s','MarkerSize',3,'MarkerEdgeColor',colors(1,:),'MarkerFaceColor',colors(1,:));
        hold on
        for i=1:length(cellStates)-1
            h(i+1)=plot3(model.X(sum(cellStates(1:i))+1:sum(cellStates(1:(i+1))),1),...
                model.X(sum(cellStates(1:i))+1:sum(cellStates(1:(i+1))),2),...
                energyLand(sum(cellStates(1:i))+1:sum(cellStates(1:(i+1)))),...
                's','MarkerSize',3,'MarkerEdgeColor',colors(i+1,:),'MarkerFaceColor',colors(i+1,:));
        end

    end

    %contour
    hold on
    [~,h1] = contourf(X,Y,ENERGYLAND,20,'LineStyle','none');
    hh=get(h1,'Children');
    lowPos=min(min(ENERGYLAND))-20;
    for i=1:numel(hh)
        zdata = ones(size( get(hh(i),'XData') ));
        set(hh(i), 'ZData',lowPos*zdata)
    end
    
    colormap(gray)
    %colormap(hot)
    colormap(jet)
    
    %add legend
    lgd = num2str((1:length(cellStates))','Stage %d');
    legend(h,lgd,'Location','SouthEast')
    legend('boxoff')
    
    xlabel('Component 1','Rotation',0);
    ylabel('Component 2','Rotation',0);
    zlabel('Energy','Rotation',0);
    
%     set(gca,'xtick',-inf:inf:inf);
%     set(gca,'ytick',-inf:inf:inf);
    
end

