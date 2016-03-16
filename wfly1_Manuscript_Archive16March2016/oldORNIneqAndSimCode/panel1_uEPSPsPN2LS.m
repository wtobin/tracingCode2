% This code relies on the products of uEPSP_AmpWorking which should be found in Fig 2 dir

% Plot all ORN uEPSPs overlaid for one PN

figure()

%Plot all uEPSPs for PN2LS against time (40samples/ms)

plot([0:1/40:85],[leftUEPSPs{2}(:,1:3401)',rightUEPSPs{2}(:,1:3401)'], 'b')
ylabel('Vm (mV)', 'FontSize', 18)
xlabel('Time (ms)', 'FontSize',18)
ax=gca;
ax.FontSize=16;
xlim([0 85])
set(gcf, 'Color', 'w')
title('All ORN to PN2 LS uEPSPs','Fontsize', 20)



