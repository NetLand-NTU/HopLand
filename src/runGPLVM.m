function [model,Y]=runGPLVM(simulatedData,backConstraintsKernel,initialMethod,iters)
    %load data
    Y=simulatedData;

    %% Set up model
    options = fgplvmOptions('ftc');
    options.optimiser = 'scg';

    % back
    if strcmp(backConstraintsKernel,'mlp')
        options.back = 'mlp';
        options.backOptions = mlpOptions(10);
    elseif strcmp(backConstraintsKernel,'kbr')
        options.back = 'kbr';
        options.backOptions = kbrOptions(Y);
        options.backOptions.kern = kernCreate(Y, 'rbf');
        options.backOptions.kern.inverseWidth = 0.0001;
    elseif strcmp(backConstraintsKernel,'linear')
        options.back = 'linear';
        options.backOptions = linearOptions;
        options.optimiseInitBack = 1;
    end

    latentDim = 2;
    d = size(Y, 2);

   
    options.initX = initialMethod;

        
    model = fgplvmCreate(latentDim, d, Y, options);

%     % Add dynamics model.
%     options = gpOptions('ftc');
%     options.kern = kernCreate(model.X, {'rbf'});
%     % % options.kern.comp{1}.inverseWidth = 0.2;
%     % % This gives signal to noise of 0.1:1e-3 or 100:1.
%     % % options.kern.comp{1}.variance = 0.1^2;
%     % % options.kern.comp{2}.variance = 1e-3^2;
%     model = fgplvmAddDynamics(model, 'gp', options,1 ,1);


    % Optimise the model.
    model = fgplvmOptimise(model, 1, iters);

    % Save the results.
    modelWriteResult(model, 'haha', 1);

end

