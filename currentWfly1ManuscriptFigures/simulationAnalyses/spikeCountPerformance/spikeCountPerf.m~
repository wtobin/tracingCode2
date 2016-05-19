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
    
    
    base12_eq=['~/nC_projects/',PN,'_allORNs/simulations/detTask_eq/results_fixedSpike_12Spikes'];
    
    % find the names of all reps in the 12 spike REAL case
    eq12Dirs=dir([base12_eq,'/eq_*']);
    dataFileName=ls([base12_eq,'/',eq12Dirs(1).name]);
    dataFileName=dataFileName(1:29);
    
    counter=1;
    
    for r=1:size(eq12Dirs,1)
        %Load the pnVm
        pnvm_working=importdata([base12_eq,'/',eq12Dirs(r).name, '/',dataFileName]);
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
    
    
    base13_eq=['~/nC_projects/',PN,'_allORNs/simulations/detTask_eq/results_fixedSpike_13Spikes'];
    
    
    
    % find the names of all reps in the 13 spike REAL case
    eq13Dirs=dir([base13_eq,'/eq_*']);
    dataFileName=ls([base13_eq,'/',eq13Dirs(1).name]);
    dataFileName=dataFileName(1:29);
    
    counter=1;
    
    for r=1:size(eq13Dirs,1)
        %Load the pnVm
        pnvm_working=importdata([base13_eq,'/',eq13Dirs(r).name, '/',dataFileName]);
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
    
    
    base14_eq=['~/nC_projects/',PN,'_allORNs/simulations/detTask_eq/results_fixedSpike_14Spikes'];
    
    
    
    
    % find the names of all reps in the 14 spike REAL case
    eq14Dirs=dir([base14_eq,'/eq_*']);
    dataFileName=ls([base14_eq,'/',eq14Dirs(1).name]);
    dataFileName=dataFileName(1:29);
    
    counter=1;
    
    for r=1:size(eq14Dirs,1)
        %Load the pnVm
        pnvm_working=importdata([base14_eq,'/',eq14Dirs(r).name, '/',dataFileName]);
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
    
    
    
    base15_eq=['~/nC_projects/',PN,'_allORNs/simulations/detTask_eq/results_fixedSpike_15Spikes'];
    
    
    
    
    % find the names of all reps in the 15 spike REAL case
    eq15Dirs=dir([base15_eq,'/eq_*']);
    dataFileName=ls([base15_eq,'/',eq15Dirs(1).name]);
    dataFileName=dataFileName(1:29);
    
    counter=1;
    
    for r=1:size(eq15Dirs,1)
        %Load the pnVm
        pnvm_working=importdata([base15_eq,'/',eq15Dirs(r).name, '/',dataFileName]);
        eq15Means(p,counter)=mean(pnvm_working+60);
        % vms_eq15(counter,:)=pnvm_working;
        counter=counter+1;
    end
    
    
    %define the base path to results
    base16=['~/nC_projects/',PN,'_allORNs/simulations/detTask/results_fixedSpike_16Spikes'];
    
    % find the names of all reps in the 15 spike REAL case
    real16Dirs=dir([base16,'/real_*']);
    dataFileName=ls([base16,'/',real16Dirs(1).name]);
    dataFileName=dataFileName(1:29);
    
    counter=1;
    
    for r=1:size(real16Dirs,1)
        
        %Load the pnVm
        pnvm_working=importdata([base16,'/',real16Dirs(r).name, '/',dataFileName]);
        real16Means(p,counter)=mean(pnvm_working+60);
        % vms_real15(counter,:)=pnvm_working;
        counter=counter+1;
        
    end
    
    
    
    base16_eq=['~/nC_projects/',PN,'_allORNs/simulations/detTask_eq/results_fixedSpike_16Spikes'];
    
    
    % find the names of all reps in the 15 spike REAL case
    eq16Dirs=dir([base16_eq,'/eq_*']);
    dataFileName=ls([base16_eq,'/',eq16Dirs(1).name]);
    dataFileName=dataFileName(1:29);
    
    counter=1;
    
    for r=1:size(eq16Dirs,1)
        %Load the pnVm
        pnvm_working=importdata([base16_eq,'/',eq16Dirs(r).name, '/',dataFileName]);
        eq16Means(p,counter)=mean(pnvm_working+60);
        % vms_eq15(counter,:)=pnvm_working;
        counter=counter+1;
    end
    
    
    
    %define the base path to results
    base17=['~/nC_projects/',PN,'_allORNs/simulations/detTask/results_fixedSpike_17Spikes'];
    
    % find the names of all reps in the 15 spike REAL case
    real17Dirs=dir([base17,'/real_*']);
    dataFileName=ls([base17,'/',real17Dirs(1).name]);
    dataFileName=dataFileName(1:29);
    
    counter=1;
    
    for r=1:size(real17Dirs,1)
        
        %Load the pnVm
        pnvm_working=importdata([base17,'/',real17Dirs(r).name, '/',dataFileName]);
        real17Means(p,counter)=mean(pnvm_working+60);
        % vms_real15(counter,:)=pnvm_working;
        counter=counter+1;
        
    end
    
    
    
    base17_eq=['~/nC_projects/',PN,'_allORNs/simulations/detTask_eq/results_fixedSpike_17Spikes'];
    
    
    
    
    % find the names of all reps in the 15 spike REAL case
    eq17Dirs=dir([base17_eq,'/eq_*']);
    dataFileName=ls([base17_eq,'/',eq17Dirs(1).name]);
    dataFileName=dataFileName(1:29);
    
    counter=1;
    
    for r=1:size(eq17Dirs,1)
        %Load the pnVm
        pnvm_working=importdata([base17_eq,'/',eq17Dirs(r).name, '/',dataFileName]);
        eq17Means(p,counter)=mean(pnvm_working+60);
        % vms_eq15(counter,:)=pnvm_working;
        counter=counter+1;
    end
    
    
    
    
    %define the base path to results
    base18=['~/nC_projects/',PN,'_allORNs/simulations/detTask/results_fixedSpike_18Spikes'];
    
    % find the names of all reps in the 15 spike REAL case
    real18Dirs=dir([base18,'/real_*']);
    dataFileName=ls([base18,'/',real18Dirs(1).name]);
    dataFileName=dataFileName(1:29);
    
    counter=1;
    
    for r=1:size(real18Dirs,1)
        
        %Load the pnVm
        pnvm_working=importdata([base18,'/',real18Dirs(r).name, '/',dataFileName]);
        real18Means(p,counter)=mean(pnvm_working+60);
        % vms_real15(counter,:)=pnvm_working;
        counter=counter+1;
        
    end
    
    
    
    base18_eq=['~/nC_projects/',PN,'_allORNs/simulations/detTask_eq/results_fixedSpike_18Spikes'];
    
    
    
    
    % find the names of all reps in the 15 spike REAL case
    eq18Dirs=dir([base18_eq,'/eq_*']);
    dataFileName=ls([base18_eq,'/',eq18Dirs(1).name]);
    dataFileName=dataFileName(1:29);
    
    counter=1;
    
    for r=1:size(eq18Dirs,1)
        %Load the pnVm
        pnvm_working=importdata([base18_eq,'/',eq18Dirs(r).name, '/',dataFileName]);
        eq18Means(p,counter)=mean(pnvm_working+60);
        % vms_eq15(counter,:)=pnvm_working;
        counter=counter+1;
    end
    
    
    
    
    %define the base path to results
    base19=['~/nC_projects/',PN,'_allORNs/simulations/detTask/results_fixedSpike_19Spikes'];
    
    % find the names of all reps in the 19 spike REAL case
    real19Dirs=dir([base19,'/real_*']);
    dataFileName=ls([base19,'/',real19Dirs(1).name]);
    dataFileName=dataFileName(1:29);
    
    counter=1;
    
    for r=1:size(real19Dirs,1)
        
        %Load the pnVm
        pnvm_working=importdata([base19,'/',real19Dirs(r).name, '/',dataFileName]);
        real19Means(p,counter)=mean(pnvm_working+60);
        % vms_real19(counter,:)=pnvm_working;
        counter=counter+1;
        
    end
    
    
    
    base19_eq=['~/nC_projects/',PN,'_allORNs/simulations/detTask_eq/results_fixedSpike_19Spikes'];
    
    
    
    
    % find the names of all reps in the 19 spike REAL case
    eq19Dirs=dir([base19_eq,'/eq_*']);
    dataFileName=ls([base19_eq,'/',eq19Dirs(1).name]);
    dataFileName=dataFileName(1:29);
    
    counter=1;
    
    for r=1:size(eq19Dirs,1)
        %Load the pnVm
        pnvm_working=importdata([base19_eq,'/',eq19Dirs(r).name, '/',dataFileName]);
        eq19Means(p,counter)=mean(pnvm_working+60);
        % vms_eq19(counter,:)=pnvm_working;
        counter=counter+1;
    end
    
    
    
    
    %define the base path to results
    base20=['~/nC_projects/',PN,'_allORNs/simulations/detTask/results_fixedSpike_20Spikes'];
    
    % find the names of all reps in the 20 spike REAL case
    real20Dirs=dir([base20,'/real_*']);
    dataFileName=ls([base20,'/',real20Dirs(1).name]);
    dataFileName=dataFileName(1:29);
    
    counter=1;
    
    for r=1:size(real20Dirs,1)
        
        %Load the pnVm
        pnvm_working=importdata([base20,'/',real20Dirs(r).name, '/',dataFileName]);
        real20Means(p,counter)=mean(pnvm_working+60);
        % vms_real20(counter,:)=pnvm_working;
        counter=counter+1;
        
    end
    
    
    
    base20_eq=['~/nC_projects/',PN,'_allORNs/simulations/detTask_eq/results_fixedSpike_20Spikes'];
    
    
    
    
    % find the names of all reps in the 20 spike REAL case
    eq20Dirs=dir([base20_eq,'/eq_*']);
    dataFileName=ls([base20_eq,'/',eq20Dirs(1).name]);
    dataFileName=dataFileName(1:29);
    
    counter=1;
    
    for r=1:size(eq20Dirs,1)
        %Load the pnVm
        pnvm_working=importdata([base20_eq,'/',eq20Dirs(r).name, '/',dataFileName]);
        eq20Means(p,counter)=mean(pnvm_working+60);
        % vms_eq20(counter,:)=pnvm_working;
        counter=counter+1;
    end
    
    
    for c=0:8
        
        if c==0
            predictors=[real12Means(p,1:2500)';real12Means(p,2501:5000)'];
            categories=[ones(size(real12Means(p,1:2500)'));2*ones(size(real12Means(p,2501:5000)'))];
            testVals=[real12Means(p,5001:7500)';real12Means(p,7501:end)'];
            testCat=[ones(size(real12Means(p,5001:7500)'));2*ones(size(real12Means(p,7501:end)'))];
        elseif c==1
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
            
        elseif c==4
            predictors=[real12Means(p,1:2500)';real16Means(p,1:2500)'];
            categories=[ones(size(real12Means(p,1:2500)'));2*ones(size(real16Means(p,1:2500)'))];
            testVals=[real12Means(p,2501:end)';real16Means(p,2501:end)'];
            testCat=[ones(size(real12Means(p,2501:end)'));2*ones(size(real16Means(p,2501:end)'))];
            
        elseif c==5
            predictors=[real12Means(p,1:2500)';real17Means(p,1:2500)'];
            categories=[ones(size(real12Means(p,1:2500)'));2*ones(size(real17Means(p,1:2500)'))];
            testVals=[real12Means(p,2501:end)';real17Means(p,2501:end)'];
            testCat=[ones(size(real12Means(p,2501:end)'));2*ones(size(real17Means(p,2501:end)'))];
            
            
        elseif c==6
            predictors=[real12Means(p,1:2500)';real18Means(p,1:2500)'];
            categories=[ones(size(real12Means(p,1:2500)'));2*ones(size(real18Means(p,1:2500)'))];
            testVals=[real12Means(p,2501:end)';real18Means(p,2501:end)'];
            testCat=[ones(size(real12Means(p,2501:end)'));2*ones(size(real18Means(p,2501:end)'))];
            
            
        elseif c==7
            predictors=[real12Means(p,1:2500)';real19Means(p,1:2500)'];
            categories=[ones(size(real12Means(p,1:2500)'));2*ones(size(real19Means(p,1:2500)'))];
            testVals=[real12Means(p,2501:end)';real19Means(p,2501:end)'];
            testCat=[ones(size(real12Means(p,2501:end)'));2*ones(size(real19Means(p,2501:end)'))];
            
        elseif c==8
            predictors=[real12Means(p,1:2500)';real20Means(p,1:2500)'];
            categories=[ones(size(real12Means(p,1:2500)'));2*ones(size(real20Means(p,1:2500)'))];
            testVals=[real12Means(p,2501:end)';real20Means(p,2501:end)'];
            testCat=[ones(size(real12Means(p,2501:end)'));2*ones(size(real20Means(p,2501:end)'))];
            
        end
        
        % Train a discriminant object on of the sets of repetitions and test it
        % on the other
        
        cls = fitcdiscr(predictors,categories);
        
        K=cls.Coeffs(1,2).Const;
        L=cls.Coeffs(1,2).Linear;
        thresh=-K/L;
        
        %see how well it did on the training data
        
        performance_real(p,c+1,1)=(sum(categories(find(predictors<thresh))== 1)+...
            sum(categories(find(predictors>thresh))== 2))/numel(categories)
        
        %see how well it did on the test data
        performance_real(p,c+1,2)=(sum(testCat(find(testVals<thresh))== 1)+...
            sum(testCat(find(testVals>thresh))== 2))/numel(testCat)
        
    end
    
    
    
    for c=0:8
        
        if c==0
            predictors=[eq12Means(p,1:2500)';eq12Means(p,2501:5000)'];
            categories=[ones(size(eq12Means(p,1:2500)'));2*ones(size(eq12Means(p,2501:5000)'))];
            testVals=[eq12Means(p,5001:7500)';eq12Means(p,7501:end)'];
            testCat=[ones(size(eq12Means(p,5001:7500)'));2*ones(size(eq12Means(p,7501:end)'))];
        elseif c==1
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
            
        elseif c==4
            predictors=[eq12Means(p,1:2500)';eq16Means(p,1:2500)'];
            categories=[ones(size(eq12Means(p,1:2500)'));2*ones(size(eq16Means(p,1:2500)'))];
            testVals=[eq12Means(p,2501:end)';eq16Means(p,2501:end)'];
            testCat=[ones(size(eq12Means(p,2501:end)'));2*ones(size(eq16Means(p,2501:end)'))];
            
        elseif c==5
            predictors=[eq12Means(p,1:2500)';eq17Means(p,1:2500)'];
            categories=[ones(size(eq12Means(p,1:2500)'));2*ones(size(eq17Means(p,1:2500)'))];
            testVals=[eq12Means(p,2501:end)';eq17Means(p,2501:end)'];
            testCat=[ones(size(eq12Means(p,2501:end)'));2*ones(size(eq17Means(p,2501:end)'))];
            
            
        elseif c==6
            predictors=[eq12Means(p,1:2500)';eq18Means(p,1:2500)'];
            categories=[ones(size(eq12Means(p,1:2500)'));2*ones(size(eq18Means(p,1:2500)'))];
            testVals=[eq12Means(p,2501:end)';eq18Means(p,2501:end)'];
            testCat=[ones(size(eq12Means(p,2501:end)'));2*ones(size(eq18Means(p,2501:end)'))];
            
            
        elseif c==7
            predictors=[eq12Means(p,1:2500)';eq19Means(p,1:2500)'];
            categories=[ones(size(eq12Means(p,1:2500)'));2*ones(size(eq19Means(p,1:2500)'))];
            testVals=[eq12Means(p,2501:end)';eq19Means(p,2501:end)'];
            testCat=[ones(size(eq12Means(p,2501:end)'));2*ones(size(eq19Means(p,2501:end)'))];
            
        elseif c==8
            predictors=[eq12Means(p,1:2500)';eq20Means(p,1:2500)'];
            categories=[ones(size(eq12Means(p,1:2500)'));2*ones(size(eq20Means(p,1:2500)'))];
            testVals=[eq12Means(p,2501:end)';eq20Means(p,2501:end)'];
            testCat=[ones(size(eq12Means(p,2501:end)'));2*ones(size(eq20Means(p,2501:end)'))];
            
        end
        
        % Train a discriminant object on of the sets of repetitions and test it
        % on the other
        cls = fitcdiscr(predictors,categories);
        
        K=cls.Coeffs(1,2).Const;
        L=cls.Coeffs(1,2).Linear;
        thresh=-K/L;
        
        %see how well it did on the training data
        performance_eq(p,c+1,1)=(sum(categories(find(predictors<thresh))== 1)+...
            sum(categories(find(predictors>thresh))== 2))/numel(categories)
        
        %see how well it did on the test data
        performance_eq(p,c+1,2)=(sum(testCat(find(testVals<thresh))== 1)+...
            sum(testCat(find(testVals>thresh))== 2))/numel(testCat)
        
    end
    
    
    
end

%% Plotting



plot(performance_real(:,:,2)', 'b')
hold on
plot(performance_eq(:,:,2)', 'r')


set(gcf,'Color','w')
ax=gca;
ax.XTick=[1:1:3];
xlabel('Spike Count Difference')
ylabel('Performance')
leg={'real contact num', 'equalized'};

legend(leg, 'Location','SouthEast')

saveas(gcf,'spikeCountPerf')
saveas(gcf,'spikeCountPerf','epsc')

