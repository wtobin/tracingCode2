%% Panel 2 scatterplot mean ipsi v contra input #

% This code relies on the products of uEPSP_AmpWorking which should be found in Fig 2 dir
% It also relies on the matricies produced by the Figure 5 panel1 code

% B.	scatterplot of mean ipsilateral percentage versus mean contralateral
% percentage (one data point per ORN) to show the lack of correlation
% (test for correlation by computing Pearson?s R and comparing to critical values)

figure()
set(gcf, 'Color', 'w')

scatter(mean(contactNum_Fract(1:length(ORNs_Left),[1,2,3])'),...
mean(contactNum_Fract(1:length(ORNs_Left),[4,5])'), 'Filled')

hold on

scatter(mean(contactNum_Fract(length(ORNs_Left)+1:end,[4,5])'),...
mean(contactNum_Fract(length(ORNs_Left)+1:end,[1,2,3])'), 'r', 'Filled')

ax=gca;
ax.XLim=[0 .04];
ax.YLim=[0 .04];

xlabel('Ipsilateral', 'FontSize',18)
ylabel('Contralateral', 'FontSize',18)
title('Mean Fractional ORN Input to PNs  ','Fontsize', 20)
legend({'Left ORNs','Right ORNs'}, 'FontSize',16)



