%Code to analyze fixed spikecount det task results

%Loop over each PN

PN_Names={'PN1LS','PN2LS', 'PN3LS', 'PN1RS', 'PN2RS'};

for p=1:5
    
    PN=PN_Names{p};
    
%define the base path to results
    base12=['~/nC_projects/',PN,'_allORNs/simulations/detTask/results_fixedSpike_12Spikes'];
    
    % find the names of all reps in the 12 spike REAL case
    real12Dirs=dir([base12,'/real_*']);
    dataFileName=ls([base12,'/',real12Dirs(1).name]);
    dataFileName=dataFileName(1:29);
    
    counter=1;
    
    for r=1:size(real12Dirs,1)
        
        %Load the pnVm
        pnvm_working=importdata([base12,'/',real12Dirs(r).name, '/',dataFileName]);
        real12Means(p,counter)=mean(pnvm_working+60);
        % vms_real12(counter,:)=pnvm_working;
        counter=counter+1;
        
    end
    
    % find the names of all reps in the 12 spike REAL case
    eq12Dirs=dir([base12,'/eq_*']);
    dataFileName=ls([base12,'/',eq12Dirs(1).name]);
    dataFileName=dataFileName(1:29);
    
    counter=1;
    
    for r=1:size(eq12Dirs,1)
        %Load the pnVm
        pnvm_working=importdata([base12,'/',eq12Dirs(r).name, '/',dataFileName]);
        eq12Means(p,counter)=mean(pnvm_working+60);
        % vms_eq12(counter,:)=pnvm_working;
        counter=counter+1;
    end
    
%define the base path to results
    base13=['~/nC_projects/',PN,'_allORNs/simulations/detTask/results_fixedSpike_13Spikes'];
    
    % find the names of all reps in the 13 spike REAL case
    real13Dirs=dir([base13,'/real_*']);
    dataFileName=ls([base13,'/',real13Dirs(1).name]);
    dataFileName=dataFileName(1:29);
    
    counter=1;
    
    for r=1:size(real13Dirs,1)
        
        %Load the pnVm
        pnvm_working=importdata([base13,'/',real13Dirs(r).name, '/',dataFileName]);
        real13Means(p,counter)=mean(pnvm_working+60);
        % vms_real13(counter,:)=pnvm_working;
        counter=counter+1;
        
    end
    
    % find the names of all reps in the 13 spike REAL case
    eq13Dirs=dir([base13,'/eq_*']);
    dataFileName=ls([base13,'/',eq13Dirs(1).name]);
    dataFileName=dataFileName(1:29);
    
    counter=1;
    
    for r=1:size(eq13Dirs,1)
        %Load the pnVm
        pnvm_working=importdata([base13,'/',eq13Dirs(r).name, '/',dataFileName]);
        eq13Means(p,counter)=mean(pnvm_working+60);
        % vms_eq13(counter,:)=pnvm_working;
        counter=counter+1;
    end
    
%define the base path to results
    base14=['~/nC_projects/',PN,'_allORNs/simulations/detTask/results_fixedSpike_14Spikes'];
    
    % find the names of all reps in the 14 spike REAL case
    real14Dirs=dir([base14,'/real_*']);
    dataFileName=ls([base14,'/',real14Dirs(1).name]);
    dataFileName=dataFileName(1:29);
    
    counter=1;
    
    for r=1:size(real14Dirs,1)
        
        %Load the pnVm
        pnvm_working=importdata([base14,'/',real14Dirs(r).name, '/',dataFileName]);
        real14Means(p,counter)=mean(pnvm_working+60);
        % vms_real14(counter,:)=pnvm_working;
        counter=counter+1;
        
    end
    
    % find the names of all reps in the 14 spike REAL case
    eq14Dirs=dir([base14,'/eq_*']);
    dataFileName=ls([base14,'/',eq14Dirs(1).name]);
    dataFileName=dataFileName(1:29);
    
    counter=1;
    
    for r=1:size(eq14Dirs,1)
        %Load the pnVm
        pnvm_working=importdata([base14,'/',eq14Dirs(r).name, '/',dataFileName]);
        eq14Means(p,counter)=mean(pnvm_working+60);
        % vms_eq14(counter,:)=pnvm_working;
        counter=counter+1;
    end
    
%define the base path to results
    base15=['~/nC_projects/',PN,'_allORNs/simulations/detTask/results_fixedSpike_15Spikes'];
    
    % find the names of all reps in the 15 spike REAL case
    real15Dirs=dir([base15,'/real_*']);
    dataFileName=ls([base15,'/',real15Dirs(1).name]);
    dataFileName=dataFileName(1:29);
    
    counter=1;
    
    for r=1:size(real15Dirs,1)
        
        %Load the pnVm
        pnvm_working=importdata([base15,'/',real15Dirs(r).name, '/',dataFileName]);
        real15Means(p,counter)=mean(pnvm_working+60);
        % vms_real15(counter,:)=pnvm_working;
        counter=counter+1;
        
    end
    
    % find the names of all reps in the 15 spike REAL case
    eq15Dirs=dir([base15,'/eq_*']);
    dataFileName=ls([base15,'/',eq15Dirs(1).name]);
    dataFileName=dataFileName(1:29);
    
    counter=1;
    
    for r=1:size(eq15Dirs,1)
        %Load the pnVm
        pnvm_working=importdata([base15,'/',eq15Dirs(r).name, '/',dataFileName]);
        eq15Means(p,counter)=mean(pnvm_working+60);
        % vms_eq15(counter,:)=pnvm_working;
        counter=counter+1;
    end
    
    
     for c=1:3
        
        if c==1
            predictors=[real12Means(p,1:2500)';real13Means(p,1:2500)'];
            categories=[ones(size(real12Means(p,1:2500)'));2*ones(size(real13Means(p,1:2500)'))];
            testVals=[real12Means(p,2501:end)';real13Means(p,2501:end)'];
            testCat=[ones(size(real12Means(p,2501:end)'));2*ones(size(real13Means(p,2501:end)'))];
        elseif c==2
            predictors=[real12Means(p,1:2500)';real14Means(p,1:2500)'];
            categories=[ones(size(real12Means(p,1:2500)'));2*ones(size(real14Means(p,1:2500)'))];
            testVals=[real12Means(p,2501:end)';real14Means(p,2501:end)'];
            testCat=[ones(size(real12Means(p,2501:end)'));2*ones(size(real14Means(p,2501:end)'))];
        elseif c==3
            predictors=[real12Means(p,1:2500)';real15Means(p,1:2500)'];
            categories=[ones(size(real12Means(p,1:2500)'));2*ones(size(real15Means(p,1:2500)'))];
            testVals=[real12Means(p,2501:end)';real15Means(p,2501:end)'];
            testCat=[ones(size(real12Means(p,2501:end)'));2*ones(size(real15Means(p,2501:end)'))];
        end
        
        % Train a discriminant object on of the sets of repetitions and test it
        % on the other
        
        cls = fitcdiscr(predictors,categories);
        
        K=cls.Coeffs(1,2).Const;
        L=cls.Coeffs(1,2).Linear;
        thresh=-K/L;
        
        %see how well it did on the training data
        
        performance_real(p,c,1)=(sum(categories(find(predictors<thresh))== 1)+...
            sum(categories(find(predictors>thresh))== 2))/numel(categories)
        
        %see how well it did on the test data
        performance_real(p,c,2)=(sum(testCat(find(testVals<thresh))== 1)+...
            sum(testCat(find(testVals>thresh))== 2))/numel(testCat)
        
    end
    
    

    for c=1:3
        
        if c==1
            predictors=[eq12Means(p,1:2500)';eq13Means(p,1:2500)'];
            categories=[ones(size(eq12Means(p,1:2500)'));2*ones(size(eq13Means(p,1:2500)'))];
            testVals=[eq12Means(p,2501:end)';eq13Means(p,2501:end)'];
            testCat=[ones(size(eq12Means(p,2501:end)'));2*ones(size(eq13Means(p,2501:end)'))];
        elseif c==2
            predictors=[eq12Means(p,1:2500)';eq14Means(p,1:2500)'];
            categories=[ones(size(eq12Means(p,1:2500)'));2*ones(size(eq14Means(p,1:2500)'))];
            testVals=[eq12Means(p,2501:end)';eq14Means(p,2501:end)'];
            testCat=[ones(size(eq12Means(p,2501:end)'));2*ones(size(eq14Means(p,2501:end)'))];
        elseif c==3
            predictors=[eq12Means(p,1:2500)';eq15Means(p,1:2500)'];
            categories=[ones(size(eq12Means(p,1:2500)'));2*ones(size(eq15Means(p,1:2500)'))];
            testVals=[eq12Means(p,2501:end)';eq15Means(p,2501:end)'];
            testCat=[ones(size(eq12Means(p,2501:end)'));2*ones(size(eq15Means(p,2501:end)'))];
        end
        
        % Train a discriminant object on of the sets of repetitions and test it
        % on the other
        cls = fitcdiscr(predictors,categories);
        
        K=cls.Coeffs(1,2).Const;
        L=cls.Coeffs(1,2).Linear;
        thresh=-K/L;
        
        %see how well it did on the training data
        performance_eq(p,c,1)=(sum(categories(find(predictors<thresh))== 1)+...
            sum(categories(find(predictors>thresh))== 2))/numel(categories)
        
        %see how well it did on the test data
        performance_eq(p,c,2)=(sum(testCat(find(testVals<thresh))== 1)+...
            sum(testCat(find(testVals>thresh))== 2))/numel(testCat)
        
    end
    
  
end


  plot(performance_real(:,2))
    hold on
    plot(performance_eq(:,2))
    shg
    set(gcf,'Color','w')
    xTick([1:1:3])
    tic([1:1:3])
    f1=figure()
    set(gcf, 'Color', 'w');
    plot(performance_real)
    hold on
    plot(performance_eq)
    close all
    f1=figure()
    set(gcf, 'Color', 'w');
    plot(performance_real(:,2))
    hold on
    plot(performance_eq(:,2))
    set(gca, 'XTick',[1:1:3])
    f1=figure()
    set(gcf, 'Color', 'w');
    plot(performance_real(:,2))
    hold on
    plot(performance_eq(:,2))
    set(gca, 'XTick',[1:1:3])
    xlabel('Spike Count Difference')
    ylabel('Performance')
    leg={'real contact num', 'equalized'};
    legend(leg, 'Position','NorthWest')
    legend(leg, 'Location','NorthWest')


