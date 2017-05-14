% some supplementary morphometrics

%% Radial Synapse Density at 1 um spheres from skeleton center of mass
load('radDenSynsIN_avgNodePos.mat') % imported from CATMAID Morphology Plot
load('radDenSynsOUT_avgNodePos.mat') % imported from CATMAID Morphology Plot

PNsIn = radDenSynsIN_avgNodePos'; % [radialDist(nm), PN1LS, PN2LS, PN2RS, PN1RS, PN3LS]
PNsOut = radDenSynsOUT_avgNodePos'; % [radialDist(nm), PN1LS, PN2LS, PN2RS, PN1RS, PN3LS]

figure;

% colors=['k','r','b','m','c'];
colors={[0.53, 0.40, 0.67];...
        [0.23, 0.76, 0.85];...
        [0.12, 0.59, 0.64];...
        [0.30, 0.18, 0.55];...
        [0.05, 0.66, 0.40]};


ax1 = subplot(2,1,1);
hold on
for pn = 2:size(PNsIn,2);
    plot(PNsIn(:,1)/1000,PNsIn(:,pn),'color',colors{pn-1},'LineWidth',2)
end
ylabel('no. input synapses')
set(gca,'TickDir','out')

ax2 = subplot(2,1,2);
hold on
for pn = 2:size(PNsOut,2);
    plot(PNsOut(:,1)/1000,PNsOut(:,pn),'color',colors{pn-1},'LineWidth',2)
end
ylabel('no. output synapses')
xlabel('Distance from average node position (\mum)')

linkaxes([ax1,ax2],'x');

set(gca,'TickDir','out')

%%
saveas(gcf,'radialSynsInOut','epsc')
saveas(gcf,'radialSynsInOut')

%% Normalized

maxIns = max(PNsIn(:,2:6));
maxOuts = max(PNsOut(:,2:6));

normPNsIn = bsxfun(@rdivide, PNsIn(:,2:6), maxIns);
normPNsOut = bsxfun(@rdivide, PNsOut(:,2:6), maxOuts);

figure
ax1 = subplot(2,1,1);
hold on
for pn = 2:size(PNsIn,2);
    plot(PNsIn(:,1)/1000,normPNsIn(:,pn-1),'color',colors{pn-1},'LineWidth',2)
end
ylabel('Norm. input synapses')
set(gca,'TickDir','out')

ax2 = subplot(2,1,2);
hold on
for pn = 2:size(PNsOut,2);
    plot(PNsOut(:,1)/1000,normPNsOut(:,pn-1),'color',colors{pn-1},'LineWidth',2)
end
ylabel('Norm. output synapses')
xlabel('Distance from average node position (\mum)')

linkaxes([ax1,ax2],'x');

set(gca,'TickDir','out')
%%
saveas(gcf,'radialSynsInOut_norm','epsc')
saveas(gcf,'radialSynsInOut_norm')