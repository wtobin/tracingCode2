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

%% Histogram option

figure()
set(gcf, 'Color', 'w')
histogram(pooledMiniAmps, 'FaceColor','k')
% xlim([-.1 2.5])
ax = gca;
ax.FontSize=16;
ylabel('Frequency')
xlabel('Normalized Mean mEPSP Amplitude')
axis square

