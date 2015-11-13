%% Panel 4 scatterplot mean ipsi v contra ORN uEPSPs

% This code relies on the products of uEPSP_AmpWorking which should be found in Fig 2 dir
% It also relies on the matricies produced by the Figure 5 panel3 code



figure()
set(gcf, 'Color', 'w')

scatter(mean(sorted_uEPSPAmps(1:length(ORNs_Left),[1,2,3])'),...
mean(sorted_uEPSPAmps(1:length(ORNs_Left),[4:5])'), 'Filled')

hold on

scatter(mean(sorted_uEPSPAmps(length(ORNs_Left)+1:end,[4:5])'),...
mean(sorted_uEPSPAmps(length(ORNs_Left)+1:end,[1,2,3])'), 'r', 'Filled')

ax=gca;
ax.XLim=[.35 2];
ax.YLim=[.35 2];

xlabel('Ipsilateral PNs', 'FontSize',18)
ylabel('Contralateral PNs', 'FontSize',18)
title('Mean normalized ORN-->PN uEPSPs','Fontsize', 20)
legend({'Left ORNs','Right ORNs'}, 'FontSize',16)


