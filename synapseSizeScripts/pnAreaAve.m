%% PN Postsynaptic Membrane Area 

%This script assumes elementSizes and aveSizes matricies are already in the
%workspace

%% PN postsynaptic membrane area distribution averaged over tracers

figure()
set(gcf,'Color','w')


    PNAreaPool=[];
   
    
    for s =1:numel(aveSizes)
        
       PNAreaPool=[PNAreaPool;aveSizes{s}(:,2)];
        
    end
    
    
  
    histogram(PNAreaPool,30)
    text(4*10^4,140,['Mean: ',num2str(nanmean(PNAreaPool))],'FontSize',18)
    text(4*10^4,120,['Std: ',num2str(nanstd(PNAreaPool))],'FontSize',18)
    title(['Tbar Vol Averaged Over Tracers'])
    xlabel('Tbar Vol (nm^3)','FontSize',18)
    ylabel('Freq','FontSize',18)
    %xlim([0 3*10^6])
    %ylim([0 60])
    



