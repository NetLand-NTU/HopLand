function [dist,coef]=calculateDistance(hopland,display,StartPoint,ifdoComparison)
    model=hopland.model;
    cellStates=hopland.cellStates;
    energyLand=hopland.energyLand;

    x=(model.X(:,1)-min(model.X(:,1)))/(max(model.X(:,1))-min(model.X(:,1)));
    y=(model.X(:,2)-min(model.X(:,2)))/(max(model.X(:,2))-min(model.X(:,2)));
    z=2*(energyLand-min(energyLand))/(max(energyLand)-min(energyLand));    
    
    manifold=[x,y,z'];
    
    %% construct mesh
    dt = delaunayTriangulation(manifold);
    vertex=dt.Points';
    
    dt1 = delaunayTriangulation([model.X(:,1),model.X(:,2),energyLand']);
    vertex_orgi=dt1.Points';

    dt = delaunayTriangulation([x,y]);
    faces=dt.ConnectivityList;

    %% set start point
    if ~exist('StartPoint')
        [a,StartPoint]=max(energyLand);
    end

    %% cal dist
    distanceMatrix=zeros(size(vertex,2),size(vertex,2));
    for start_points=1:size(vertex,2)
        options.start_points=start_points;
        options.end_points = [];
        
        [D,S,Q] = perform_fast_marching_mesh(vertex, faces, start_points);
        distanceMatrix(start_points,:)=D;
    end
    
    [Tree, pred] = graphminspantree(sparse(distanceMatrix),StartPoint,'Method','Kruskal');
    T=full(Tree);
    pred(StartPoint)=StartPoint;
    
    %
    [S, C] = graphconncomp(Tree,'Directed',false);
    details1=strcat('Strongly connected components: ',num2str(S));
    fprintf('%s\n',details1)
    tabulate(C)
    
    path=cell(1,size(distanceMatrix,1));
    dist=zeros(1,size(distanceMatrix,1));
    for i=1:size(distanceMatrix,1)
        currentI=i;
        path{i}=i;
        while pred(currentI)~=StartPoint
            path{i}=[path{i},pred(currentI)];
            currentI=pred(currentI);
        end
        path{i}=[path{i},StartPoint];
                
        dist(i)=0;
        for j=1:length(path{i})-1
            index1=path{i}(j);
            index2=path{i}(j+1);
            dist(i)=dist(i)+T(index1,index2)+ T(index2,index1);
        end       
    end
    hopland.dist=dist;
    
    coef=0;
    if ifdoComparison
        coef=comparison(hopland);
    end 
  
        
    %% plot tree    
    if display
        %triplot(dt);
        %hold on
        plotMappingResult2DGray(hopland,1);
%         plotMappingResult(hopland,1,0);
        hold on
        %plot
        ms = getoptions(options, 'ms', 5);
        lw = getoptions(options, 'lw', 2);

        for i=1:size(T,1)
            for j=1:size(T,2)
                if T(i,j)~=0
                    path=vertex_orgi(:,[i,j]);
                    h = plot(path(1,:), path(2,:), 'r');
                    set(h,'LineWidth', lw);
                end
            end
        end
    end


end


