%Script  assumes elementSizes and aveSizes matricies are in the workspace

%% Determine the mean size of each ORNs ipsi and Contra Tbars

ipsiTbarMeans=[];


for o=1:10
   
    ipsiConns=[];
    
    if o<=5
        ipsiConns=aveSizes(o,[1,2,5]);
        

    else
        
        ipsiConns=aveSizes(o,[3,4]);
        
    end
    
    for i=1:numel(ipsiConns)
        
        ipsiTbarMeans=[ipsiTbarMeans;mean(ipsiConns{i}(:,1))];
        
    end
    
   
      
end

%% Plotting
figure()
set(gcf, 'Color','w')
hold on

histogram(ipsiTbarMeans)
  

title('Ipsi Connection Mean Tbar Vol')
xlim([0 2*mean(ipsiTbarMeans)])
xlabel('Mean Tbar Volume (nm^3)')
ylabel('Counts')
text(9*10^5, 5,['CV: ',num2str(std(ipsiTbarMeans)/mean(ipsiTbarMeans))],...
    'FontSize',18)
set(gca,'FontSize',18)
    