%The purpose of this code is to generate a plot of example PN membrane
%potential traces taken from my lateralization simulations. Must match the
%trial for which we are showing rasters


%collect and save PN traces
PN_Names={'PN1LS','PN2LS', 'PN3LS', 'PN1RS', 'PN2RS'};

figure()
set(gcf,'Color','w')

for i=1:5
    
    pn=PN_Names{i};
    base=['/home/simulation/nC_projects_retired160201/',pn,'_allORNs/simulations/latTask/results_fixedSpikeCount/real_L15_R12_rep650/'];
    resultFiles=dir(base);
    
    pnvm_working=importdata([base,resultFiles(3).name ]);
    
    
    if i<=3
        plot([0:1/40:200],pnvm_working(1:8001),'b')
        hold on
    else
        plot([0:1/40:200],pnvm_working(1:8001),'r')
        hold on
    end
    
    
    ax=gca;
    ax.XTick=[0:50:200];
    ax.FontSize=18;
    ax.YTick=[-60:10:-35];
    ylim([-60 -35])
    ax.DataAspectRatio=[4,1, 1];
    box off
    meanResponses(i)=mean(pnvm_working)+60;
    
    
end

saveas(gcf,'LatTaskExamplePNResponses','epsc')
saveas(gcf,'LatTaskExamplePNResponses')