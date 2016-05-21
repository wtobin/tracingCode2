% Code to analyse lateralization simulation data

PN_Names={'PN1LS','PN2LS', 'PN3LS', 'PN1RS', 'PN2RS'};

%Loop over changes in left and right PN spike numbers
for s=1:2
   
    if s==1
        
       dSpikeCounter=1;
        %loop over spike numbers
        for d=[12:21]
            
        %loop over PNs, loading all 
         for p=1:5
            
            
           pn=PN_Names{p};
           base=['/home/simulation/nC_projects/',pn,'_allORNs/simulations/latTask/results_fixedSpikeCount/'];
           resultFiles=dir([base,'real_L',num2str(d),'_R12_rep*']);
           dataFileName=ls([base,resultFiles(1).name]);
           dataFileName=strtrim(dataFileName(1:29));

           
          
           for t=1:length(resultFiles)
              tic
               pnvm_working=importdata([base,resultFiles(t).name, '/',dataFileName]);
               vmMeans(s,dSpikeCounter,p,t)=mean(pnvm_working+60);
               toc
           end
      
        
         end
        
        dSpikeCounter=dSpikeCounter+1;
        
        end
        
    else
        
       dSpikeCounter=1;
        %loop over spike numbers
        for d=[12:21]
            
        %loop over PNs, loading all 
        for p=1:5
            
           pn=PN_Names{p};
           base=['/home/simulation/nC_projects/',pn,'_allORNs/simulations/latTask/results_fixedSpikeCount/'];
           resultFiles=dir([base,'real_L12_R',num2str(d),'_rep*']);
           dataFileName=ls([base,resultFiles(1).name]);
           dataFileName=strtrim(dataFileName(1:29));

           
           
           for t=1:length(resultFiles)
               
               pnvm_working=importdata([base,resultFiles(t).name, '/',dataFileName]);
               vmMeans(s,dSpikeCounter,p,t)=mean(pnvm_working+60);
%                pnVms(p,t,:)=pnvm_working;
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
        for d=[12:21]
            
        %loop over PNs, loading all 
         for p=1:5
            
            
           pn=PN_Names{p};
           base=['/home/simulation/nC_projects/',pn,'_allORNs/simulations/latTask_eq/results_fixedSpikeCount/'];
           resultFiles=dir([base,'eq_L',num2str(d),'_R12_rep*']);
           dataFileName=ls([base,resultFiles(1).name]);
           dataFileName=strtrim(dataFileName(1:29));

           
          
           for t=1:length(resultFiles)
         
               pnvm_working=importdata([base,resultFiles(t).name, '/',dataFileName]);
               vmMeans_eq(s,dSpikeCounter,p,t)=mean(pnvm_working+60);
%                pnVms(p,t,:)=pnvm_working;
               
           end
      
        
         end
        
        dSpikeCounter=dSpikeCounter+1;
        
        end
        
    else
        
       dSpikeCounter=1;
        %loop over spike numbers
        for d=[12:21]
            
        %loop over PNs, loading all 
        for p=1:5
            
           pn=PN_Names{p};
           base=['/home/simulation/nC_projects/',pn,'_allORNs/simulations/latTask_eq/results_fixedSpikeCount/'];
           resultFiles=dir([base,'eq_L12_R',num2str(d),'_rep*']);
           dataFileName=ls([base,resultFiles(1).name]);
           dataFileName=strtrim(dataFileName(1:29));

           
           
           for t=1:length(resultFiles)
               
               pnvm_working=importdata([base,resultFiles(t).name, '/',dataFileName]);
               vmMeans_eq(s,dSpikeCounter,p,t)=mean(pnvm_working+60);
%                pnVms(p,t,:)=pnvm_working;
           end
        
        
        end
        dSpikeCounter=dSpikeCounter+1;
        
        end  
        
    end
    
    
    
    
end



%% Analysis

% For real and equalized contact numbers

for s=1:2

    
if s==1
  
    
% Loop over changes in left and right spike count

for l=1:2
    
    
for d=1:10
    


allVms=squeeze(vmMeans(l,d,:,:));
allVms(:,any(allVms==0))=[];

meanLeft=mean(allVms(1:3,:));
meanRight=mean(allVms(4:5,:));

% histogram(meanLeft,46)
% hold on
% histogram(meanRight,46)

meanLeft(l,d,:)=mean(meanLeft);
meanRight(l,d,:)=mean(meanRight);

% 
%  xlim([0 30])
% 
% if l ==1
%     
% title([num2str(d-1) ' more spikes in L ORNs'])
% meanDiffL=['left Sum - right Sum = ',num2str(mean(meanLeft)-mean(meanRight))];
% text(5,200,meanDiffL)
% legend({'L PNs', 'R PNs'}, 'Location', 'NorthWest')
% 
% else
%     
% title([num2str(d-1) ' more spikes in R ORNs'])
% meanDiffL=['left Sum - right Sum = ',num2str(mean(meanLeft)-mean(meanRight))];
% text(5,200,meanDiffL)
% legend({'L PNs', 'R PNs'}, 'Location', 'NorthWest') 
% 
% end

end

end

else
    
   
for l=1:2
    
   
  
for d=1:10
    


allVms=squeeze(vmMeans_eq(l,d,:,:));
allVms(:,any(allVms==0))=[];

meanLeft=mean(allVms(1:3,:));
meanRight=mean(allVms(4:5,:));
% 
% histogram(meanLeft,46)
% hold on
% histogram(meanRight,46)
% 
% xlim([0 30])


meanLeft_eq(l,d,:)=mean(meanLeft);
meanRight_eq(l,d,:)=mean(meanRight);

% 
% 
% if l ==1
%     
% title([num2str(d-1) ' more spikes in L ORNs'])
% meanDiffR=['left Sum - right Sum = ',num2str(mean(meanLeft)-mean(meanRight))];
% text(5,200,meanDiffR)
% legend({'L PNs', 'R PNs'}, 'Location', 'NorthWest')
% 
% else
%     
% title([num2str(d-1) ' more spikes in R ORNs'])
% meanDiffR=['left Sum - right Sum = ',num2str(mean(meanLeft)-mean(meanRight))];
% text(5,200,meanDiffR)
% legend({'L PNs', 'R PNs'}, 'Location', 'NorthWest') 
% 
% end

end

end
   
end


end



%% This segement of code plots histograms of mean differences for increments in L ORN spikes


load('vmMeans_eq.mat')
load('vmMeans.mat')

%loop over real and eq
for s=1:2

    
if s==1
  
    
%loop over incremented activity on either side

    
 figure() 
 set(gcf, 'Color', 'w')
 subplot(2,1,1)
 
%Loop over differences in spike Num
for d=1:10
    

allVms=squeeze(vmMeans(1,d,:,:));
leftIncrementRealZeros(d)=sum(any(allVms==0));
allVms(:,any(allVms==0))=[];

meanLeft=mean(allVms(1:3,:));
meanRight=mean(allVms(4:5,:));

meanDiffL{d}=meanLeft-meanRight;


histogram(meanDiffL{d}(:), 46)
hold on



end

xlabel('Sum L PN Responses - Sum R PN Responses')
ylabel('Freq')
title('Real Contact Nums')
legend({'Equal Spikes', 'Plus 1 L Spike', 'Plus 2 L Spikes', 'Plus 3 L Spikes'}, 'Location', 'NorthWest')

else
    
   

    
subplot(2,1,2)
  
for d=1:10
     
    
allVms=squeeze(vmMeans_eq(1,d,:,:));
leftIncrementEqZeros(d)=sum(any(allVms==0));
allVms(:,any(allVms==0))=[];

meanLeft=mean(allVms(1:3,:));
meanRight=mean(allVms(4:5,:));


meanDiff_eq{d}=meanLeft-meanRight;

histogram(meanDiff_eq{d}(:), 46)

hold on


end

xlabel('Sum L PN Responses -Sum R PN Responses')
ylabel('Freq')
title('Equalized Contact Nums')
% legend({'Equal Spikes', 'Plus 1 L Spike', 'Plus 2 L Spikes', 'Plus 3 L Spikes'}, 'Location', 'NorthWest')

end
   



end


for c=0:9
    
    if c==0
        
        predictors=[meanDiffL{1}(1:2500),meanDiffL{1}(2501:5000)];
        categories=[ones(size(meanDiffL{1}(1:2500))),2*ones(size(meanDiffL{1}(2501:5000)))];
        
        testVals=[meanDiffL{1}(5001:7500),meanDiffL{1}(7501:end)];
        testCat=[ones(size(meanDiffL{1}(5001:7500))),2*ones(size(meanDiffL{1}(7501:end)))];
        
    elseif c==1
        
        predictors=[meanDiffL{1}(1:2500),meanDiffL{2}(1:2500)];
        categories=[ones(size(meanDiffL{1}(1:2500))),2*ones(size(meanDiffL{2}(1:2500)))];
        
        testVals=[meanDiffL{1}(2501:5000),meanDiffL{2}(2501:5000)];
        testCat=[ones(size(meanDiffL{1}(2501:5000))),2*ones(size(meanDiffL{2}(2501:5000)))];
        
    elseif c==2
        
        predictors=[meanDiffL{1}(1:2500),meanDiffL{3}(1:2500)];
        categories=[ones(size(meanDiffL{1}(1:2500))),2*ones(size(meanDiffL{3}(1:2500)))];
        
        testVals=[meanDiffL{1}(2501:5000),meanDiffL{3}(2501:5000)];
        testCat=[ones(size(meanDiffL{1}(2501:5000))),2*ones(size(meanDiffL{3}(2501:5000)))];
        
    elseif c==3
        
        predictors=[meanDiffL{1}(1:2500),meanDiffL{4}(1:2500)];
        categories=[ones(size(meanDiffL{1}(1:2500))),2*ones(size(meanDiffL{4}(1:2500)))];
        
        testVals=[meanDiffL{1}(2501:5000),meanDiffL{4}(2501:5000)];
        testCat=[ones(size(meanDiffL{1}(2501:5000))),2*ones(size(meanDiffL{4}(2501:5000)))];
        
    elseif c==4
        
        predictors=[meanDiffL{1}(1:2500),meanDiffL{5}(1:2500)];
        categories=[ones(size(meanDiffL{1}(1:2500))),2*ones(size(meanDiffL{5}(2501:5000)))];
        
        testVals=[meanDiffL{1}(2501:5000),meanDiffL{5}(2501:5000)];
        testCat=[ones(size(meanDiffL{1}(2501:5000))),2*ones(size(meanDiffL{5}(2501:5000)))];
        
    elseif c==5
        
        predictors=[meanDiffL{1}(1:2500),meanDiffL{6}(1:2500)];
        categories=[ones(size(meanDiffL{1}(1:2500))),2*ones(size(meanDiffL{6}(1:2500)))];
        
        testVals=[meanDiffL{1}(2501:5000),meanDiffL{6}(2501:5000)];
        testCat=[ones(size(meanDiffL{1}(2501:5000))),2*ones(size(meanDiffL{6}(2501:5000)))];
        
    elseif c==6
        
        predictors=[meanDiffL{1}(1:2500),meanDiffL{7}(1:2500)];
        categories=[ones(size(meanDiffL{1}(1:2500))),2*ones(size(meanDiffL{7}(1:2500)))];
        
        testVals=[meanDiffL{1}(2501:5000),meanDiffL{7}(2501:5000)];
        testCat=[ones(size(meanDiffL{1}(2501:5000))),2*ones(size(meanDiffL{7}(2501:5000)))];
        
    elseif c==7
        
        predictors=[meanDiffL{1}(1:2500),meanDiffL{8}(1:2500)];
        categories=[ones(size(meanDiffL{1}(1:2500))),2*ones(size(meanDiffL{8}(1:2500)))];
        
        testVals=[meanDiffL{1}(2501:5000),meanDiffL{8}(2501:5000)];
        testCat=[ones(size(meanDiffL{1}(2501:5000))),2*ones(size(meanDiffL{8}(2501:5000)))];
        
    elseif c==8
        
        predictors=[meanDiffL{1}(1:2500),meanDiffL{9}(1:2500)];
        categories=[ones(size(meanDiffL{1}(1:2500))),2*ones(size(meanDiffL{9}(1:2500)))];
        
        testVals=[meanDiffL{1}(2501:5000),meanDiffL{9}(2501:5000)];
        testCat=[ones(size(meanDiffL{1}(2501:5000))),2*ones(size(meanDiffL{9}(2501:5000)))];
        
    elseif c==9
        
        predictors=[meanDiffL{1}(1:2500),meanDiffL{10}(1:2500)];
        categories=[ones(size(meanDiffL{1}(1:2500))),2*ones(size(meanDiffL{10}(1:2500)))];
        
        testVals=[meanDiffL{1}(2501:5000),meanDiffL{10}(2501:5000)];
        testCat=[ones(size(meanDiffL{1}(2501:5000))),2*ones(size(meanDiffL{10}(2501:5000)))];
        
        
    end

% Train a discriminant object on of the sets of repetitions and test it
% on the other

cls = fitcdiscr(predictors',categories');
K=cls.Coeffs(1,2).Const;
L=cls.Coeffs(1,2).Linear;
thresh=-K/L;

%see how well it did on the training data

performance_realL(c+1,1)=(sum(categories(find(predictors<thresh))== 1)+...
sum(categories(find(predictors>thresh))== 2))/numel(categories)

%see how well it did on the test data
performance_realL(c+1,2)=(sum(testCat(find(testVals<thresh))== 1)+...
sum(testCat(find(testVals>thresh))== 2))/numel(testCat)

end



for c=0:9
    
    if c==0
        
        predictors=[meanDiff_eq{1}(1:2500),meanDiff_eq{1}(2501:5000)];
        categories=[ones(size(meanDiff_eq{1}(1:2500))),2*ones(size(meanDiff_eq{1}(2501:5000)))];
        
        testVals=[meanDiff_eq{1}(5001:7500),meanDiff_eq{1}(7501:end)];
        testCat=[ones(size(meanDiff_eq{1}(5001:7500))),2*ones(size(meanDiff_eq{1}(7501:end)))];
        
    elseif c==1
        
        predictors=[meanDiff_eq{1}(1:2500),meanDiff_eq{2}(1:2500)];
        categories=[ones(size(meanDiff_eq{1}(1:2500))),2*ones(size(meanDiff_eq{2}(1:2500)))];
        
        testVals=[meanDiff_eq{1}(2501:5000),meanDiff_eq{2}(2501:5000)];
        testCat=[ones(size(meanDiff_eq{1}(2501:5000))),2*ones(size(meanDiff_eq{2}(2501:5000)))];
        
    elseif c==2
        
        predictors=[meanDiff_eq{1}(1:2500),meanDiff_eq{3}(1:2500)];
        categories=[ones(size(meanDiff_eq{1}(1:2500))),2*ones(size(meanDiff_eq{3}(1:2500)))];
        
        testVals=[meanDiff_eq{1}(2501:5000),meanDiff_eq{3}(2501:5000)];
        testCat=[ones(size(meanDiff_eq{1}(2501:5000))),2*ones(size(meanDiff_eq{3}(2501:5000)))];
        
    elseif c==3
        
        predictors=[meanDiff_eq{1}(1:2500),meanDiff_eq{4}(1:2500)];
        categories=[ones(size(meanDiff_eq{1}(1:2500))),2*ones(size(meanDiff_eq{4}(1:2500)))];
        
        testVals=[meanDiff_eq{1}(2501:5000),meanDiff_eq{4}(2501:5000)];
        testCat=[ones(size(meanDiff_eq{1}(2501:5000))),2*ones(size(meanDiff_eq{4}(2501:5000)))];
        
    elseif c==4
        
        predictors=[meanDiff_eq{1}(1:2500),meanDiff_eq{5}(1:2500)];
        categories=[ones(size(meanDiff_eq{1}(1:2500))),2*ones(size(meanDiff_eq{5}(2501:5000)))];
        
        testVals=[meanDiff_eq{1}(2501:5000),meanDiff_eq{5}(2501:5000)];
        testCat=[ones(size(meanDiff_eq{1}(2501:5000))),2*ones(size(meanDiff_eq{5}(2501:5000)))];
        
    elseif c==5
        
        predictors=[meanDiff_eq{1}(1:2500),meanDiff_eq{6}(1:2500)];
        categories=[ones(size(meanDiff_eq{1}(1:2500))),2*ones(size(meanDiff_eq{6}(1:2500)))];
        
        testVals=[meanDiff_eq{1}(2501:5000),meanDiff_eq{6}(2501:5000)];
        testCat=[ones(size(meanDiff_eq{1}(2501:5000))),2*ones(size(meanDiff_eq{6}(2501:5000)))];
        
    elseif c==6
        
        
        
        predictors=[meanDiff_eq{1}(1:2500),meanDiff_eq{7}(1:2500)];
        categories=[ones(size(meanDiff_eq{1}(1:2500))),2*ones(size(meanDiff_eq{7}(1:2500)))];
        
        testVals=[meanDiff_eq{1}(2501:5000),meanDiff_eq{7}(2501:end)];
        testCat=[ones(size(meanDiff_eq{1}(2501:5000))),2*ones(size(meanDiff_eq{7}(2501:end)))];
        
    elseif c==7
        
        predictors=[meanDiff_eq{1}(1:2500),meanDiff_eq{8}(1:2500)];
        categories=[ones(size(meanDiff_eq{1}(1:2500))),2*ones(size(meanDiff_eq{8}(1:2500)))];
        
        testVals=[meanDiff_eq{1}(2501:5000),meanDiff_eq{8}(2501:5000)];
        testCat=[ones(size(meanDiff_eq{1}(2501:5000))),2*ones(size(meanDiff_eq{8}(2501:5000)))];
        
    elseif c==8
        
        predictors=[meanDiff_eq{1}(1:2500),meanDiff_eq{9}(1:2500)];
        categories=[ones(size(meanDiff_eq{1}(1:2500))),2*ones(size(meanDiff_eq{9}(1:2500)))];
        
        testVals=[meanDiff_eq{1}(2501:5000),meanDiff_eq{9}(2501:5000)];
        testCat=[ones(size(meanDiff_eq{1}(2501:5000))),2*ones(size(meanDiff_eq{9}(2501:5000)))];
        
    elseif c==9
        
        predictors=[meanDiff_eq{1}(1:2500),meanDiff_eq{10}(1:2500)];
        categories=[ones(size(meanDiff_eq{1}(1:2500))),2*ones(size(meanDiff_eq{10}(1:2500)))];
        
        testVals=[meanDiff_eq{1}(2501:5000),meanDiff_eq{10}(2501:5000)];
        testCat=[ones(size(meanDiff_eq{1}(2501:5000))),2*ones(size(meanDiff_eq{10}(2501:5000)))];
        
        
    end

% Train a discriminant object on of the sets of repetitions and test it
% on the other

cls = fitcdiscr(predictors',categories');
K=cls.Coeffs(1,2).Const;
L=cls.Coeffs(1,2).Linear;
thresh=-K/L;

%see how well it did on the training data

performance_eqL(c+1,1)=(sum(categories(find(predictors<thresh))== 1)+...
sum(categories(find(predictors>thresh))== 2))/numel(categories)

%see how well it did on the test data
performance_eqL(c+1,2)=(sum(testCat(find(testVals<thresh))== 1)+...
sum(testCat(find(testVals>thresh))== 2))/numel(testCat)

end


figure()
set(gcf, 'Color', 'w')

plot(performance_realL(:,2))
hold on
plot(performance_eqL(:,2))
ax=gca;
ax.XTick=[0:1:9];

xlabel('Num of additional spikes in L ORN pool')
ylabel('Lin Disc Classifier Performance')
legend({'real contact nums', 'Equalized Contact Nums'}, 'Location', 'SouthEast')
title('discriminability of difference histograms')

%% This segement of code plots histograms of mean differences for increments in R ORN spikes
% 
% load('vmMeans_eq.mat')
% load('vmMeans.mat')

%loop over real and eq
for s=1:2

    
if s==1
  
    
%loop over incremented activity on either side

    
 figure() 
 set(gcf, 'Color', 'w')
 subplot(2,1,1)
 
%Loop over differences in spike Num
for d=1:10
    

allVms=squeeze(vmMeans(2,d,:,:));
allVms(:,any(allVms==0))=[];

meanLeft=mean(allVms(1:3,:));
meanRight=mean(allVms(4:5,:));

meanDiffR{d}=meanRight-meanLeft;


histogram(meanDiffR{d}(:), 46)
hold on



end

xlabel('Mean R PN Response -Mean L PN Response')
ylabel('Freq')
title('Real Contact Nums')
legend({'Equal Spikes', 'Plus 1 R Spike', 'Plus 2 R Spikes', 'Plus 3 R Spikes'}, 'Location', 'NorthWest')

else
    
   

    
subplot(2,1,2)
  
for d=1:10
     
clear allVms    
allVms=squeeze(vmMeans_eq(2,d,:,:));
allVms(:,any(allVms==0))=[];

meanLeft=mean(allVms(1:3,:));
meanRight=mean(allVms(4:5,:));


meanDiff_eqR{d}=meanRight-meanLeft;

histogram(meanDiff_eqR{d}(:), 46)

hold on


end

xlabel('Mean R PN Response -Mean L PN Response')
ylabel('Freq')
title('Equalized Contact Nums')
% legend({'Equal Spikes', 'Plus 1 L Spike', 'Plus 2 L Spikes', 'Plus 3 L Spikes'}, 'Location', 'NorthWest')

end
   



end


for c=0:9
    
    if c==0
        
        predictors=[meanDiffR{1}(1:2500),meanDiffR{1}(2501:5000)];
        categories=[ones(size(meanDiffR{1}(1:2500))),2*ones(size(meanDiffR{1}(2501:5000)))];
        
        testVals=[meanDiffR{1}(5001:7500),meanDiffR{1}(7501:end)];
        testCat=[ones(size(meanDiffR{1}(5001:7500))),2*ones(size(meanDiffR{1}(7501:end)))];
        
    elseif c==1
        
        predictors=[meanDiffR{1}(1:2500),meanDiffR{2}(1:2500)];
        categories=[ones(size(meanDiffR{1}(1:2500))),2*ones(size(meanDiffR{2}(1:2500)))];
        
        testVals=[meanDiffR{1}(2501:5000),meanDiffR{2}(2501:5000)];
        testCat=[ones(size(meanDiffR{1}(2501:5000))),2*ones(size(meanDiffR{2}(2501:5000)))];
        
    elseif c==2
        
        predictors=[meanDiffR{1}(1:2500),meanDiffR{3}(1:2500)];
        categories=[ones(size(meanDiffR{1}(1:2500))),2*ones(size(meanDiffR{3}(1:2500)))];
        
        testVals=[meanDiffR{1}(2501:5000),meanDiffR{3}(2501:5000)];
        testCat=[ones(size(meanDiffR{1}(2501:5000))),2*ones(size(meanDiffR{3}(2501:5000)))];
        
    elseif c==3
        
        predictors=[meanDiffR{1}(1:2500),meanDiffR{4}(1:2500)];
        categories=[ones(size(meanDiffR{1}(1:2500))),2*ones(size(meanDiffR{4}(1:2500)))];
        
        testVals=[meanDiffR{1}(2501:5000),meanDiffR{4}(2501:5000)];
        testCat=[ones(size(meanDiffR{1}(2501:5000))),2*ones(size(meanDiffR{4}(2501:5000)))];
        
    elseif c==4
        
        predictors=[meanDiffR{1}(1:2500),meanDiffR{5}(1:2500)];
        categories=[ones(size(meanDiffR{1}(1:2500))),2*ones(size(meanDiffR{5}(2501:5000)))];
        
        testVals=[meanDiffR{1}(2501:5000),meanDiffR{5}(2501:5000)];
        testCat=[ones(size(meanDiffR{1}(2501:5000))),2*ones(size(meanDiffR{5}(2501:5000)))];
        
    elseif c==5
        
        predictors=[meanDiffR{1}(1:2500),meanDiffR{6}(1:2500)];
        categories=[ones(size(meanDiffR{1}(1:2500))),2*ones(size(meanDiffR{6}(1:2500)))];
        
        testVals=[meanDiffR{1}(2501:5000),meanDiffR{6}(2501:5000)];
        testCat=[ones(size(meanDiffR{1}(2501:5000))),2*ones(size(meanDiffR{6}(2501:5000)))];
        
    elseif c==6
        
        predictors=[meanDiffR{1}(1:2500),meanDiffR{7}(1:2500)];
        categories=[ones(size(meanDiffR{1}(1:2500))),2*ones(size(meanDiffR{7}(1:2500)))];
        
        testVals=[meanDiffR{1}(2501:5000),meanDiffR{7}(2501:5000)];
        testCat=[ones(size(meanDiffR{1}(2501:5000))),2*ones(size(meanDiffR{7}(2501:5000)))];
        
    elseif c==7
        
        predictors=[meanDiffR{1}(1:2500),meanDiffR{8}(1:2500)];
        categories=[ones(size(meanDiffR{1}(1:2500))),2*ones(size(meanDiffR{8}(1:2500)))];
        
        testVals=[meanDiffR{1}(2501:5000),meanDiffR{8}(2501:5000)];
        testCat=[ones(size(meanDiffR{1}(2501:5000))),2*ones(size(meanDiffR{8}(2501:5000)))];
        
    elseif c==8
        
        predictors=[meanDiffR{1}(1:2500),meanDiffR{9}(1:2500)];
        categories=[ones(size(meanDiffR{1}(1:2500))),2*ones(size(meanDiffR{9}(1:2500)))];
        
        testVals=[meanDiffR{1}(2501:5000),meanDiffR{9}(2501:5000)];
        testCat=[ones(size(meanDiffR{1}(2501:5000))),2*ones(size(meanDiffR{9}(2501:5000)))];
        
    elseif c==9
        
        predictors=[meanDiffR{1}(1:2500),meanDiffR{10}(1:2500)];
        categories=[ones(size(meanDiffR{1}(1:2500))),2*ones(size(meanDiffR{10}(1:2500)))];
        
        testVals=[meanDiffR{1}(2501:5000),meanDiffR{10}(2501:5000)];
        testCat=[ones(size(meanDiffR{1}(2501:5000))),2*ones(size(meanDiffR{10}(2501:5000)))];
        
        
    end

% Train a discriminant object on of the sets of repetitions and test it
% on the other

cls = fitcdiscr(predictors',categories');
K=cls.Coeffs(1,2).Const;
L=cls.Coeffs(1,2).Linear;
thresh=-K/L;

%see how well it did on the training data

performance_realR(c+1,1)=(sum(categories(find(predictors<thresh))== 1)+...
sum(categories(find(predictors>thresh))== 2))/numel(categories)

%see how well it did on the test data
performance_realR(c+1,2)=(sum(testCat(find(testVals<thresh))== 1)+...
sum(testCat(find(testVals>thresh))== 2))/numel(testCat)

end



for c=0:9
    
    if c==0
        
        predictors=[meanDiff_eqR{1}(1:2500),meanDiff_eqR{1}(2501:5000)];
        categories=[ones(size(meanDiff_eqR{1}(1:2500))),2*ones(size(meanDiff_eqR{1}(2501:5000)))];
        
        testVals=[meanDiff_eqR{1}(5001:7500),meanDiff_eqR{1}(7501:end)];
        testCat=[ones(size(meanDiff_eqR{1}(5001:7500))),2*ones(size(meanDiff_eqR{1}(7501:end)))];
        
    elseif c==1
        
        predictors=[meanDiff_eqR{1}(1:2500),meanDiff_eqR{2}(1:2500)];
        categories=[ones(size(meanDiff_eqR{1}(1:2500))),2*ones(size(meanDiff_eqR{2}(1:2500)))];
        
        testVals=[meanDiff_eqR{1}(2501:5000),meanDiff_eqR{2}(2501:5000)];
        testCat=[ones(size(meanDiff_eqR{1}(2501:5000))),2*ones(size(meanDiff_eqR{2}(2501:5000)))];
        
    elseif c==2
        
        predictors=[meanDiff_eqR{1}(1:2500),meanDiff_eqR{3}(1:2500)];
        categories=[ones(size(meanDiff_eqR{1}(1:2500))),2*ones(size(meanDiff_eqR{3}(1:2500)))];
        
        testVals=[meanDiff_eqR{1}(2501:5000),meanDiff_eqR{3}(2501:5000)];
        testCat=[ones(size(meanDiff_eqR{1}(2501:5000))),2*ones(size(meanDiff_eqR{3}(2501:5000)))];
        
    elseif c==3
        
        predictors=[meanDiff_eqR{1}(1:2500),meanDiff_eqR{4}(1:2500)];
        categories=[ones(size(meanDiff_eqR{1}(1:2500))),2*ones(size(meanDiff_eqR{4}(1:2500)))];
        
        testVals=[meanDiff_eqR{1}(2501:5000),meanDiff_eqR{4}(2501:5000)];
        testCat=[ones(size(meanDiff_eqR{1}(2501:5000))),2*ones(size(meanDiff_eqR{4}(2501:5000)))];
        
    elseif c==4
        
        predictors=[meanDiff_eqR{1}(1:2500),meanDiff_eqR{5}(1:2500)];
        categories=[ones(size(meanDiff_eqR{1}(1:2500))),2*ones(size(meanDiff_eqR{5}(2501:5000)))];
        
        testVals=[meanDiff_eqR{1}(2501:5000),meanDiff_eqR{5}(2501:5000)];
        testCat=[ones(size(meanDiff_eqR{1}(2501:5000))),2*ones(size(meanDiff_eqR{5}(2501:5000)))];
        
    elseif c==5
        
        predictors=[meanDiff_eqR{1}(1:2500),meanDiff_eqR{6}(1:2500)];
        categories=[ones(size(meanDiff_eqR{1}(1:2500))),2*ones(size(meanDiff_eqR{6}(1:2500)))];
        
        testVals=[meanDiff_eqR{1}(2501:5000),meanDiff_eqR{6}(2501:5000)];
        testCat=[ones(size(meanDiff_eqR{1}(2501:5000))),2*ones(size(meanDiff_eqR{6}(2501:5000)))];
        
    elseif c==6
        
        
        
        predictors=[meanDiff_eqR{1}(1:2500),meanDiff_eqR{7}(1:2500)];
        categories=[ones(size(meanDiff_eqR{1}(1:2500))),2*ones(size(meanDiff_eqR{7}(1:2500)))];
        
        testVals=[meanDiff_eqR{1}(2501:5000),meanDiff_eqR{7}(2501:end)];
        testCat=[ones(size(meanDiff_eqR{1}(2501:5000))),2*ones(size(meanDiff_eqR{7}(2501:end)))];
        
    elseif c==7
        
        predictors=[meanDiff_eqR{1}(1:2500),meanDiff_eqR{8}(1:2500)];
        categories=[ones(size(meanDiff_eqR{1}(1:2500))),2*ones(size(meanDiff_eqR{8}(1:2500)))];
        
        testVals=[meanDiff_eqR{1}(2501:5000),meanDiff_eqR{8}(2501:5000)];
        testCat=[ones(size(meanDiff_eqR{1}(2501:5000))),2*ones(size(meanDiff_eqR{8}(2501:5000)))];
        
    elseif c==8
        
        predictors=[meanDiff_eqR{1}(1:2500),meanDiff_eqR{9}(1:2500)];
        categories=[ones(size(meanDiff_eqR{1}(1:2500))),2*ones(size(meanDiff_eqR{9}(1:2500)))];
        
        testVals=[meanDiff_eqR{1}(2501:5000),meanDiff_eqR{9}(2501:5000)];
        testCat=[ones(size(meanDiff_eqR{1}(2501:5000))),2*ones(size(meanDiff_eqR{9}(2501:5000)))];
        
    elseif c==9
        
        predictors=[meanDiff_eqR{1}(1:2500),meanDiff_eqR{10}(1:2500)];
        categories=[ones(size(meanDiff_eqR{1}(1:2500))),2*ones(size(meanDiff_eqR{10}(1:2500)))];
        
        testVals=[meanDiff_eqR{1}(2501:5000),meanDiff_eqR{10}(2501:5000)];
        testCat=[ones(size(meanDiff_eqR{1}(2501:5000))),2*ones(size(meanDiff_eqR{10}(2501:5000)))];
        
        
    end

% Train a discriminant object on of the sets of repetitions and test it
% on the other

cls = fitcdiscr(predictors',categories');
K=cls.Coeffs(1,2).Const;
L=cls.Coeffs(1,2).Linear;
thresh=-K/L;

%see how well it did on the training data

performance_eqR(c+1,1)=(sum(categories(find(predictors<thresh))== 1)+...
sum(categories(find(predictors>thresh))== 2))/numel(categories)

%see how well it did on the test data
performance_eqR(c+1,2)=(sum(testCat(find(testVals<thresh))== 1)+...
sum(testCat(find(testVals>thresh))== 2))/numel(testCat)

end
figure()
set(gcf, 'Color', 'w')

plot(performance_realR(:,2))
hold on
plot(performance_eqR(:,2))
ax=gca;
ax.XTick=[0:1:9];

xlabel('Num of additional spikes in R ORN pool')
ylabel('Lin Disc Classifier Performance')
legend({'real contact nums', 'Equalized Contact Nums'}, 'Location', 'Northwest')
title('discriminability of difference histograms')



%% Plotting


figure()
set(gcf, 'Color', 'w')

plot([performance_realL(:,2),performance_realR(:,2)] ,'b')
hold on
plot([performance_eqL(:,2),performance_eqR(:,2)] ,'r')

ax=gca;
ax.XTick=[0:1:9]
xlabel('Spike Difference')
ylabel('Performance')
legend({'Real Contact Numbers', 'Equalized Contact Numbers'}, 'Location', 'SouthEast')

saveas(gcf,'lateralizationPerformance','epsc')
saveas(gcf,'lateralizationPerformance')
