% some supplementary morphometrics

%% Sholl analysis (# branch crossings) at 1 um spheres from skeleton center of mass
load('sholl_avgNodePos.mat') % imported from CATMAID Morphology Plot

sholl = sholl_avgNodePos'; % [radialDist(nm), PN1LS, PN2LS, PN2RS, PN1RS, PN3LS]

figure;

% colors=['k','r','b','m','c'];
colors={[0.53, 0.40, 0.67];...
        [0.23, 0.76, 0.85];...
        [0.12, 0.59, 0.64];...
        [0.30, 0.18, 0.55];...
        [0.05, 0.66, 0.40]};

hold on
for pn = 2:size(PNsOut,2);
    plot(sholl(:,1)/1000,sholl(:,pn),'color',colors{pn-1},'LineWidth',2)
end
ylabel('no. branch crossings')
xlabel('Distance from average node position (\mum)')

legend('PN1 LS','PN2 LS','PN2 RS','PN1 RS','PN3 LS','Location','northeast')

set(gca,'TickDir','out')



%
saveas(gcf,'sholl','epsc')
saveas(gcf,'sholl')

%% Normalized

maxSholl = max(sholl(:,2:6));

normSholl = bsxfun(@rdivide, sholl(:,2:6), maxSholl);

figure
hold on
for pn = 2:size(sholl,2);
    plot(sholl(:,1)/1000,normSholl(:,pn-1),'color',colors{pn-1},'LineWidth',2)
end
ylabel('Norm. branch crossings')
set(gca,'TickDir','out')
xlabel('Distance from average node position (\mum)')

xlim([0 30])

%%
saveas(gcf,'sholl_norm','epsc')
saveas(gcf,'sholl_norm')