% Code to analyse lateralization simulation data

PN_Names={'PN1LS','PN2LS', 'PN3LS', 'PN1RS', 'PN2RS'};

%Loop over changes in left and right PN spike numbers
for s=1:2
   
    if s==1
        
       dSpikeCounter=1;
        %loop over spike numbers
        for d=[12:15]
            
        %loop over PNs, loading all 
         for p=1:5
            
            
           pn=PN_Names{p};
           base=['/home/simulation/nC_projects_retired160201/',pn,'_allORNs/simulations/latTask/results_fixedSpikeCount/'];
           resultFiles=dir([base,'real_L',num2str(d),'_R12_rep*']);
           dataFileName=ls([base,resultFiles(1).name]);
           dataFileName=strtrim(dataFileName(1:29));

           
          
           for t=1:length(resultFiles)
              
               pnvm_working=importdata([base,resultFiles(t).name, '/',dataFileName]);
               vmMeans(s,dSpikeCounter,p,t)=mean(pnvm_working+60);
               
           end
      
        
         end
        
        dSpikeCounter=dSpikeCounter+1;
        
        end
        
    else
        
       dSpikeCounter=1;
        %loop over spike numbers
        for d=[12:15]
            
        %loop over PNs, loading all 
        for p=1:5
            
           pn=PN_Names{p};
           base=['/home/simulation/nC_projects_retired160201/',pn,'_allORNs/simulations/latTask/results_fixedSpikeCount/'];
           resultFiles=dir([base,'real_L12_R',num2str(d),'_rep*']);
           dataFileName=ls([base,resultFiles(1).name]);
           dataFileName=strtrim(dataFileName(1:29));

           
           
           for t=1:length(resultFiles)
               
               pnvm_working=importdata([base,resultFiles(t).name, '/',dataFileName]);
               vmMeans(s,dSpikeCounter,p,t)=mean(pnvm_working+60);
               
           end
        
        
        end
        dSpikeCounter=dSpikeCounter+1;
        
        end  
        
    end
    
    
    
    
end



%Loop over changes in left and right PN spike numbers
for s=1:2
   
    if s==1
        
       dSpikeCounter=1;
        %loop over spike numbers
        for d=[12:15]
            
        %loop over PNs, loading all 
         for p=1:5
            
            
           pn=PN_Names{p};
           base=['/home/simulation/nC_projects_retired160201/',pn,'_allORNs/simulations/latTask/results_fixedSpikeCount/'];
           resultFiles=dir([base,'eq_L',num2str(d),'_R12_rep*']);
           dataFileName=ls([base,resultFiles(1).name]);
           dataFileName=strtrim(dataFileName(1:29));

           
          
           for t=1:length(resultFiles)
              
               pnvm_working=importdata([base,resultFiles(t).name, '/',dataFileName]);
               vmMeans_eq(s,dSpikeCounter,p,t)=mean(pnvm_working+60);
               
           end
      
        
         end
        
        dSpikeCounter=dSpikeCounter+1;
        
        end
        
    else
        
       dSpikeCounter=1;
        %loop over spike numbers
        for d=[12:15]
            
        %loop over PNs, loading all 
        for p=1:5
            
           pn=PN_Names{p};
           base=['/home/simulation/nC_projects_retired160201/',pn,'_allORNs/simulations/latTask/results_fixedSpikeCount/'];
           resultFiles=dir([base,'eq_L12_R',num2str(d),'_rep*']);
           dataFileName=ls([base,resultFiles(1).name]);
           dataFileName=strtrim(dataFileName(1:29));

           
           
           for t=1:length(resultFiles)
               
               pnvm_working=importdata([base,resultFiles(t).name, '/',dataFileName]);
               vmMeans_eq(s,dSpikeCounter,p,t)=mean(pnvm_working+60);
               
           end
        
        
        end
        dSpikeCounter=dSpikeCounter+1;
        
        end  
        
    end
    
    
    
    
end


%% Analysis

%loop over spike num differences
for s=1:2

    
if s==1
  
for l=1:2
    
    figure()
  
for d=1:4
    
subplot(2,2,d)

meansL=mean(squeeze(vmMeans(l,d,1:3,:)));
meansR=mean(squeeze(vmMeans(l,d,4:5,:)));


histogram(meansL)
hold on
histogram(meansR)

xlim([4 8])

if l ==1
    
title([num2str(d-1) ' more spikes in L ORNs'])
meanDiffL=['meanL - meanR = ',num2str(mean(meansL)-mean(meansR))];
text(6.5,350,meanDiffL)
legend({'L PNs', 'R PNs'}, 'Location', 'NorthWest')

else
    
title([num2str(d-1) ' more spikes in R ORNs'])
meanDiffL=['meanL - meanR = ',num2str(mean(meansL)-mean(meansR))];
text(6.5,350,meanDiffL)
legend({'L PNs', 'R PNs'}, 'Location', 'NorthWest') 

end

end

end

else
    
   
for l=1:2
    
    figure()
  
for d=1:4
    
subplot(2,2,d)

meansL=mean(squeeze(vmMeans_eq(l,d,1:3,:)));
meansR=mean(squeeze(vmMeans_eq(l,d,4:5,:)));


histogram(meansL)
hold on
histogram(meansR)

xlim([4 8])

if l ==1
    
title([num2str(d-1) ' more spikes in L ORNs'])
meanDiffL=['meanL - meanR = ',num2str(mean(meansL)-mean(meansR))];
text(6.5,350,meanDiffL)
legend({'L PNs', 'R PNs'}, 'Location', 'NorthWest')

else
    
title([num2str(d-1) ' more spikes in R ORNs'])
meanDiffL=['meanL - meanR = ',num2str(mean(meansL)-mean(meansR))];
text(6.5,350,meanDiffL)
legend({'L PNs', 'R PNs'}, 'Location', 'NorthWest') 

end

end

end
   
end


end

clear meanDiffL

%% This segement of code plots histograms of mean differences for increments in L ORN spikes

%loop over real and eq
for s=1:2

    
if s==1
  
    
%loop over incremented activity on either side

    
 figure() 
 set(gcf, 'Color', 'w')
 subplot(2,1,1)
 
%Loop over differences in spike Num
for d=1:4
    


meansL=mean(squeeze(vmMeans(1,d,1:3,:)));
meansR=mean(squeeze(vmMeans(1,d,4:5,:)));

meanDiffL(d,:)=meansL-meansR;


histogram(meanDiffL(d,:), 46)
hold on



end

xlabel('Mean L PN Response -Mean R PN Response')
ylabel('Freq')
title('Real Contact Nums')
legend({'Equal Spikes', 'Plus 1 L Spike', 'Plus 2 L Spikes', 'Plus 3 L Spikes'}, 'Location', 'NorthWest')

else
    
   

    
subplot(2,1,2)
  
for d=1:4
   

meansL=mean(squeeze(vmMeans_eq(1,d,1:3,:)));
meansR=mean(squeeze(vmMeans_eq(1,d,4:5,:)));

meanDiff_eq(d,:)=meansL-meansR;


histogram(meanDiff_eq(d,:), 46)
hold on


end

xlabel('Mean L PN Response -Mean R PN Response')
ylabel('Freq')
title('Equalized Contact Nums')
legend({'Equal Spikes', 'Plus 1 L Spike', 'Plus 2 L Spikes', 'Plus 3 L Spikes'}, 'Location', 'NorthWest')

end
   



end


for c=1:3
    
    if c==1
        
        predictors=[meanDiffL(1,1:2500)';meanDiffL(2,1:2500)'];
        categories=[ones(size(meanDiffL(1,1:2500)'));2*ones(size(meanDiffL(2,1:2500)'))];
        
        testVals=[meanDiffL(1,2501:end)';meanDiffL(2,2501:end)'];
        testCat=[ones(size(meanDiffL(1,2501:end)'));2*ones(size(meanDiffL(2,2501:end)'))];
        
    elseif c==2
        
        predictors=[meanDiffL(1,1:2500)';meanDiffL(3,1:2500)'];
        categories=[ones(size(meanDiffL(1,1:2500)'));2*ones(size(meanDiffL(3,1:2500)'))];
        
        testVals=[meanDiffL(1,2501:end)';meanDiffL(3,2501:end)'];
        testCat=[ones(size(meanDiffL(1,2501:end)'));2*ones(size(meanDiffL(3,2501:end)'))];
        
    elseif c==3
        
        predictors=[meanDiffL(1,1:2500)';meanDiffL(4,1:2500)'];
        categories=[ones(size(meanDiffL(1,1:2500)'));2*ones(size(meanDiffL(4,1:2500)'))];
        
        testVals=[meanDiffL(1,2501:end)';meanDiffL(4,2501:end)'];
        testCat=[ones(size(meanDiffL(1,2501:end)'));2*ones(size(meanDiffL(4,2501:end)'))];
        
        
    end

% Train a discriminant object on of the sets of repetitions and test it
% on the other

cls = fitcdiscr(predictors,categories);
K=cls.Coeffs(1,2).Const;
L=cls.Coeffs(1,2).Linear;
thresh=-K/L;

%see how well it did on the training data

performance_realL(c,1)=(sum(categories(find(predictors<thresh))== 1)+...
sum(categories(find(predictors>thresh))== 2))/numel(categories)

%see how well it did on the test data
performance_realL(c,2)=(sum(testCat(find(testVals<thresh))== 1)+...
sum(testCat(find(testVals>thresh))== 2))/numel(testCat)

end



for c=1:3
    
    if c==1
        
        predictors=[meanDiff_eq(1,1:2500)';meanDiff_eq(2,1:2500)'];
        categories=[ones(size(meanDiff_eq(1,1:2500)'));2*ones(size(meanDiff_eq(2,1:2500)'))];
        
        testVals=[meanDiff_eq(1,2501:end)';meanDiff_eq(2,2501:end)'];
        testCat=[ones(size(meanDiff_eq(1,2501:end)'));2*ones(size(meanDiff_eq(2,2501:end)'))];
        
    elseif c==2
        
        predictors=[meanDiff_eq(1,1:2500)';meanDiff_eq(3,1:2500)'];
        categories=[ones(size(meanDiff_eq(1,1:2500)'));2*ones(size(meanDiff_eq(3,1:2500)'))];
        
        testVals=[meanDiff_eq(1,2501:end)';meanDiff_eq(3,2501:end)'];
        testCat=[ones(size(meanDiff_eq(1,2501:end)'));2*ones(size(meanDiff_eq(3,2501:end)'))];
        
    elseif c==3
        
        predictors=[meanDiff_eq(1,1:2500)';meanDiff_eq(4,1:2500)'];
        categories=[ones(size(meanDiff_eq(1,1:2500)'));2*ones(size(meanDiff_eq(4,1:2500)'))];
        
        testVals=[meanDiff_eq(1,2501:end)';meanDiff_eq(4,2501:end)'];
        testCat=[ones(size(meanDiff_eq(1,2501:end)'));2*ones(size(meanDiff_eq(4,2501:end)'))];
        
        
    end

% Train a discriminant object on of the sets of repetitions and test it
% on the other

cls = fitcdiscr(predictors,categories);
K=cls.Coeffs(1,2).Const;
L=cls.Coeffs(1,2).Linear;
thresh=-K/L;

%see how well it did on the training data

performance_eqL(c,1)=(sum(categories(find(predictors<thresh))== 1)+...
sum(categories(find(predictors>thresh))== 2))/numel(categories)

%see how well it did on the test data
performance_eqL(c,2)=(sum(testCat(find(testVals<thresh))== 1)+...
sum(testCat(find(testVals>thresh))== 2))/numel(testCat)

end

figure()
set(gcf, 'Color', 'w')

plot(performance_realL(:,2))
hold on
plot(performance_eqL(:,2))
ax=gca;
ax.XTick=[1:1:3];

xlabel('Num of additional spikes in L ORN pool')
ylabel('Lin Disc Classifier Performance')
legend({'real contact nums', 'Equalized Contact Nums'}, 'Location', 'Northwest')
title('discriminability of difference histograms')

%% This segement of code plots histograms of mean differences for increments in R ORN spikes

%loop over real and eq
for s=1:2

    
if s==1
  
    
%loop over incremented activity on either side

    
 figure() 
 set(gcf,'Color','w')
 subplot(2,1,1)
%Loop over differences in spike Num
for d=1:4
    


meansL=mean(squeeze(vmMeans(2,d,1:3,:)));
meansR=mean(squeeze(vmMeans(2,d,4:5,:)));

meanDiffR(d,:)=meansR-meansL;


histogram(meanDiffR(d,:), 46)
hold on



end


title('Real Contact Nums')
legend({'Equal Spikes', 'Plus 1 R Spike', 'Plus 2 R Spikes', 'Plus 3 R Spikes'}, 'Location', 'NorthWest')

   

else
    
   

 subplot(2,1,2)
  
for d=1:4
   

meansL=mean(squeeze(vmMeans_eq(2,d,1:3,:)));
meansR=mean(squeeze(vmMeans_eq(2,d,4:5,:)));

meanDiff_eq(d,:)=meansR-meansL;


histogram(meanDiff_eq(d,:), 46)
hold on


end

xlabel('Mean R PN Response -Mean L PN Response')
ylabel('Freq')
title('Equalized Contact Nums')
legend({'Equal Spikes', 'Plus 1 R Spike', 'Plus 2 R Spikes', 'Plus 3 R Spikes'}, 'Location', 'NorthWest')


end
   



end


for c=1:3
    
    if c==1
        
        predictors=[meanDiffR(1,1:2500)';meanDiffR(2,1:2500)'];
        categories=[ones(size(meanDiffR(1,1:2500)'));2*ones(size(meanDiffR(2,1:2500)'))];
        
        testVals=[meanDiffR(1,2501:end)';meanDiffR(2,2501:end)'];
        testCat=[ones(size(meanDiffR(1,2501:end)'));2*ones(size(meanDiffR(2,2501:end)'))];
        
    elseif c==2
        
        predictors=[meanDiffR(1,1:2500)';meanDiffR(3,1:2500)'];
        categories=[ones(size(meanDiffR(1,1:2500)'));2*ones(size(meanDiffR(3,1:2500)'))];
        
        testVals=[meanDiffR(1,2501:end)';meanDiffR(3,2501:end)'];
        testCat=[ones(size(meanDiffR(1,2501:end)'));2*ones(size(meanDiffR(3,2501:end)'))];
        
    elseif c==3
        
        predictors=[meanDiffR(1,1:2500)';meanDiffR(4,1:2500)'];
        categories=[ones(size(meanDiffR(1,1:2500)'));2*ones(size(meanDiffR(4,1:2500)'))];
        
        testVals=[meanDiffR(1,2501:end)';meanDiffR(4,2501:end)'];
        testCat=[ones(size(meanDiffR(1,2501:end)'));2*ones(size(meanDiffR(4,2501:end)'))];
        
        
    end

% Train a discriminant object on of the sets of repetitions and test it
% on the other

cls = fitcdiscr(predictors,categories);
K=cls.Coeffs(1,2).Const;
L=cls.Coeffs(1,2).Linear;
thresh=-K/L;

%see how well it did on the training data

performance_realR(c,1)=(sum(categories(find(predictors<thresh))== 1)+...
sum(categories(find(predictors>thresh))== 2))/numel(categories)

%see how well it did on the test data
performance_realR(c,2)=(sum(testCat(find(testVals<thresh))== 1)+...
sum(testCat(find(testVals>thresh))== 2))/numel(testCat)

end



for c=1:3
    
    if c==1
        
        predictors=[meanDiff_eq(1,1:2500)';meanDiff_eq(2,1:2500)'];
        categories=[ones(size(meanDiff_eq(1,1:2500)'));2*ones(size(meanDiff_eq(2,1:2500)'))];
        
        testVals=[meanDiff_eq(1,2501:end)';meanDiff_eq(2,2501:end)'];
        testCat=[ones(size(meanDiff_eq(1,2501:end)'));2*ones(size(meanDiff_eq(2,2501:end)'))];
        
    elseif c==2
        
        predictors=[meanDiff_eq(1,1:2500)';meanDiff_eq(3,1:2500)'];
        categories=[ones(size(meanDiff_eq(1,1:2500)'));2*ones(size(meanDiff_eq(3,1:2500)'))];
        
        testVals=[meanDiff_eq(1,2501:end)';meanDiff_eq(3,2501:end)'];
        testCat=[ones(size(meanDiff_eq(1,2501:end)'));2*ones(size(meanDiff_eq(3,2501:end)'))];
        
    elseif c==3
        
        predictors=[meanDiff_eq(1,1:2500)';meanDiff_eq(4,1:2500)'];
        categories=[ones(size(meanDiff_eq(1,1:2500)'));2*ones(size(meanDiff_eq(4,1:2500)'))];
        
        testVals=[meanDiff_eq(1,2501:end)';meanDiff_eq(4,2501:end)'];
        testCat=[ones(size(meanDiff_eq(1,2501:end)'));2*ones(size(meanDiff_eq(4,2501:end)'))];
        
        
    end

% Train a discriminant object on of the sets of repetitions and test it
% on the other

cls = fitcdiscr(predictors,categories);
K=cls.Coeffs(1,2).Const;
L=cls.Coeffs(1,2).Linear;
thresh=-K/L;

%see how well it did on the training data

performance_eqR(c,1)=(sum(categories(find(predictors<thresh))== 1)+...
sum(categories(find(predictors>thresh))== 2))/numel(categories)

%see how well it did on the test data
performance_eqR(c,2)=(sum(testCat(find(testVals<thresh))== 1)+...
sum(testCat(find(testVals>thresh))== 2))/numel(testCat)

end

figure()
set(gcf, 'Color', 'w')

plot(performance_realR(:,2))
hold on
plot(performance_eqR(:,2))

ax=gca;
ax.XTick=[1:1:3];

xlabel('Num of additional spikes in R ORN pool')
ylabel('Performance')
legend({'Real Contact Nums', 'Equalized Contact Nums'}, 'Location', 'Northwest')
title('discriminability of difference histograms')




%% Plotting


figure()
set(gcf, 'Color', 'w')

plot([performance_realL(:,2),performance_realR(:,2)] ,'b')
hold on
plot([performance_eqL(:,2),performance_eqR(:,2)] ,'r')

ax=gca;
ax.XTick=[1:1:3]
xlabel('Spike Difference')
ylabel('Performance')
legend({'Real Contact Numbers', 'Equalized Contact Numbers'}, 'Location', 'NorthWest')

saveas(gcf,'lateralizationPerformance','epsc')
saveas(gcf,'lateralizationPerformance')
