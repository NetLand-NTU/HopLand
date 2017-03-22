function [Xem]=hopfieldNetworkContinuousModel(W, T, sigma, A,sigmaW, Xzero, fittingData, developLine)
    %% dynamics
    randn('state',100);
    %M = size(W,1);

    W=W.*sigmaW;

    %% SDE
    % N = T*64; dt = T/N;
    % dW = sqrt(dt)*normrnd(0,1,M,N); % Brownian increments
    %
    % R = 4; L = 442; %N/R; % L EM steps of size Dt = R*dt
    % Xem = zeros(L+1,M); % preallocate for efficiency
    % Xem(1,:)=Xzero;
    % Xtemp = Xzero;
    % for j = 1:L
    %     for gene=1:M
    %         Winc = sum(dW(gene, R*(j-1)+1:R*j));
    %         Xtemp(gene) = Xtemp(gene) -A(gene)*Xtemp(gene) + W(gene,:)*F(Xtemp,fittingData)' + sigma*Winc;
    %         Xem(j+1,gene) = Xtemp(gene);
    %     end
    % end

    %% ODE
    % ff = @(t,Xtemp) tempF(t,Xtemp,fittingData,M,W,sigma,A);
    % [t,Xem]=ode45(ff,0:T/100:T,Xzero);      %
    % plot(t,Xem)


    %% SSA
    % [t,Xem] = ssa_example(Xzero,fittingData,W,sigma,A,T);

    %% Euler method
    h=0.1;
    if T/h<50
        h=T/50;
    end
    Xem=zeros(T/h+1,size(W,2));
    Xem(1,:)=Xzero;
    count=2;
    for i=2:T/h+1
        Xem(count,:)=Xem(count-1,:)+h*tempF([],Xem(count-1,:)',W,sigma,A,fittingData)';
        count=count+1;
    end

    newindex=floor(developLine*size(Xem,1)); %[1:count/(size(realTraj,2)-1):size(Xem,1),size(Xem,1)];
    newindex(1)=1;
    Xem=Xem(floor(newindex),:);
end




function f=tempF(t,Xtemp,W,sigma,A,fittingData)
    resultF = F(Xtemp,fittingData)';
    if size(A,1)>size(A,2)
       A=A'; 
    end
    
    if size(resultF,1)==1
        resultF=resultF';
    end
    
    if size(sigma,1)>1
        sigma=sigma';
    end
    f=-A'.*Xtemp + W*resultF + sigma';  
    
end

