%Script  assumes elementSizes and elementSizes matricies are in the workspace

%% Determine the mean size of each ORNs ipsi and Contra Tbars

figure()
set(gcf, 'Color','w')
hold on

%Loop over tracers
for u=1:4

ipsiTbarMeans=[];


for o=1:10
   
    ipsiConns=[];
    
    if o<=5
        ipsiConns=elementSizes(o,[1,2,5],u);
        

    else
        
        ipsiConns=elementSizes(o,[3,4],u);
        
    end
    
    for i=1:numel(ipsiConns)
        
        ipsiTbarMeans=[ipsiTbarMeans;mean(ipsiConns{i}(:,1))];
        
    end
    
   
      
end

subplot(2,2,u)
histogram(ipsiTbarMeans,10)
  
title(['Tracer: ',num2str(u),' Ipsi Connection Mean Tbar Vol'])
xlim([0 2*nanmean(ipsiTbarMeans)])
ylim([0 6.5])

xlabel('Mean Tbar Volume (nm^3)')
ylabel('Counts')
text(9*10^5, 5,['CV: ',num2str(nanstd(ipsiTbarMeans)/nanmean(ipsiTbarMeans))],...
    'FontSize',18)
set(gca,'FontSize',18)

end
    