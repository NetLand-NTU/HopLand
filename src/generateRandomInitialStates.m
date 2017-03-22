function randomXInits=generateRandomInitialStates(num,alpha,hopland)
    orgiFitData=hopland.orgiFitData;
    startRefRange=hopland.startRefRange;
    
    % mean mu
    mu=std(orgiFitData(startRefRange,:));

    %
    randomXInits = zeros(num,size(orgiFitData,2));
    for i=1:num
        origNum = randi(length(startRefRange));
        Xzero = orgiFitData(origNum,:); %randn(1,size(leftgeneExpData,2)); % initial values

        randomXInits(i,:)=Xzero+0.001*rand(1,size(Xzero,2))+((rand(1,size(orgiFitData,2))>0.5)*2-1)*alpha.*mu;
    end

end