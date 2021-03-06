% for bar graph of ipsi contra synapse numbers

%% Load annotations and connectors
% clear

% Load annotations json. Generated by Wei's code gen_annotation_map.py
annotations=loadjson('~/tracing/sid_by_annotation.json');
% annotations=loadjson('~/Dropbox/htem_team/analysis/wfly1/tracing/sid_by_annotation.json');

% Return all skeleton IDs for R and L ORNs

ORNs_Left=annotations.Left_0x20_ORN;
ORNs_Right=annotations.Right_0x20_ORN;

%exclude unilateral ORNs for now
ORNs_Right(find(ORNs_Right == 499879))=[];
% ORNs_Left(find(ORNs_Left == 426230))=[]; % resolved
ORNs_Left(find(ORNs_Left == 401378))=[];
% 
% %exclude ORN 8 because it was temporarily unilateral on 8/5 for testing 
% ORNs_Left(find(ORNs_Left == 593865))=[];

ORNs=[ORNs_Left, ORNs_Right];

%return all skeleton IDs of DM6 PNs
% PNs=annotations.PN;
PNs=sort(annotations.DM6_0x20_PN);
% PNs=annotations.DM6_0x20_PN;

PNs_Left = PNs([1,2,5]);
PNs_Right = PNs([4,3]);

% return all skel IDs with *LN* in fieldname
Fn = fieldnames(annotations);
selFn = Fn(~cellfun(@isempty,regexp(Fn,'LN')));

LNs=[];
for i = 1:numel(selFn)
    LNs=[LNs, annotations.(selFn{i})];
end

LNs = unique(LNs);

%
% LNs=annotations.LN;
% LNs=[LNs, annotations.potential_0x20_LN];
% LNs=[LNs, annotations.Prospective_0x20_LN];
% LNs=[LNs, annotations.Likely_0x20_LN];


%Load the connector structure
load('~/tracing/conns.mat')
% load('~/Dropbox/htem_team/analysis/wfly1/tracing/conns.mat')

%gen conn fieldname list
connFields=fieldnames(conns);

%% count synapse numbers for all possible ipsi and contra ORN-PN pairs
% ipsi is [lORN-lPN,rORN-rPN]
% contra is [lORN-rPN,rORN-lPN]

% generate pairs list
%[p,q] = meshgrid(vec1, vec2);
%pairs = [p(:) q(:)];

[ilp,ilq] = meshgrid(ORNs_Left, PNs_Left);
[irp,irq] = meshgrid(ORNs_Right, PNs_Right);
ipsiPairs = [ilp(:),ilq(:);irp(:),irq(:)];

[clp,clq] = meshgrid(ORNs_Left, PNs_Right);
[crp,crq] = meshgrid(ORNs_Right, PNs_Left);
contraPairs = [clp(:),clq(:);crp(:),crq(:)];


% generate vectors of synapse numbers from pairs lists
% uses WFT's getSynapseNum function

tic
ipsiCont=nan(length(ipsiPairs),1);
for i=1:length(ipsiPairs)
    ipsiCont(i)=getSynapseNum(ipsiPairs(i,1),ipsiPairs(i,2));
end
toc

tic
contraCont=nan(length(contraPairs),1);
for i=1:length(contraPairs)
    contraCont(i)=getSynapseNum(contraPairs(i,1),contraPairs(i,2));
end
toc

%% simple bars
gps = [ones(size(ipsiCont));2.*ones(size(contraCont))];
vals = [ipsiCont;contraCont];
[Ymean,Ysem,Ystd,Yci] = grpstats(vals,gps,{'mean','sem','std','meanci'});

figure
bar([mean(ipsiCont),mean(contraCont)],.4,'FaceColor','k','LineWidth',2)
hold on
he = errorbar(Ymean,Ysem,'k','LineStyle','none'); % error bars are sem
he.LineWidth=1;
xlim([0.5 2.5])
ylim([0 30])
ax = gca;
ax.XTick = [1 2];
ax.XTickLabel = {'Ipsi';'Contra'};
ylabel('Synapses')
axis square

%% Permutation test (p~0)
nPerm = 100000;

sa = ipsiCont;
sb = contraCont;

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