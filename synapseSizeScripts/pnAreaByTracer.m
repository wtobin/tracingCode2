%% PN postsynaptic membrane area

%This script assumes elementSizes and aveSizes matricies are already in the
%workspace

%% PN membrane area distributions broken out by tracer

figure()
set(gcf,'Color','w')

% Loopover tracers
for u=1:4
    
    tracersPNAreaPool=[];
    
    tracersWork=elementSizes(:,:,u);
    
    for s =1:numel(tracersWork)
        
       tracersPNAreaPool=[tracersPNAreaPool;tracersWork{s}(:,2)];
        
    end
    
    
    subplot(2,2,u)
    histogram(tracersPNAreaPool,30)
    text(5*10^4,75,['Mean: ',num2str(nanmean(tracersPNAreaPool))],'FontSize',18)
    text(5*10^4,60,['Std: ',num2str(nanstd(tracersPNAreaPool))],'FontSize',18)
    title(['Tracer ',num2str(u)])
    xlabel('PN Membrane Area (nm^2)','FontSize',18)
    ylabel('Freq','FontSize',18)
    xlim([0 15*10^4])
    ylim([0 200])
    
end


