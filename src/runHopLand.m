%--------------------------------------------------
% HopLand algorithm
%--------------------------------------------------

function hopland=runHopLand(hopland,givenStartPoint,ifdoComparison)
    %% Step 1: fit muliGuassian
    [fittingData,fittingDataTemp]=fitMixtureGaussian(hopland);
    
    %% TRAINING
    if hopland.ifTimeseries        
        % Step 2: generate random initials
        num = 1000; %num of random initial states
        alpha = 0.01; %noise strength in random initial states       
        randomXInits=generateRandomInitialStates(num,alpha,hopland);        
        
        % Step 3: generate test traj from real data
        [realTraj,weight]=generateTraj(hopland);        
        
        % Step 4: parameter optimization
        maxIts=2000;
        paramInit=parameterOptimization(maxIts,randomXInits,fittingData,fittingDataTemp,hopland,realTraj,weight);        
        hopland.paramInit=paramInit;
        
    %% clustering
    else
        paramInit=initializeParam(hopland.orgiFitData);
    end

    %% Step 5: landscape construction
    [model,energyLand,ENERGYLAND,X,Y]=constructLandscape(paramInit,fittingData,hopland);

    hopland.model=model;
    hopland.ENERGYLAND=ENERGYLAND;
    hopland.energyLand=energyLand;
    hopland.X=X;
    hopland.Y=Y;

  
    
    %% Step 6: pseudotime estimation
    display=1;
    [dist,coef]=calculateDistance(hopland,display,givenStartPoint,ifdoComparison);
    
    hopland.dist=dist;
    hopland.coef=coef;
end