%The goal of this code is to generate a spike raster of simulated ORN
%spikes used in the spike count discrim task. The trial used needs to match
%that used in the example simulated PN response

%Load spiketime
load('~/nC_projects/PN2LS_allORNs/simulations/detTask/results_fixedSpike_12Spikes/real_dF0_rep25/spikeTimes.mat')

%Plot a raster
figure()
set(gcf,'Color','w')

LineFormat = struct();
LineFormat.LineWidth = 2;
plotSpikeRaster(spikeTimes,'PlotType','vertline' ,'LineFormat',LineFormat)
ax=gca;
xlim([0 200])
ax.XTick=[0:50:200]
ax.FontSize=18;
ax.DataAspectRatio=[2,1,1];
box off
saveas(gcf,'spikeRaster','epsc')
saveas(gcf,'spikeRaster')