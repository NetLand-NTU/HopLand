paramInit=hopland.paramInit;
xReal=hopland.orgiFitData;

N=size(xReal,2);
weightMatrix= zeros(N);
count=1;
for j=1:N
    for i=1:j
        weightMatrix(i,j)=paramInit(count);
        weightMatrix(j,i)=weightMatrix(i,j);
        count=count+1;
    end
end


h = bar3(weightMatrix);
shading interp
for i = 1:length(h)
     zdata = get(h(i),'Zdata');
     set(h(i),'Cdata',zdata)
     set(h,'EdgeColor','k')
end
colorbar
