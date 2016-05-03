% The purpose of this code is to generate a connected scatter plot of  mean
% uEPSP amp from ipsi and contra ORNs. This code relies on the product of
% pulluEPSPs

%% Load annotations and connectors

% Load annotations json. Generated by Wei's code gen_annotation_map.py
annotations=loadjson('~/tracing/sid_by_annotation.json');

% Return all skeleton IDs for R and L ORNs

ORNs_Left=annotations.Left_0x20_ORN;
ORNs_Right=annotations.Right_0x20_ORN;

ORNs=[ORNs_Left, ORNs_Right];
            
%return all skeleton IDs of DM6 PNs
PNs=sort(annotations.DM6_0x20_PN);


% return all skel IDs with *LN* in fieldname
Fn = fieldnames(annotations);
selFn = Fn(~cellfun(@isempty,regexp(Fn,'LN')));

LNs=[];
for i = 1:numel(selFn)
    LNs=[LNs, annotations.(selFn{i})];
end

LNs = unique(LNs);

%Load the connector structure
load('~/tracing/conns.mat')

%Base dir for simulation results
baseDir='~/nC_projects/';

%%

% Collect the amplitude of ipsi and contra uEPSPs for R and L ORN-->PN
% pairs

 rightCounter=1;
 
for p = 1:5
    
   
    
    if p<=3
        
        for o=1:size(leftUEPSPs{p},1)
            
            leftPNIpsiAmps(p,o)=max(leftUEPSPs{p}(o,:))-mean(leftUEPSPs{p}(o,1:100));
            
        end
        
        for o=1:size(rightUEPSPs{p},1)
            
            leftPNContraAmps(p,o)=max(rightUEPSPs{p}(o,:))-mean(rightUEPSPs{p}(o,1:100));
            
        end
        
    else
        
        for o=1:size(leftUEPSPs{p},1)
            
            rightPNContraAmps(rightCounter,o)=max(leftUEPSPs{p}(o,:))-mean(leftUEPSPs{p}(o,1:100));
            
        end
        
        for o=1:size(rightUEPSPs{p},1)
            
            rightPNIpsiAmps(rightCounter,o)=max(rightUEPSPs{p}(o,:))-mean(rightUEPSPs{p}(o,1:100));
            
        end
        
        rightCounter=rightCounter+1;
        
    end
    
     
    
end


%% Plotting

figure()
set(gcf,'Color','w')

rightCounter=1;

for p=1:5
    
    
    
    if p<=3
        
        scatter([1 2],[mean(leftPNIpsiAmps(p,:)) mean(leftPNContraAmps(p,:))]...
            ,54,'Filled' ,'k')
        line([1 2 ], [mean(leftPNIpsiAmps(p,:)) mean(leftPNContraAmps(p,:))]...
            ,'Color', 'k', 'LineWidth',1)
        hold on
        
        uniMeans(p,1)=mean(leftPNIpsiAmps(p,:));
        uniMeans(p,2)=mean(leftPNContraAmps(p,:));
        
    else
        scatter([1 2],[mean(rightPNIpsiAmps(rightCounter,:)) mean(rightPNContraAmps(rightCounter,:))]...
            ,54, 'Filled','k')
        line([1 2 ], [mean(rightPNIpsiAmps(rightCounter,:)) mean(rightPNContraAmps(rightCounter,:))]...
            ,'Color', 'k', 'LineWidth',1)
        
        
        
        uniMeans(p,1)=mean(rightPNIpsiAmps(rightCounter,:));
        uniMeans(p,2)=mean(rightPNContraAmps(rightCounter,:));
        
        rightCounter=rightCounter+1;
    end
    
    
end

xlim([0.5 2.5])
ylim([4 6.5])

ax=gca;
ax.XTick=[1,2];
ax.XTickLabel={'Ipsi','Contra'};
ax.FontSize=16;
ax.YTick=[4:1.25:6.5];
ax.TickDir='out';
ax.LineWidth=1;
pbaspect([1 1.65 1])

ylabel('mean uEPSP Amplitude (mV)');

saveas(gcf,'meanIpsiContraUniAmps');
saveas(gcf,'meanIpsiContraUniAmps', 'epsc');

%% Stats

[h,p]=ttest(uniMeans(:,1),uniMeans(:,2))



% 
% 
% %% collecting ipsi-contra uEPSPs assuming
% % rows 1-26 are left orns
% % columns 1-3 are left pns
% 
% ll_uEPSPs = uEPSP_Amps(1:26,1:3);
% rr_uEPSPs = uEPSP_Amps(27:end,4:5);
% 
% lr_uEPSPs = uEPSP_Amps(1:26,4:5);
% rl_uEPSPs = uEPSP_Amps(27:end,1:3);
% 
% ipsi_uEPSPs = [ll_uEPSPs(:);rr_uEPSPs(:)];
% contra_uEPSPs = [lr_uEPSPs(:);rl_uEPSPs(:)];
% 
% %% simple bars
% gps = [ones(size(ipsi_uEPSPs));2.*ones(size(contra_uEPSPs))];
% vals = [ipsi_uEPSPs;contra_uEPSPs];
% [Ymean,Ysem,Ystd,Yci] = grpstats(vals,gps,{'mean','sem','std','meanci'});
% 
% figure
% bar([mean(ipsi_uEPSPs),mean(contra_uEPSPs)],.4,'FaceColor','k','LineWidth',2)
% hold on
% he = errorbar(Ymean,Ysem,'k','LineStyle','none'); % error bars are sem
% he.LineWidth=1;
% xlim([0.5 2.5])
% % ylim([0 30])
% ax = gca;
% ax.XTick = [1 2];
% ax.XTickLabel = {'Ipsi';'Contra'};
% ylabel('uEPSP (mV)')
% axis square
% 
% %% Permutation test (p~0)
% nPerm = 100000;
% 
% sa = ipsi_uEPSPs;
% sb = contra_uEPSPs;
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
% 