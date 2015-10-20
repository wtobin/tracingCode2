
% Collect the amplitude of ipsilateral uEPSPs for R and L PNs

ilAmps=[];

for i=1:3 %length(PNs)
    
    for j=1:size(leftUEPSPs{i},1)
        
   ilAmps=[ilAmps,max(leftUEPSPs{i}(j,:))-mean(leftUEPSPs{i}(j,1:100))];
    end
end

irAmps=[];

for i=4 %length(PNs)
    
    for j=1:size(rightUEPSPs{i},1)
        
   irAmps=[irAmps,max(rightUEPSPs{i}(j,:))-mean(rightUEPSPs{i}(j,1:100))];
   
    end
    
end

%% Plotting


figure()
bar([mean(ilAmps); mean(irAmps)], 'k')
hold on
errorbar([mean(ilAmps); mean(irAmps)],[mean(ilAmps)/sqrt(numel(ilAmps)); mean(irAmps)/sqrt(numel(irAmps))],'r.')
set(gcf, 'Color', 'w')
ax=gca;
xlim([0 3]);
ax.XTick=[1:2];
ax.XTickLabel={'Left ORNs', 'Right ORNs'};
ax.FontSize=16;
ylabel('uEPSP Amp (mV)', 'FontSize', 16);
title('Mean ipsi ORN-->PN uEPSP Amp', 'FontSize', 18)



