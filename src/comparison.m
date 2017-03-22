function coef=comparison(hopland)
    reference=hopland.dataset;
    dist=hopland.dist;
    cellLabels=hopland.cellLabels;

    %
    if( strcmp(reference,'guo2010') )
        reference=[ones(1,9),2*ones(1,19),3*ones(1,23),4*ones(1,44),5*ones(1,75),6*ones(1,109),7*ones(1,159)];
    elseif( strcmp(reference,'deng2014_1') )
        reference=[ones(1,4),1.7*ones(1,8),2*ones(1,20),2.5*ones(1,10),...
            3*ones(1,14),4*ones(1,47),...
            5*ones(1,58),6*ones(1,43),6.5*ones(1,60),7*ones(1,30),8*ones(1,23)];      
    elseif( strcmp(reference,'deng2014_2') )
        reference=[ones(1,4),1.7*ones(1,8),2*ones(1,20),2.5*ones(1,10),...
            3*ones(1,14),4*ones(1,47),...
            5*ones(1,58),6*ones(1,43),6.5*ones(1,60),7*ones(1,30)];   
    elseif( strcmp(reference,'yan2013') )
        reference=[ones(1,6),2*ones(1,6),3*ones(1,12),4*ones(1,20),5*ones(1,16),6*ones(1,30),7*ones(1,34)];
    elseif( strcmp(reference,'SyntheticData') )
        reference=cellLabels;
    elseif( strcmp(reference,'LPS') )
        reference=cellLabels;
    elseif( strcmp(reference,'HSMM') )
        reference=cellLabels;
    elseif( strcmp(reference,'ES_MEF') )
        reference=cellLabels;
    end
    
    %% comparison
    D=dist;
    index=find(dist==-1);
    reference=reference(setdiff(1:length(reference),index));
    D=D(setdiff(1:length(D),index));
    temp=corrcoef(reference',D');
    coef=temp(1,2);

    lgd = num2str(index,'#%d ');
    details1=strcat('The correlation coefficients: ',num2str(coef));
    details2=strcat('Points that cannot be connected: ',lgd);
    sprintf('%s\n%s\n',details1,details2)
end
