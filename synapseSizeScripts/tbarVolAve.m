%% Tbar Volume 

%This script assumes elementSizes and aveSizes matricies are already in the
%workspace

%% Tbar Volume distribution averaged over tracers

figure()
set(gcf,'Color','w')


    tbarVolPool=[];
   
    
    for s =1:numel(aveSizes)
        
       tbarVolPool=[tbarVolPool;aveSizes{s}(:,1)];
        
    end
    
    
  
    histogram(tbarVolPool,30)
    text(1.5*10^6,50,['Mean: ',num2str(nanmean(tbarVolPool))],'FontSize',18)
    text(1.5*10^6,45,['Std: ',num2str(nanstd(tbarVolPool))],'FontSize',18)
    title(['Tbar Vol Averaged Over Tracers'])
    xlabel('Tbar Vol (nm^3)','FontSize',18)
    ylabel('Freq','FontSize',18)
    xlim([0 3*10^6])
    %ylim([0 60])
    



