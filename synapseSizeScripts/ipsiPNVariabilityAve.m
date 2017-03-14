%Script  assumes elementSizes and aveSizes matricies are in the workspace

%% Determine the mean size of each ORNs ipsi and Contra Pns

ipsiPnMeans=[];


for o=1:10
   
    ipsiConns=[];
    
    if o<=5
        ipsiConns=aveSizes(o,[1,2,5]);
        

    else
        
        ipsiConns=aveSizes(o,[3,4]);
        
    end
    
    for i=1:numel(ipsiConns)
        
        ipsiPnMeans=[ipsiPnMeans;mean(ipsiConns{i}(:,2))];
        
    end
    
   
      
end

%% Plotting
figure()
set(gcf, 'Color','w')
hold on

histogram(ipsiPnMeans,10)
  

title('Ipsi Connection Mean Postsynaptic PN Memb Area')
xlim([0 2*mean(ipsiPnMeans)])
xlabel('Mean Pn Memb Area (nm^2)')
ylabel('Counts')
text(2*10^4, 5,['CV: ',num2str(std(ipsiPnMeans)/mean(ipsiPnMeans))],...
    'FontSize',18)
set(gca,'FontSize',18)
    