% some supplementary morphometrics

%% Radial BranchPoints from skeleton center of mass
load('radDenBranchPts_avgNodePos.mat') % imported from CATMAID Morphology Plot
bp = radDenBranchPts_avgNodePos'; % [radialDist(nm), PN1LS, PN2LS, PN2RS, PN1RS, PN3LS]


% colors=['k','r','b','m','c'];
colors={[0.53, 0.40, 0.67];...
        [0.23, 0.76, 0.85];...
        [0.12, 0.59, 0.64];...
        [0.30, 0.18, 0.55];...
        [0.05, 0.66, 0.40]};


figure;
hold on
for pn = 2:size(bp,2);
    plot(bp(:,1)/1000,bp(:,pn),'color',colors{pn-1},'LineWidth',2)
end
ylabel('no. branch points')
set(gca,'TickDir','out')
xlabel('Distance from average node position (\mum)')

xlim([0 15])

%
saveas(gcf,'radialBranchPts','epsc')
saveas(gcf,'radialBranchPts')

%% Normalized

maxBp = max(bp(:,2:6));

normBp = bsxfun(@rdivide, bp(:,2:6), maxBp);

figure
hold on
for pn = 2:size(bp,2);
    plot(bp(:,1)/1000,normBp(:,pn-1),'color',colors{pn-1},'LineWidth',2)
end
ylabel('Norm. branch points')
set(gca,'TickDir','out')
xlabel('Distance from average node position (\mum)')

xlim([0 15])

%%
saveas(gcf,'sholl_radialBranchPts','epsc')
saveas(gcf,'sholl_radialBranchPts')

%% Radial PathLength from skeleton center of mass

load('radDenPathLength_avgNodePos.mat') % imported from CATMAID Morphology Plot
pl = radDenPathLength_avgNodePos'; % [radialDist(nm), PN1LS, PN2LS, PN2RS, PN1RS, PN3LS]

% colors=['k','r','b','m','c'];
colors={[0.53, 0.40, 0.67];...
        [0.23, 0.76, 0.85];...
        [0.12, 0.59, 0.64];...
        [0.30, 0.18, 0.55];...
        [0.05, 0.66, 0.40]};

figure;
hold on
for pn = 2:size(pl,2);
    plot(pl(:,1)/1000,pl(:,pn)/1000,'color',colors{pn-1},'LineWidth',2)
end
ylabel('path length (\mum)')
xlabel('Distance from average node position (\mum)')

set(gca,'TickDir','out')

xlim([0 30])

%
saveas(gcf,'radialPathLength','epsc')
saveas(gcf,'radialPathLength')

%% Normalized

maxPl = max(pl(:,2:6));

normPl = bsxfun(@rdivide, pl(:,2:6), maxPl);

figure
hold on
for pn = 2:size(pl,2);
    plot(pl(:,1)/1000,normPl(:,pn-1),'color',colors{pn-1},'LineWidth',2)
end
ylabel('Norm. path length (\mum)')
set(gca,'TickDir','out')
xlabel('Distance from average node position (\mum)')

xlim([0 30])

%%
saveas(gcf,'sholl_radialPathLength','epsc')
saveas(gcf,'sholl_radialPathLength')