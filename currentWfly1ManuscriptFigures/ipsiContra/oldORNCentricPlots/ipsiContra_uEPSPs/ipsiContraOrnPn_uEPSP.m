

% This code relies on the products of uEPSP_AmpWorking

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

%% collecting ipsi-contra uEPSPs assuming
% rows 1-26 are left orns
% columns 1-3 are left pns

ll_uEPSPs = uEPSP_Amps(1:26,1:3);
rr_uEPSPs = uEPSP_Amps(27:end,4:5);

lr_uEPSPs = uEPSP_Amps(1:26,4:5);
rl_uEPSPs = uEPSP_Amps(27:end,1:3);

ipsi_uEPSPs = [ll_uEPSPs(:);rr_uEPSPs(:)];
contra_uEPSPs = [lr_uEPSPs(:);rl_uEPSPs(:)];

%% simple bars
gps = [ones(size(ipsi_uEPSPs));2.*ones(size(contra_uEPSPs))];
vals = [ipsi_uEPSPs;contra_uEPSPs];
[Ymean,Ysem,Ystd,Yci] = grpstats(vals,gps,{'mean','sem','std','meanci'});

figure
bar([mean(ipsi_uEPSPs),mean(contra_uEPSPs)],.4,'FaceColor','k','LineWidth',2)
hold on
he = errorbar(Ymean,Ysem,'k','LineStyle','none'); % error bars are sem
he.LineWidth=1;
xlim([0.5 2.5])
% ylim([0 30])
ax = gca;
ax.XTick = [1 2];
ax.XTickLabel = {'Ipsi';'Contra'};
ylabel('uEPSP (mV)')
axis square

%% Permutation test (p~0)
nPerm = 100000;

sa = ipsi_uEPSPs;
sb = contra_uEPSPs;

sh0 = [sa; sb];

m = length(sa); 
n = length(sb); 

d_empirical = mean(sa) - mean(sb);

sa_rand = zeros(m,nPerm);
sb_rand = zeros(n,nPerm);
tic
for ii = 1:nPerm
    sa_rand(:,ii) = randsample(sh0,m);%,true);
    sb_rand(:,ii) = randsample(sh0,n);%,true);
end
toc
% Now we compute the differences between the means of these resampled
% samples.
% d = median(sb_rand) - median(sa_rand);
d = mean(sa_rand) - mean(sb_rand);

%
figure;
% [nn,xx] = hist(d,100);
% bar(xx,nn/sum(nn))
histogram(d,'Normalization','probability')
ylabel('Probability of occurrence')
xlabel('Difference between means')
hold on
%

y = get(gca,'yLim'); % y(2) is the maximum value on the y-axis.
x = get(gca,'xLim'); % x(1) is the minimum value on the x-axis.
plot([d_empirical,d_empirical],y*.99,'r-','lineWidth',2)

% Probability of H0 being true = 
% (# randomly obtained values > observed value)/total number of simulations
p = sum(abs(d) > abs(d_empirical))/length(d);
text(x(1)+(.01*(abs(x(1))+abs(x(2)))),y(2)*.95,sprintf('H0 is true with %4.4f probability.',p))

