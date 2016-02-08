
%% Normalized Synapses per unitary

%load orn to PN connectivity matrix

load('~/Documents/MATLAB/tracingCode2/wfly1_Manuscript/ornToPn.mat')

%normalize each column by its mean

for c=1:5
    
normOrnToPn(:,c)=ornToPn(:,c)./mean(ornToPn(:,c))

end

%pool these values and exclude zeros
pooledNormOrnToP=normOrnToPn(:);
pooledNormOrnToP(pooledNormOrnToP==0)=[];

% %% histogram option
% 
% figure()
% set(gcf, 'Color', 'w')
% histogram(pooledNormOrnToP, 'FaceColor','k')
% xlim([-.1 2.5])
% ax = gca;
% ax.FontSize=16;
% ylabel('Frequency')
% xlabel('Normalized Synapses per ORN-->PN Unitary')
% axis square


%% Normalized mean Mini Amplitude

%This code relies on the mEPSP matricies produced by mEPSP_AmpWorking_wcl
%in the Figure 3 directory

% loop over PNs
for p=1:5
   
    %loop over the L ORNs that each PN recieves input from
    leftInputs=unique(leftMEPSPs_idList{p});
    
    for o=1:length(leftInputs)
        meanLMiniAmp(o,p)=mean(max(leftMEPSPs{p}(find(leftMEPSPs_idList{p}==leftInputs(o)),:)')+60);
    end
    
       %loop over the L ORNs that each PN recieves input from
    rightInputs=unique(rightMEPSPs_idList{p});
    
    for o=1:length(rightInputs)
        meanRMiniAmp(o,p)=mean(max(rightMEPSPs{p}(find(rightMEPSPs_idList{p}==rightInputs(o)),:)')+60);
    end
    
    
    
end

%exclude 0s
meanLMiniAmp(meanLMiniAmp==0)=nan;
meanRMiniAmp(meanRMiniAmp==0)=nan;

%Normalize these values to the PN mean

for i=1:5
    
normMeanMinisL(:,i)=meanLMiniAmp(:,i)./nanmean(meanLMiniAmp(:,i));
normMeanMinisR(:,i)=meanRMiniAmp(:,i)./nanmean(meanRMiniAmp(:,i));

end

%pool these values 
pooledMiniAmps=[normMeanMinisL(:);normMeanMinisR(:)];

%% normalized Summation efficacy

for p=1:5
    
    normSumEff(:,p)=sumEff{p}./mean(sumEff{p});
    
end


%% Strip chart 

   figure
   set(gcf, 'Color', 'w')


for z = 1:3
    
    if z==1
        
        jitterAmount = 0.1;
        jitterValuesX = 2*(rand(1,length(pooledNormOrnToP))-0.5)*jitterAmount;   % +/-jitterAmount max
        scatter(ones(1,length(pooledNormOrnToP))+jitterValuesX,pooledNormOrnToP, 17,'k')
        hold on
        
    elseif z==2
        
        jitterAmount = 0.1;
        jitterValuesX = 2*(rand(1,length(pooledMiniAmps))-0.5)*jitterAmount; 
        scatter(2*ones(1,length(pooledMiniAmps))+jitterValuesX,pooledMiniAmps,17, 'k')
        hold on
        
    else
        
        jitterAmount = 0.1;
        jitterValuesX = 2*(rand(1,length(normSumEff(:)))-0.5)*jitterAmount;  
        scatter(3*ones(1,length(normSumEff(:)))+jitterValuesX,normSumEff(:),17, 'k')
        hold on
        
    end
 
    
  
    
end


ax=gca;
ax.XTick=[1:1:3]
% xlim([.5 1.5])
labels={'Synapses','mEPSP Amplitude', 'Summation Efficacy'}
ax.XTickLabel=labels;

ylabel('Normalized Value per ORN-->PN Unitary')
saveas(gcf,'stripChart_normVals','epsc')

%% Histograms


figure()
set(gcf, 'Color', 'w')
h1=histogram(pooledNormOrnToP,12, 'FaceColor','k', 'Normalization', 'pdf');
xlim([min(h1.BinEdges)-.05 max(h1.BinEdges)+.05])
ax = gca;
ax.FontSize=16;
ylabel('Frequency')
xlabel('Synapses')
axis square
saveas(gcf,'synapses_v2','epsc')

figure()
set(gcf, 'Color', 'w')
h2=histogram(pooledMiniAmps, 12, 'FaceColor','k', 'Normalization', 'pdf');
% xlim([min(h2.BinEdges)-.05 max(h2.BinEdges)+.05])
xlim([.05 2.31])
ax = gca;
ax.FontSize=16;
ylabel('Frequency')
xlabel('Mean mEPSP Amplitude')
axis square
saveas(gcf,'meanMini_v2','epsc')

figure()
set(gcf, 'Color', 'w')
h3=histogram(normSumEff(:), 12, 'FaceColor','k', 'Normalization', 'pdf');
% xlim([min(h3.BinEdges)-.05 max(h3.BinEdges)+.05]);
xlim([.05 2.31])
ax = gca;
ax.FontSize=16;
ylabel('Frequency')
xlabel('Summation Efficacy')
axis square
saveas(gcf,'summationEfficacy_v2','epsc')


