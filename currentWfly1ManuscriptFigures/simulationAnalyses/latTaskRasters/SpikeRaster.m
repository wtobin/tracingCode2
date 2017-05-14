%The purpose of this code is to generate a spike raster of simulated ORN
%spikes for an example trial of the lateralization task. The raster must
%match the example pnVm trace for this figure.

currentDir=pwd;

%move to working Dir
cd('~/nC_projects/PN1LS_allORNs/simulations/latTask/results_fixedSpikeCount/real_L15_R12_rep651/')

%Load LEFT ORN spiketime
load('spikeTimesL.mat')


%Load LEFT ORN spiketime
load('spikeTimesR.mat')

%move back to where I started from
cd(currentDir)

%Plot a raster for L spikes
figure()
set(gcf,'Color','w')
LineFormat = struct();
LineFormat.LineWidth = 2;
plotSpikeRaster(spikeTimesL,'PlotType','vertline','LineFormat',LineFormat )
ax=gca;
xlim([0 200])
ax.XTick=[0:50:200]
ax.FontSize=18;
ax.DataAspectRatio=[2,1,1];
box off
saveas(gcf,'SpikeRasterL_real','epsc')
saveas(gcf,'SpikeRasterL_real')


figure()
set(gcf,'Color','w')
LineFormat = struct();
LineFormat.LineWidth = 2;
plotSpikeRaster(spikeTimesR,'PlotType','vertline','LineFormat',LineFormat )
ax=gca;
xlim([0 200])
ax.XTick=[0:50:200]
ax.FontSize=18;
ax.DataAspectRatio=[2,1,1];
box off
saveas(gcf,'SpikeRasterR_real','epsc')
saveas(gcf,'SpikeRasterR_real')


