% This code relies on the products of uEPSP_AmpWorking which should be found in the same dir

% Collect the amplitude of ipsilateral and contralateral MEPSPs for R and L PNs

ilmAmps=[];
clmAmps=[];

for i=1:3 %length(PNs)
    
    for j=1:size(leftMEPSPs{i},1)
        
   ilmAmps=[ilmAmps,max(leftMEPSPs{i}(j,:))-mean(leftMEPSPs{i}(j,1:100))];
   
    end
    
    for k=1:size(rightMEPSPs{i},1)
        
    clmAmps=[clmAmps,max(rightMEPSPs{i}(k,:))-mean(rightMEPSPs{i}(k,1:100))];
    
    end
    
    
end

irmAmps=[];
crmAmps=[];

for i=4:5 %length(PNs)
    
    for j=1:size(rightMEPSPs{i},1)
        
        irmAmps=[irmAmps,max(rightMEPSPs{i}(j,:))-mean(rightMEPSPs{i}(j,1:100))];
        
    end
    
    for k=1:size(leftMEPSPs{i},1)
        
        crmAmps=[crmAmps,max(leftMEPSPs{i}(k,:))-mean(leftMEPSPs{i}(k,1:100))];
        
    end
    
end

%%

gpsU = [ones(size(ilmAmps)),2.*ones(size(clmAmps)),3.*ones(size(irmAmps)),4.*ones(size(crmAmps))];
valsU = [ilmAmps,clmAmps,irmAmps,crmAmps];
[YUmean,YUsem,YUstd,YUci] = grpstats(valsU,gpsU,{'mean','sem','std','meanci'});


%% Simple bar plot Left-Right ORNs unitary amplitude
%Ipsi and contra broken out

figure
bar(YUmean,.4,'FaceColor','k','LineWidth',2)
hold on
he = errorbar(YUmean,YUsem,'k','LineStyle','none'); % error bars are std
he.LineWidth=1;
xlim([0.5 4.5])
% ylim([0 80])
ax = gca;
ax.XTick = [1:1:4];
ax.XTickLabel = {'Left Ipsi';'Left Contra';'Right Ipsi';'Right Contra'};
ax.FontSize=16;
ylabel('mEPSP Amp (mV)')
% axis square

%%

gpsU = [ones(size([ilmAmps,clmAmps])),2.*ones(size([irmAmps,crmAmps]))];
valsU = [ilmAmps,clmAmps,irmAmps,crmAmps];
[YUmean,YUsem,YUstd,YUci] = grpstats(valsU,gpsU,{'mean','sem','std','meanci'});


%% Simple bar plot Left-Right ORNs unitary amplitude
%Ipsi and contra broken out

figure
set(gcf,'Color', 'w')
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
ylabel('mEPSP Amp (mV)')
axis square
saveas(gcf,'mEPSPmAmps','epsc')


%% Permutation test (p~ 0.57)
nPerm = 10000;

sa = [ilmAmps';clmAmps'];
sb = [irmAmps';crmAmps'];

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

gps = [ones(size(ilmAmps)),2.*ones(size(irmAmps))];
vals = [ilmAmps,irmAmps];
[Ymean,Ysem,Ystd,Yci] = grpstats(vals,gps,{'mean','sem','std','meanci'});
%%
figure()
% plot([1 2],[ilmAmps',irmAmps'],'-o','Color',[0.67,0.67,0.67])
hold on
h = boxplot(vals,gps,'notch','on');
h.LineWidth = 2;
xlim([0.5 2.5])
% ylim([0 120])
ax = gca;
ax.XTick = [1 2];
ax.XTickLabel = {'Left';'Right'};

ylabel('ORN-->PN uEPSP mAmps')

axis square
