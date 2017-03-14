%Script  assumes elementSizes and aveSizesBC matricies are in the workspace

%% Determine the mean size of each ORNs ipsi and Contra Pns

ipsiPnMeans=[];
contraPNMeans=[];

for o=1:10
    
    ipsiConns=[];
    
    if o<=5
        ipsiConns=aveSizesBC(o,[1,2,5]);
        contraConns=aveSizesBC(o,[3,4]);
        
    else
        
        ipsiConns=aveSizesBC(o,[3,4]);
        contraConns=aveSizesBC(o,[1,2,5]);
        
    end
    
    for i=1:numel(ipsiConns)
        
        ipsiPnMeans=[ipsiPnMeans;mean(ipsiConns{i}(:,2))];
        
    end
    
    for j=1:numel(contraConns)
        
        contraPNMeans=[contraPNMeans;mean(contraConns{j}(:,2))];
        
    end
    
    
    
end

%% Plotting
figure()
set(gcf, 'Color','w')
hold on

h=histogram(ipsiPnMeans,10);
histogram(contraPNMeans,10,'BinWidth',h.BinWidth)

title('Ipsi Connection Mean Postsynaptic PN Memb Area')
legend({'Ipsi Conns','Contra Conns'})
xlim([0 2*mean(ipsiPnMeans)])
xlabel('Mean Pn Memb Area (nm^2)')
ylabel('Counts')
text(2*10^4, 7,['Ipsi CV: ',num2str(std(ipsiPnMeans)/mean(ipsiPnMeans))],...
    'FontSize',18)
text(2*10^4, 6,['Contra CV: ',num2str(std(contraPNMeans)/mean(contraPNMeans))],...
    'FontSize',18)
set(gca,'FontSize',18)
