%Script  assumes elementSizes and aveSizesBC matricies are in the workspace

%% Determine the mean size of each ORNs ipsi and Contra Tbars

%Loop over tracers

for u=1:4
    
ipsiMeans=[];
contraMeans=[];

for o=1:10
   
    ornIpsiPool=[];
    ornContraPool=[];
    
    
    if o<=5
        ipsiConns=aveSizesBC(o,[1,2,5]);
        contraConns=aveSizesBC(o,[3,4]);

    else
        
        contraConns=aveSizesBC(o,[1,2,5]);
        ipsiConns=aveSizesBC(o,[3,4]);
        
    end
    
    for i=1:numel(ipsiConns)
        
        ornIpsiPool=[ornIpsiPool;ipsiConns{i}(:,1)];
        
    end
    
    for c=1:numel(contraConns)
        
        ornContraPool=[ornContraPool;contraConns{c}(:,1)];
            
    end
    
    ipsiMeans(o)=mean(ornIpsiPool);
    contraMeans(o)=mean(ornContraPool);
        
      
end

end

%% Plotting
figure()
set(gcf, 'Color','w')
hold on

for o=1:10
    scatter(1,ipsiMeans(o),'filled', 'k')
    scatter(2,contraMeans(o),'filled','k')
    line([1,2],[ipsiMeans(o),contraMeans(o)])
end
  

title('Mean Tbar Vol Broken out by ORN')
xlim([0 3])

set(gca,'XTick',[1,2])
set(gca,'XTickLabel',{'Ipsi';'Contra'})
set(gca,'FontSize',18)
    