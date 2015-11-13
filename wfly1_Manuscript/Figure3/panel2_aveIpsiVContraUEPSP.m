

% This code relies on the products of uEPSP_AmpWorking which should be found in Fig 2 dir

% Collect the amplitude of ipsi and contra uEPSPs for R and L ORN-->PN
% pairs

% Loop over ORNs
for o=1:length(ORNs)
    
     %For the L ORNs
    if o <= length(ORNs_Left)
        
    %loop over PNs
    for p=1:5
    
       uEPSP_Amps(o,p)=max(leftUEPSPs{p}(o,:))-mean(leftUEPSPs{p}(o,1:100));
        
    end
        %For the R ORNs
    else
            
        %Loop over PNs
        
        for p=1:5
    
       uEPSP_Amps(o,p)=max(rightUEPSPs{p}(o-length(ORNs_Left),:))-mean(rightUEPSPs{p}(o-length(ORNs_Left),1:100));
        
        end
    
    end
end
% 
% figure()
% 
% scatter(mean(ipL_uEPSP'),conL_uEPSP)
% hold on
% scatter(ipR_uEPSP, mean(conR_uEPSP'), 'r')
% set(gcf, 'Color', 'w')
% ax=gca;
% % ax.XTick=[0:10:110];
% % ax.YTick=[0:10:110];
% % xlim([0 110]);
% % ylim([0 110]);
% ax.FontSize=16;
% refline(1,0)
% xlabel('ipsi ORN--PN uEPSP Amp (mV)', 'FontSize', 16);
% ylabel('contra ORN--PN uEPSP Amp (mV)', 'FontSize', 16);

%Plotting
figure()

%Scatter plot of mean uEPSP amp from ipsi ORNs vs. mean from contra
%ORNsnormalized to the max uEPSP in each PN

scatter(mean(uEPSP_Amps(1:25,1:3))./max(uEPSP_Amps(:,1:3)),mean(uEPSP_Amps(26:end,1:3))./max(uEPSP_Amps(:,1:3)), 'filled')

hold on

scatter(mean(uEPSP_Amps(26:end,4:5))./max(uEPSP_Amps(:,4:5)),mean(uEPSP_Amps(1:25,4:5))./max(uEPSP_Amps(:,4:5)), 'filled','r')

set(gcf, 'Color', 'w')
ax=gca;
% ax.XTick=[0:10:110];
% ax.YTick=[0:10:110];
xlim([0 1]);
ylim([0 1]);
ax.FontSize=16;
refline(1,0)
xlabel('Mean Ipsi ORN uEPSP Amp / Max uEPSP Amp ', 'FontSize', 16);
ylabel('Mean Contra ORN uEPSP Amp / Max uEPSP Amp', 'FontSize', 16);
legend({'Left PNs','Right PNs'}, 'Location','NorthWest')

figure()

%Scatter plot of mean uEPSP amp from ipsi ORNs vs. mean from contra
%ORNs no normalization

scatter(mean(uEPSP_Amps(1:25,1:3)),mean(uEPSP_Amps(26:end,1:3)), 'filled')

hold on

scatter(mean(uEPSP_Amps(26:end,4)),mean(uEPSP_Amps(1:25,4)), 'filled','r')

set(gcf, 'Color', 'w')
ax=gca;
% ax.XTick=[0:10:110];
% ax.YTick=[0:10:110];
xlim([5 10]);
ylim([5 10]);
ax.FontSize=16;
refline(1,0)
xlabel('Mean Ipsi ORN uEPSP Amp (mV)', 'FontSize', 16);
ylabel('Mean Contra ORN uEPSP Amp (mV)', 'FontSize', 16);
legend({'Left PNs','Right PNs'}, 'Location','NorthWest')



figure()

for p=1:5
    
    if p<=3
        scatter(p*ones(1,25), uEPSP_Amps(1:25,p),'b')
        hold on
        scatter(p*ones(1,25),uEPSP_Amps(26:end,p),'r')
    else
        scatter(p*ones(1,25), uEPSP_Amps(26:end,p),'b')
        hold on
        scatter(p*ones(1,25),uEPSP_Amps(1:25,p),'r')
    end
    
end
        
        
