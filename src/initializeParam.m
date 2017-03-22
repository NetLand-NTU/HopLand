function paramInit=initializeParam(orgiFitData)
    %initilize parameters
    tempn = size(orgiFitData,2);
    params = zeros((tempn^2+tempn)/2+tempn*3,1); %

    W=corr(orgiFitData);
    temp=reshape(W(triu(W)~=0),1,(tempn^2+tempn)/2);
    for i=1:(tempn^2+tempn)/2
        params(i)=temp(i);
    end

    %sigmaW
    for i=((tempn^2+tempn)/2+1):((tempn^2+tempn)/2+tempn)
        params(i)=1; %abs(randn(1)); 
    end
    %a
    for i=((tempn^2+tempn)/2+tempn+1):((tempn^2+tempn)/2+tempn*2)
        params(i)=1; %abs(randn(1));
    end
    %sigma
    for i=((tempn^2+tempn)/2+tempn*2+1):((tempn^2+tempn)/2+tempn*3)
        params(i)=0; %abs(randn(1));
    end

    paramInit=params;

end