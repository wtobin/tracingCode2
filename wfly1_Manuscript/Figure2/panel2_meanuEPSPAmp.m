% This code relies on the products of uEPSP_AmpWorking which should be found in the same dir

% Collect the amplitude of ipsilateral uEPSPs for R and L PNs

ilAmps=[];

for i=1:3 %length(PNs)
    
    for j=1:size(leftUEPSPs{i},1)
        
   ilAmps=[ilAmps,max(leftUEPSPs{i}(j,:))-mean(leftUEPSPs{i}(j,1:100))];
    end
end

irAmps=[];

for i=4:5 %length(PNs)
    
    for j=1:size(rightUEPSPs{i},1)
        
   irAmps=[irAmps,max(rightUEPSPs{i}(j,:))-mean(rightUEPSPs{i}(j,1:100))];
   
    end
    
end

% Collect the num of contacts per unitary ipsiORN syn for R and L PNs

ilNum=[];

for i=1:3 %over each left PN
    
   ilNum=[ilNum,leftContactNum{i}];
    
end

irNum=[];

for i=4:5 %over each right PN
    
   irNum=[irNum,rightContactNum{i}];
    
end



%% Plotting


figure()


subplot(2,1,1)

bar([mean(ilNum); mean(irNum)], 'k')
hold on
errorbar([mean(ilNum); mean(irNum)],[mean(ilNum)/sqrt(numel(ilNum)); mean(irNum)/sqrt(numel(irNum))],'r.')
set(gcf, 'Color', 'w')
ax=gca;
xlim([0 3]);
ax.XTick=[1:2];
ax.XTickLabel={'Left ORNs', 'Right ORNs'};
ax.FontSize=16;
ylabel('Contact Num', 'FontSize', 16);
title('ipsi ORN-->PN contacts per unitary', 'FontSize', 18)

subplot(2,1,2)
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


figure()
subplot(2,1,1)
scatter(ones(1,length(ilAmps)),ilAmps)
hold on
scatter(2*ones(1,length(irAmps)), irAmps)

set(gcf, 'Color', 'w')
ax=gca;
xlim([0 3]);
ax.XTick=[1:2];
ax.XTickLabel={'Left ORNs', 'Right ORNs'};
ax.FontSize=16;
ylabel('uEPSP Amp (mV)', 'FontSize', 16);
title('ipsi ORN-->PN uEPSP Amps', 'FontSize', 18)

subplot(2,1,2)
scatter(ones(1,length(ilNum)),ilNum)
hold on
scatter(2*ones(1,length(irNum)), irNum)

set(gcf, 'Color', 'w')
ax=gca;
xlim([0 3]);
ax.XTick=[1:2];
ax.XTickLabel={'Left ORNs', 'Right ORNs'};
ax.FontSize=16;
ylabel('Contact Num', 'FontSize', 16);
title('ipsi ORN-->PN contacts per unitary', 'FontSize', 18)



