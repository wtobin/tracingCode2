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

%%
gpsN = [ones(size(ilNum)),2.*ones(size(irNum))];
valsN = [ilNum,irNum];
[YNmean,YNsem,YNstd,YNci] = grpstats(valsN,gpsN,{'mean','sem','std','meanci'});

gpsU = [ones(size(ilAmps)),2.*ones(size(irAmps))];
valsU = [ilAmps,irAmps];
[YUmean,YUsem,YUstd,YUci] = grpstats(valsU,gpsU,{'mean','sem','std','meanci'});

%% Simple bar plot Left-Right ORNs Synapse Number
figure
bar(YNmean,.4,'FaceColor','k','LineWidth',2)
hold on
he = errorbar(YNmean,YNsem,'k','LineStyle','none'); % error bars are std
he.LineWidth=1;
xlim([0.5 2.5])
% ylim([0 80])
ax = gca;
ax.XTick = [1 2];
ax.XTickLabel = {'Left';'Right'};
ax.FontSize=16;
ylabel('Ipsi ORN-->PN Synapses')
axis square

%% Simple bar plot Left-Right ORNs Synapse Number
figure
bar(YUmean,.4,'FaceColor','k','LineWidth',2)
hold on
he = errorbar(YUmean,YUsem,'k','LineStyle','none'); % error bars are std
he.LineWidth=1;
xlim([0.5 2.5])
% ylim([0 80])
ax = gca;
ax.XTick = [1 2];
ax.XTickLabel = {'Left';'Right'};
ax.FontSize=16;
ylabel('uEPSP Amp (mV)')
axis square
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
subplot(2,1,2)
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

subplot(2,1,1)
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

%% bar

gps = [ones(size(ilAmps)),2*ones(size(irAmps))];
vals = [ilAmps,irAmps];
[Ymean,Ysem,Ystd,Yci] = grpstats(vals,gps,{'mean','sem','std','meanci'});

figure
bar(Ymean,.4, 'k')
hold on
errorbar(Ymean,Ysem,'k','LineStyle','none')
set(gcf, 'Color', 'w')
ax=gca;
xlim([0.5 2.5]);
ylim([0 10]);
ax.XTick=[1:2];
ax.XTickLabel={'Left', 'Right'};
ax.FontSize=16;
ylabel('uEPSP Amp (mV)', 'FontSize', 16);
% title('Mean ipsi ORN-->PN uEPSP Amp', 'FontSize', 18)

axis square

%% Permutation test (p~ 0.57)
nPerm = 10000;

sa = ilAmps';
sb = irAmps';

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


%% plot pairs, box plot

gps = [ones(size(ilAmps)),2.*ones(size(irAmps))];
vals = [ilAmps,irAmps];
[Ymean,Ysem,Ystd,Yci] = grpstats(vals,gps,{'mean','sem','std','meanci'});
%%
figure()
% plot([1 2],[ilAmps',irAmps'],'-o','Color',[0.67,0.67,0.67])
hold on
h = boxplot(vals,gps,'notch','on');
h.LineWidth = 2;
xlim([0.5 2.5])
% ylim([0 120])
ax = gca;
ax.XTick = [1 2];
ax.XTickLabel = {'Left';'Right'};

ylabel('ORN-->PN uEPSP Amps')

axis square

