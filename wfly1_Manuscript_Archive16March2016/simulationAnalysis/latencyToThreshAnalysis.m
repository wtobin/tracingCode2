%Code to analyze fixed spikecount det task results

%Loop over each PN

PN_Names={'PN1LS','PN2LS', 'PN3LS', 'PN1RS', 'PN2RS'};


   %% Measure  latency to thresh crossing for the real contact num condition
   
    PN=PN_Names{1};
    
    %define the base path to results
    base1Hz=['~/nC_projects/',PN,'_allORNs/simulations/detTask_real_dRate/results_dRate_1Hz'];
    
    % find the names of all reps in the 12 spike REAL case
    real1HzDirs=dir([base1Hz,'/real_*']);
    dataFileName=ls([base1Hz,'/',real1HzDirs(1).name]);
    dataFileName=dataFileName(1:29);
    
    counter=1;
    
    for r=1:size(real1HzDirs,1)
   
        %Load the pnVm
        pnvm_working=importdata([base1Hz,'/',real1HzDirs(r).name, '/',dataFileName]);
        pnVmsCollected_real(1,counter,:)=pnvm_working;
        aboveThresh=find(pnvm_working(4000:8000)>=-45);
        
        if isempty(aboveThresh) == 1
            
            latencyToThresh{1}(counter)=NaN;
            
        elseif aboveThresh(1) == 1
            
            latencyToThresh{1}(counter)=NaN;
            
        else
            
            latencyToThresh{1}(counter)=(aboveThresh(1)+3999)/40;
            
        end
        

        counter=counter+1;
     
    end
    
    
     %define the base path to results
    base3Hz=['~/nC_projects/',PN,'_allORNs/simulations/detTask_real_dRate/results_dRate_3Hz'];
    
    % find the names of all reps in the 12 spike REAL case
    real3HzDirs=dir([base3Hz,'/real_*']);
    dataFileName=ls([base3Hz,'/',real3HzDirs(1).name]);
    dataFileName=dataFileName(1:29);
    
    counter=1;
    
    for r=1:size(real3HzDirs,1)
   
        %Load the pnVm
        pnvm_working=importdata([base3Hz,'/',real3HzDirs(r).name, '/',dataFileName]);
         pnVmsCollected_real(2,counter,:)=pnvm_working;
        aboveThresh=find(pnvm_working(4000:8000)>=-45);
        
        if isempty(aboveThresh) == 1
            
            latencyToThresh{2}(counter)=NaN;
            
       elseif aboveThresh(1) == 1
            
            latencyToThresh{2}(counter)=NaN;
            
        else
            
            latencyToThresh{2}(counter)=(aboveThresh(1)+3999)/40;
            
        end

        counter=counter+1;
     
    end
    
    
     %define the base path to results
    base5Hz=['~/nC_projects/',PN,'_allORNs/simulations/detTask_real_dRate/results_dRate_5Hz'];
    
    % find the names of all reps in the 12 spike REAL case
    real5HzDirs=dir([base5Hz,'/real_*']);
    dataFileName=ls([base5Hz,'/',real5HzDirs(1).name]);
    dataFileName=dataFileName(1:29);
    
    counter=1;
    
    for r=1:size(real5HzDirs,1)
   
        %Load the pnVm
        pnvm_working=importdata([base5Hz,'/',real5HzDirs(r).name, '/',dataFileName]);
         pnVmsCollected_real(3,counter,:)=pnvm_working;
        aboveThresh=find(pnvm_working(4000:8000)>=-45);
        
        if isempty(aboveThresh) == 1
            
            latencyToThresh{3}(counter)=NaN;
            
       elseif aboveThresh(1) == 1
            
            latencyToThresh{3}(counter)=NaN;
            
        else
            
            latencyToThresh{3}(counter)=(aboveThresh(1)+3999)/40;
            
        end
        

        counter=counter+1;
     
    end
    
    
   %% Measure  latency to thresh crossing for the equalized contact num condition
   
   %define the base path to results
    base1Hz=['~/nC_projects/',PN,'_allORNs/simulations/detTask_eq_dRate/results_dRate_1Hz'];
    
    % find the names of all reps in the 12 spike eq case
    eq1HzDirs=dir([base1Hz,'/eq_*']);
    dataFileName=ls([base1Hz,'/',eq1HzDirs(1).name]);
    dataFileName=dataFileName(1:29);
    
    counter=1;
    
    for r=1:size(eq1HzDirs,1)
   
        %Load the pnVm
        pnvm_working=importdata([base1Hz,'/',eq1HzDirs(r).name, '/',dataFileName]);
        pnVmsCollected_eq(1,counter,:)=pnvm_working;
        aboveThresh=find(pnvm_working(4000:8000)>=-45);
        
        if isempty(aboveThresh) == 1
            
            latencyToThresh_eq{1}(counter)=NaN;
            
       elseif aboveThresh(1) == 1
            
            latencyToThresh_eq{1}(counter)=NaN;
            
        else
            
            latencyToThresh_eq{1}(counter)=(aboveThresh(1)+3999)/40;
            
        end
        

        counter=counter+1;
     
    end
    
    
     %define the base path to results
    base3Hz=['~/nC_projects/',PN,'_allORNs/simulations/detTask_eq_dRate/results_dRate_3Hz'];
    
    % find the names of all reps in the 12 spike eq case
    eq3HzDirs=dir([base3Hz,'/eq_*']);
    dataFileName=ls([base3Hz,'/',eq3HzDirs(1).name]);
    dataFileName=dataFileName(1:29);
    
    counter=1;
    
    for r=1:size(eq3HzDirs,1)
   
        %Load the pnVm
        pnvm_working=importdata([base3Hz,'/',eq3HzDirs(r).name, '/',dataFileName]);
        pnVmsCollected_eq(2,counter,:)=pnvm_working;
        aboveThresh=find(pnvm_working(4000:8000)>=-45);
        
        if isempty(aboveThresh) == 1
            
            latencyToThresh_eq{2}(counter)=NaN;
            
       elseif aboveThresh(1) == 1
            
            latencyToThresh_eq{2}(counter)=NaN;
            
        else
            
            latencyToThresh_eq{2}(counter)=(aboveThresh(1)+3999)/40;
            
        end
        

        counter=counter+1;
     
    end
    
    
     %define the base path to results
    base5Hz=['~/nC_projects/',PN,'_allORNs/simulations/detTask_eq_dRate/results_dRate_5Hz'];
    
    % find the names of all reps in the 12 spike eq case
    eq5HzDirs=dir([base5Hz,'/eq_*']);
    dataFileName=ls([base5Hz,'/',eq5HzDirs(1).name]);
    dataFileName=dataFileName(1:29);
    
    counter=1;
    
    for r=1:size(eq5HzDirs,1)
   
        %Load the pnVm
        pnvm_working=importdata([base5Hz,'/',eq5HzDirs(r).name, '/',dataFileName]);
        pnVmsCollected_eq(3,counter,:)=pnvm_working;
        aboveThresh=find(pnvm_working(4000:8000)>=-45);
        
        if isempty(aboveThresh) == 1
            
            latencyToThresh_eq{3}(counter)=NaN;
            
        elseif aboveThresh(1) == 1
            
            latencyToThresh_eq{3}(counter)=NaN;
            
        else
            
            latencyToThresh_eq{3}(counter)=(aboveThresh(1)+3999)/40;
            
        end

        counter=counter+1;
     
    end
    
 
    
    %% plotting analysis
    
    figure()
 subplot(3,1,1)
 histogram(latencyToThresh{1})
 hold on
 histogram(latencyToThresh_eq{1})
 subplot(3,1,2)
 histogram(latencyToThresh{2})
 hold on
 histogram(latencyToThresh_eq{2})
 subplot(3,1,3)
 histogram(latencyToThresh{3})
 hold on
 histogram(latencyToThresh_eq{3})
 
 figure
 
 subplot(2,1,1)
 time=[0:1/40:400];
 plot(time,mean(squeeze(pnVmsCollected_real(1,:,:))),'b')
 hold on
 plot(time,mean(squeeze(pnVmsCollected_real(2,:,:))),'b')
 plot(time,mean(squeeze(pnVmsCollected_real(3,:,:))),'b')   
    
 plot(time, mean(squeeze(pnVmsCollected_eq(1,:,:))),'r')
 plot(time, mean(squeeze(pnVmsCollected_eq(2,:,:))),'r')
 plot(time, mean(squeeze(pnVmsCollected_eq(3,:,:))),'r')   
 
 xlabel('Time (ms)')
 ylabel('Mean PN Vm')
 legend({'Real Contact Nums', 'Equalized'})
 ax=gca;
 ax.FontSize=16;
 
 subplot(2,1,2)
 time=[0:1/40:400];
 plot(time,mean(squeeze(pnVmsCollected_real(1,:,:))),'b')
 hold on
 plot(time,mean(squeeze(pnVmsCollected_real(2,:,:))),'b')
 plot(time,mean(squeeze(pnVmsCollected_real(3,:,:))),'b')   
    
 plot(time, mean(squeeze(pnVmsCollected_eq(1,:,:))),'r')
 plot(time, mean(squeeze(pnVmsCollected_eq(2,:,:))),'r')
 plot(time, mean(squeeze(pnVmsCollected_eq(3,:,:))),'r')   
 xlabel('Time (ms)')
 ylabel('std PN Vm')

 ax=gca;
 ax.FontSize=16;

 
%     
%     
%     for c=1:3
%         
%         if c==1
%             predictors=[real1HzMeans(p,1:2500)';real13Means(p,1:2500)'];
%             categories=[ones(size(real1HzMeans(p,1:2500)'));2*ones(size(real13Means(p,1:2500)'))];
%             testVals=[real1HzMeans(p,2501:end)';real13Means(p,2501:end)'];
%             testCat=[ones(size(real1HzMeans(p,2501:end)'));2*ones(size(real13Means(p,2501:end)'))];
%         elseif c==2
%             predictors=[real1HzMeans(p,1:2500)';real14Means(p,1:2500)'];
%             categories=[ones(size(real1HzMeans(p,1:2500)'));2*ones(size(real14Means(p,1:2500)'))];
%             testVals=[real1HzMeans(p,2501:end)';real14Means(p,2501:end)'];
%             testCat=[ones(size(real1HzMeans(p,2501:end)'));2*ones(size(real14Means(p,2501:end)'))];
%         elseif c==3
%             predictors=[real1HzMeans(p,1:2500)';real15Means(p,1:2500)'];
%             categories=[ones(size(real1HzMeans(p,1:2500)'));2*ones(size(real15Means(p,1:2500)'))];
%             testVals=[real1HzMeans(p,2501:end)';real15Means(p,2501:end)'];
%             testCat=[ones(size(real1HzMeans(p,2501:end)'));2*ones(size(real15Means(p,2501:end)'))];
%         end
%         
%         % Train a discriminant object on of the sets of repetitions and test it
%         % on the other
%         
%         cls = fitcdiscr(predictors,categories);
%         
%         K=cls.Coeffs(1,2).Const;
%         L=cls.Coeffs(1,2).Linear;
%         thresh=-K/L;
%         
%         %see how well it did on the training data
%         
%         performance_real(p,c,1)=(sum(categories(find(predictors<thresh))== 1)+...
%             sum(categories(find(predictors>thresh))== 2))/numel(categories)
%         
%         %see how well it did on the test data
%         performance_real(p,c,2)=(sum(testCat(find(testVals<thresh))== 1)+...
%             sum(testCat(find(testVals>thresh))== 2))/numel(testCat)
%         
%     end
%     
%     
%     
%     for c=1:3
%         
%         if c==1
%             predictors=[eq12Means(p,1:2500)';eq13Means(p,1:2500)'];
%             categories=[ones(size(eq12Means(p,1:2500)'));2*ones(size(eq13Means(p,1:2500)'))];
%             testVals=[eq12Means(p,2501:end)';eq13Means(p,2501:end)'];
%             testCat=[ones(size(eq12Means(p,2501:end)'));2*ones(size(eq13Means(p,2501:end)'))];
%         elseif c==2
%             predictors=[eq12Means(p,1:2500)';eq14Means(p,1:2500)'];
%             categories=[ones(size(eq12Means(p,1:2500)'));2*ones(size(eq14Means(p,1:2500)'))];
%             testVals=[eq12Means(p,2501:end)';eq14Means(p,2501:end)'];
%             testCat=[ones(size(eq12Means(p,2501:end)'));2*ones(size(eq14Means(p,2501:end)'))];
%         elseif c==3
%             predictors=[eq12Means(p,1:2500)';eq15Means(p,1:2500)'];
%             categories=[ones(size(eq12Means(p,1:2500)'));2*ones(size(eq15Means(p,1:2500)'))];
%             testVals=[eq12Means(p,2501:end)';eq15Means(p,2501:end)'];
%             testCat=[ones(size(eq12Means(p,2501:end)'));2*ones(size(eq15Means(p,2501:end)'))];
%         end
%         
%         % Train a discriminant object on of the sets of repetitions and test it
%         % on the other
%         cls = fitcdiscr(predictors,categories);
%         
%         K=cls.Coeffs(1,2).Const;
%         L=cls.Coeffs(1,2).Linear;
%         thresh=-K/L;
%         
%         %see how well it did on the training data
%         performance_eq(p,c,1)=(sum(categories(find(predictors<thresh))== 1)+...
%             sum(categories(find(predictors>thresh))== 2))/numel(categories)
%         
%         %see how well it did on the test data
%         performance_eq(p,c,2)=(sum(testCat(find(testVals<thresh))== 1)+...
%             sum(testCat(find(testVals>thresh))== 2))/numel(testCat)
%         
%     end
%     
%   
%     
% end
% 
% %% Plotting
% 
% 
%     
% plot(performance_real(:,:,2)', 'b')
% hold on
% plot(performance_eq(:,:,2)', 'r')
% 
% 
% set(gcf,'Color','w')
% ax=gca;
% ax.XTick=[1:1:3];
% xlabel('Spike Count Difference')
% ylabel('Performance')
% leg={'real contact num', 'equalized'};
% 
% legend(leg, 'Location','SouthEast')
% 
% saveas(gcf,'spikeCountPerf')
% saveas(gcf,'spikeCountPerf','epsc')
% 
