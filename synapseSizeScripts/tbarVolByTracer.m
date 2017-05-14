%% Tbar Volume 

%This script assumes elementSizes and aveSizes matricies are already in the
%workspace

%% Tbar Volume distributions broken out by tracer

figure()
set(gcf,'Color','w')

% Loopover tracers
for u=1:4
    
    tracersTbarVolPool=[];
    
    tracersWork=elementSizes(:,:,u);
    
    for s =1:numel(tracersWork)
        
       tracersTbarVolPool=[tracersTbarVolPool;tracersWork{s}(:,1)];
        
    end
    
    
    subplot(2,2,u)
    histogram(tracersTbarVolPool,30)
    text(1.5*10^6,50,['Mean: ',num2str(nanmean(tracersTbarVolPool))],'FontSize',18)
    text(1.5*10^6,40,['Std: ',num2str(nanstd(tracersTbarVolPool))],'FontSize',18)
    title(['Tracer ',num2str(u)])
    xlabel('Tbar Vol (nm^3)','FontSize',18)
    ylabel('Freq','FontSize',18)
    xlim([0 3*10^6])
    ylim([0 100])
    
end


