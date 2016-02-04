

% This code relies on the products of uEPSP_AmpWorking which should be found in Fig 2 dir

% Collect the amplitude of ipsi and contra MEPSPs for R and L ORN-->PN
% pairs


    

        
    %loop over PNs
    for p=1:5
        
        if p<=3
            
            counter=1;
            for s=1:size(leftMEPSPs{p},1)
                
            indAmpsI{p}(counter)=max(leftMEPSPs{p}(s,:))-mean(leftMEPSPs{p}(s,1:40));
            counter=counter+1;
            
            end
            
            counter=1;
            for s=1:size(rightMEPSPs{p},1)
                
                indAmpsC{p}(counter)=max(rightMEPSPs{p}(s,:))-mean(rightMEPSPs{p}(s,1:40));
                counter=counter+1;
                
            end
            
            
            
            else
                
                
            counter=1;
            for s=1:size(leftMEPSPs{p},1)
                
            indAmpsC{p}(counter)=max(leftMEPSPs{p}(s,:))-mean(leftMEPSPs{p}(s,1:40));
            counter=counter+1;
            
            end
            
            counter=1;
            for s=1:size(rightMEPSPs{p},1)
                
                indAmpsI{p}(counter)=max(rightMEPSPs{p}(s,:))-mean(rightMEPSPs{p}(s,1:40));
                counter=counter+1;
                
            end
            
            
    
        end
        
        miniMeans(p,1)=mean(indAmpsI{p});
        miniMeans(p,2)=mean(indAmpsC{p});
        
        sem(p,1)=std(indAmpsI{p})/sqrt(length(indAmpsI{p}))
        sem(p,2)=std(indAmpsC{p})/sqrt(length(indAmpsC{p}))
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

scatter(miniMeans(1:3,1),miniMeans(1:3,2), 'b', 'filled')

hold on

scatter(miniMeans(4:5,1),miniMeans(4:5,2), 'r', 'filled')

for i=1:5
   
    line([miniMeans(i,1)-sem(i,1) miniMeans(i,1)+sem(i,1)], [miniMeans(i,2) miniMeans(i,2)], 'Color', 'k', 'LineWidth',2)
    line([miniMeans(i,1) miniMeans(i,1)], [miniMeans(i,2)-sem(i,2) miniMeans(i,2)+sem(i,2)], 'Color', 'k', 'LineWidth',2)
    
end

set(gcf, 'Color', 'w')
ax=gca;
% ax.XTick=[0:10:110];
% ax.YTick=[0:10:110];
xlim([.15 .4]);
ylim([.15 .4]);
ax.FontSize=16;
refline(1,0)
xlabel('Mean Ipsi ORN mEPSP Amp', 'FontSize', 16);
ylabel('Mean Contra ORN mEPSP Amp', 'FontSize', 16);
legend({'Left PNs','Right PNs'}, 'Location','NorthWest')
% 
% figure()
% 
% %Scatter plot of mean uEPSP amp from ipsi ORNs vs. mean from contra
% %ORNs no normalization
% 
% scatter(mean(mEPSP_Amps(1:25,1:3)),mean(mEPSP_Amps(26:end,1:3)), 'filled')
% 
% hold on
% 
% scatter(mean(mEPSP_Amps(26:end,4:5)),mean(mEPSP_Amps(1:25,4:5)), 'filled','r')
% 
% set(gcf, 'Color', 'w')
% ax=gca;
% % ax.XTick=[0:10:110];
% % ax.YTick=[0:10:110];
% xlim([4 8]);
% ylim([4 8]);
% ax.FontSize=16;
% refline(1,0)
% xlabel('Mean Ipsi ORN uEPSP Amp (mV)', 'FontSize', 16);
% ylabel('Mean Contra ORN uEPSP Amp (mV)', 'FontSize', 16);
% legend({'Left PNs','Right PNs'}, 'Location','NorthWest')
% 
% 
% 
% figure()
% 
% for p=1:5
%     
%     if p<=3
%         scatter(p*ones(1,25), mEPSP_Amps(1:25,p),'b')
%         hold on
%         scatter(p*ones(1,25),mEPSP_Amps(26:end,p),'r')
%     else
%         scatter(p*ones(1,25), mEPSP_Amps(26:end,p),'b')
%         hold on
%         scatter(p*ones(1,25),mEPSP_Amps(1:25,p),'r')
%     end
%     
% end
%         
%         
