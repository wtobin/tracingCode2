%Script  assumes aveSizesBC and aveSizesBC matricies are in the workspace

%% Display Distributions for Left and Right tbar volumes broken out by tracer

figure()
hold on

pnLeftPool=[];
pnRightPool=[];

for o=1:10
    
    
        leftConns=aveSizesBC(o,[1,2,5]);
        rightConns=aveSizesBC(o,[3,4]);
        
    
    
    for i=1:numel(leftConns)
        
        pnLeftPool=[pnLeftPool;leftConns{i}(:,2)];
        
    end
    
    for c=1:numel(rightConns)
        
        pnRightPool=[pnRightPool;rightConns{c}(:,2)];
        
    end
    
    
end

[p,h]=ranksum(pnLeftPool,pnRightPool);
h=histogram(pnLeftPool,30);
histogram(pnRightPool,h.BinEdges)
title(['Wilcoxon rank sum p: ',num2str(p)])
xlabel('Tbar Vol (nm^3)','FontSize',14)
ylabel('Freq','FontSize',14)
legend({'Left PN';'Right PN'}, 'FontSize',18)
set(gca,'FontSize',18)


%%
gpsU = [ones(size(pnLeftPool));2.*ones(size(pnRightPool))];
valsU = [pnLeftPool;pnRightPool];
[YUmean,YUsem,YUstd,YUci] = grpstats(valsU,gpsU,{'mean','sem','std','meanci'});

%% Permutation test (p > 0.77)
nPerm = 10000;

sa = pnLeftPool;
sb = pnRightPool;

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

