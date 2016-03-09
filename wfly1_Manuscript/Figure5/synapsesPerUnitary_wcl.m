
%% Normalized Synapses per unitary

%load orn to PN connectivity matrix


%load orn to PN connectivity matrix

load('~/Documents/MATLAB/tracingCode2/wfly1_Manuscript/ornToPn.mat')

ipsiConsL(1:27,1:3)=ornToPn(1:27,[1,2,5]);
ipsiConsR(1:26,1:2)=ornToPn(28:end,[3,4]);
normIpsiConsL=bsxfun(@rdivide, ipsiConsL,sum(ipsiConsL));
normIpsiConsR=bsxfun(@rdivide, ipsiConsR,sum(ipsiConsR));



%pool these values and exclude zeros
pooledNormIpsiOrnToP=[normIpsiConsL(:);normIpsiConsR(:)];


% %% histogram option

figure()
set(gcf, 'Color', 'w')
histogram(pooledNormIpsiOrnToP, 'FaceColor','k')
xlim([0 1.])
ax = gca;
ax.FontSize=16;
ylabel('Frequency')
xlabel('Normalized Synapses per ORN-->PN Unitary')
axis square


%% Normalized mean Mini Amplitude

%This code relies on the mEPSP matricies produced by mEPSP_AmpWorking_wcl
%in the Figure 3 directory

% loop over PNs
for p=1:5
   
    if p<=3
    %loop over the L ORNs that each PN recieves input from
    leftInputs=ORNs_Left;
    
    for o=1:length(leftInputs)
        meanLMiniAmp(o,p)=mean(max(leftMEPSPs{p}(find(leftMEPSPs_idList{p}==leftInputs(o)),:)')+60);
    end
    
    
    else
       %loop over the L ORNs that each PN recieves input from
    rightInputs=ORNs_Right;
    
    for o=1:length(rightInputs)
        meanRMiniAmp(o,p)=mean(max(rightMEPSPs{p}(find(rightMEPSPs_idList{p}==rightInputs(o)),:)')+60);
    end
    
    end
    
end



%Normalize these values to the PN mean
normIpsiMiniL=bsxfun(@rdivide, meanLMiniAmp,mean(meanLMiniAmp));
normIpsiMiniR=bsxfun(@rdivide, meanRMiniAmp,mean(meanRMiniAmp));



%pool these values and exclude zeros
pooledNormIpsiMini=[normIpsiMiniL(:);normIpsiMiniR(:)];


%% normalized Summation efficacy

ipsiSumEffL=[sumEff{1}(1:27)',sumEff{2}(1:27)',sumEff{3}(1:27)'];
ipsiSumEffR=[sumEff{4}(28:end)',sumEff{5}(28:end)'];


%Normalize these values to the PN mean
normIpsiSumEffL=bsxfun(@rdivide, ipsiSumEffL,mean(ipsiSumEffL));
normIpsiSumEffR=bsxfun(@rdivide, ipsiSumEffR,mean(ipsiSumEffR));

%Pool the normalized results

pooledNormIpsiSumEff=[normIpsiSumEffL(:);normIpsiSumEffR(:)];

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
ax1 = subplot(3,1,1)
% set(gcf, 'Color', 'w')
h1=histogram(pooledNormIpsiOrnToP,12, 'FaceColor','k','Normalization','Probability');
xlim([min(h1.BinEdges)-.05 max(h1.BinEdges)+.05])
ax = gca;
ax.FontSize=16;
ylabel('Probability')
xlabel('Synapses (normalized)')
% axis square
% saveas(gcf,'synapses','epsc')

% figure()
ax2 = subplot(3,1,2)
% set(gcf, 'Color', 'w')
h2=histogram(pooledMiniAmps, 12, 'FaceColor','k','Normalization','Probability');
xlim([min(h2.BinEdges)-.05 max(h2.BinEdges)+.05])
ax = gca;
ax.FontSize=16;
ylabel('Probability')
xlabel('mEPSP Amplitude (normalized)')
% axis square
% saveas(gcf,'meanMini','epsc')

% figure()
ax3 = subplot(3,1,3)
% set(gcf, 'Color', 'w')
h3=histogram(normSumEff(:), 12, 'FaceColor','k','Normalization','Probability');
xlim([min(h3.BinEdges)-.05 max(h3.BinEdges)+.05]);
ax = gca;
ax.FontSize=16;
ylabel('Probability')
xlabel('Summation Efficacy (normalized)')
% axis square
% saveas(gcf,'summationEfficacy','epsc')

linkaxes([ax1,ax2,ax3],'x');
xlim([-0.5 2.5])


%% standardizing 

% synapses
zScore_OrnToPn=[];
for c=1:5
    
zScore_OrnToPn(:,c)=zscore(ornToPn(:,c));

end
zScore_syns = zScore_OrnToPn(:);

% mini Amp
zScore_MinisL=[];
zScore_MinisR=[];
for i=1:5
    
zScore_MinisL(:,i)=zscore(meanLMiniAmp(:,i));
zScore_MinisR(:,i)=zscore(meanRMiniAmp(:,i));

end
zScore_MiniAmps=[zScore_MinisL(:);zScore_MinisR(:)];


% Summation efficacy
zScore_SumEff=[];
for p=1:5
    
    zScore_SumEff(:,p)=zscore(sumEff{p});
    
end


%% z-score Histograms

figure()
ax1 = subplot(3,1,1)
% set(gcf, 'Color', 'w')
h1=histogram(zScore_syns,12, 'FaceColor','k','Normalization','Probability');
xlim([min(h1.BinEdges)-.05 max(h1.BinEdges)+.05])
ax = gca;
ax.FontSize=16;
ylabel('Probability')
xlabel('Synapses (z-score)')
% axis square
% saveas(gcf,'synapses','epsc')

% figure()
ax2 = subplot(3,1,2)
% set(gcf, 'Color', 'w')
h2=histogram(zScore_MiniAmps, 12, 'FaceColor','k','Normalization','Probability');
xlim([min(h2.BinEdges)-.05 max(h2.BinEdges)+.05])
ax = gca;
ax.FontSize=16;
ylabel('Probability')
xlabel('mEPSP Amplitude (z-score)')
% axis square
% saveas(gcf,'meanMini','epsc')

% figure()
ax3 = subplot(3,1,3)
% set(gcf, 'Color', 'w')
h3=histogram(zScore_SumEff(:), 12, 'FaceColor','k','Normalization','Probability');
xlim([min(h3.BinEdges)-.05 max(h3.BinEdges)+.05]);
ax = gca;
ax.FontSize=16;
ylabel('Probability')
xlabel('Summation Efficacy (z-score)')
% axis square
% saveas(gcf,'summationEfficacy','epsc')

linkaxes([ax1,ax2,ax3],'x');
xlim([-4 4])


%% Mean Normalized histograms


figure()
ax1 = subplot(1,3,1)
set(gcf, 'Color', 'w')
h1=histogram(pooledNormIpsiOrnToP,10, 'FaceColor','k','Normalization','Probability');
xlim([min(h1.BinEdges)-.05 max(h1.BinEdges)+.05])
ax = gca;
ax.FontSize=16;
ylabel('Probability')
xlabel('Synapse Number')
axis square
% saveas(gcf,'synapses','epsc')

% figure()
ax2 = subplot(1,3,2)
% set(gcf, 'Color', 'w')
h2=histogram(pooledNormIpsiMini, 10, 'FaceColor','k','Normalization','Probability');
xlim([min(h2.BinEdges)-.05 max(h2.BinEdges)+.05])
ax = gca;
ax.FontSize=16;
ylabel('Probability')
xlabel('Mean mEPSP Amplitude')
axis square
% saveas(gcf,'meanMini','epsc')

% figure()
ax3 = subplot(1,3,3)
% set(gcf, 'Color', 'w')
h3=histogram(pooledNormIpsiSumEff, 10, 'FaceColor','k','Normalization','Probability');
xlim([min(h3.BinEdges)-.05 max(h3.BinEdges)+.05]);
ax = gca;
ax.FontSize=16;
ylabel('Probability')
xlabel('Summation Efficacy')
axis square
% saveas(gcf,'summationEfficacy','epsc')

linkaxes([ax1,ax2,ax3],'x');
xlim([-.5 2.5])
ylim([0 .25])
