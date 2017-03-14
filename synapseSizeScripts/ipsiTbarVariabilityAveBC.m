%Script  assumes elementSizes and aveSizesBC matricies are in the workspace

%% Determine the mean size of each ORNs ipsi and Contra Tbars

ipsiTbarMeans=[];
contraTbarMeans=[];

for o=1:10
   
    ipsiConns=[];
    contraConns=[];
    
    if o<=5
        ipsiConns=aveSizesBC(o,[1,2,5]);
        contraConns=aveSizesBC(o,[3,4]);
        

    else
        
        ipsiConns=aveSizesBC(o,[3,4]);
        contraConns=aveSizesBC(o,[1,2,5]);
        
    end
    
    for i=1:numel(ipsiConns)
        
        ipsiTbarMeans=[ipsiTbarMeans;mean(ipsiConns{i}(:,1))];
        
    end
    
    for j=1:numel(contraConns)
        
        contraTbarMeans=[contraTbarMeans;mean(contraConns{j}(:,1))];
    end
    
end

%% Plotting
figure()
set(gcf, 'Color','w')
hold on

histogram(ipsiTbarMeans)
histogram(contraTbarMeans, 'BinWidth',.1*10^6)

legend({'Ipsi Conns','Contra Conns'})
title('Connection Mean Tbar Vol')
xlim([0 2*mean([ipsiTbarMeans; contraTbarMeans])])
xlabel('Mean Tbar Volume (nm^3)')
ylabel('Counts')
text(1.1*10^6, 9,['Ipsi CV: ',num2str(std(ipsiTbarMeans)/mean(ipsiTbarMeans))],...
    'FontSize',18)
text(1.1*10^6, 8,['Contra CV: ',num2str(std(contraTbarMeans)/mean(contraTbarMeans))],...
    'FontSize',18)
set(gca,'FontSize',18)
    