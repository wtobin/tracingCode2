%Script  assumes elementSizes and elementSizes matricies are in the workspace

%% Determine the mean size of each ORNs ipsi and Contra pns

figure()
set(gcf, 'Color','w')
hold on

%Loop over tracers
for u=1:4

ipsiPnMeans=[];


for o=1:10
   
    ipsiConns=[];
    
    if o<=5
        ipsiConns=elementSizes(o,[1,2,5],u);
        

    else
        
        ipsiConns=elementSizes(o,[3,4],u);
        
    end
    
    for i=1:numel(ipsiConns)
        
        ipsiPnMeans=[ipsiPnMeans;mean(ipsiConns{i}(:,2))];
        
    end
    
   
      
end

subplot(2,2,u)
histogram(ipsiPnMeans,10)
  
title(['Tracer: ',num2str(u),' Ipsi Connection Mean Post Pn Area '])
xlim([0 2*nanmean(ipsiPnMeans)])
ylim([0 5.2])

xlabel('Mean PN area (nm^2)')
ylabel('Counts')
text(2*10^4, 2.5,['CV: ',num2str(nanstd(ipsiPnMeans)/nanmean(ipsiPnMeans))],...
    'FontSize',18)
set(gca,'FontSize',18)

end
    