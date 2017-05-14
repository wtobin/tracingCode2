%The purpose of this code is to generate a connected scatterplot of mean
%mEPSP amplitudes for ipsi and Contra ORN inputs to each PN

% This code relies on the products of pullmEPSPs

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
  

%% Plotting


figure()
set(gcf,'Color','w')

rightCounter=1;

for p=1:5
        
        scatter([1 2],[miniMeans(p,1) miniMeans(p,2)],...
            54,'Filled','k')
        
          line([1 2 ], [miniMeans(p,1) miniMeans(p,2)]...
            ,'Color', 'k', 'LineWidth',1)
        
        hold on
    
end

xlim([0.5 2.5])
ylim([.1 .4])

ax=gca;
ax.XTick=[1,2];
ax.XTickLabel={'Ipsi','Contra'};
ax.YTick=[.1:.1:4];
ax.FontSize=16;
ax.TickDir='out';
ax.LineWidth=1;
pbaspect([1 1.65 1])

ylabel('mean mEPSP Amplitude (mV)');



saveas(gcf,'meanIpsiContraMiniAmps');
saveas(gcf,'meanIpsiContraMiniAmps', 'epsc');


%% Stats

[h,p, ci, stats]=ttest(miniMeans(:,1),miniMeans(:,2))


% 
% 
% %% collecting ipsi-contra mEPSPs assuming
% 
% ipsi_mEPSPs = cell2mat(indAmpsI)';
% contra_mEPSPs = cell2mat(indAmpsC)';
% 
% % ipsi_mEPSPs = miniMeans(:,1);
% % contra_mEPSPs =  miniMeans(:,2);
% 
% %% simple bars
% gps = [ones(size(ipsi_mEPSPs));2.*ones(size(contra_mEPSPs))];
% vals = [ipsi_mEPSPs;contra_mEPSPs];
% [Ymean,Ysem,Ystd,Yci] = grpstats(vals,gps,{'mean','sem','std','meanci'});
% 
% figure
% bar([mean(ipsi_mEPSPs),mean(contra_mEPSPs)],.4,'FaceColor','k','LineWidth',2)
% hold on
% he = errorbar(Ymean,Ysem,'k','LineStyle','none'); % error bars are sem
% he.LineWidth=1;
% xlim([0.5 2.5])
% % ylim([0 30])
% ax = gca;
% ax.XTick = [1 2];
% ax.XTickLabel = {'Ipsi';'Contra'};
% ylabel('mEPSP Amplitude (mV)')
% axis square
% 
% %% Permutation test (p = ~0.001)
% nPerm = 100000;
% 
% sa = ipsi_mEPSPs;
% sb = contra_mEPSPs;
% 
% sh0 = [sa; sb];
% 
% m = length(sa); 
% n = length(sb); 
% 
% d_empirical = mean(sa) - mean(sb);
% 
% sa_rand = zeros(m,nPerm);
% sb_rand = zeros(n,nPerm);
% tic
% for ii = 1:nPerm
%     sa_rand(:,ii) = randsample(sh0,m);%,true);
%     sb_rand(:,ii) = randsample(sh0,n);%,true);
% end
% toc
% % Now we compute the differences between the means of these resampled
% % samples.
% % d = median(sb_rand) - median(sa_rand);
% d = mean(sa_rand) - mean(sb_rand);
% 
% %
% figure;
% % [nn,xx] = hist(d,100);
% % bar(xx,nn/sum(nn))
% histogram(d,'Normalization','probability')
% ylabel('Probability of occurrence')
% xlabel('Difference between means')
% hold on
% %
% 
% y = get(gca,'yLim'); % y(2) is the maximum value on the y-axis.
% x = get(gca,'xLim'); % x(1) is the minimum value on the x-axis.
% plot([d_empirical,d_empirical],y*.99,'r-','lineWidth',2)
% 
% % Probability of H0 being true = 
% % (# randomly obtained values > observed value)/total number of simulations
% p = sum(abs(d) > abs(d_empirical))/length(d);
% text(x(1)+(.01*(abs(x(1))+abs(x(2)))),y(2)*.95,sprintf('H0 is true with %4.4f probability.',p))
