%Script  assumes elementSizes and aveSizes matricies are in the workspace

%% Determine the mean size of each ORNs ipsi and Contra Tbars

ipsiTbarMeans=[];
ipsiPNMeans=[];
synsPerConn=[];

for o=1:10
   
    ipsiConns=[];
    
    if o<=5
        ipsiConns=aveSizes(o,[1,2,5]);
        

    else
        
        ipsiConns=aveSizes(o,[3,4]);
        
    end
    
    for i=1:numel(ipsiConns)
        
        ipsiTbarMeans=[ipsiTbarMeans;mean(ipsiConns{i}(:,1))];
        ipsiPNMeans=[ipsiPNMeans;mean(ipsiConns{i}(:,2))];
        synsPerConn=[synsPerConn;size(ipsiConns{i},1)];
        
    end
    
   
      
end

%% Plotting
figure()
set(gcf, 'Color','w')
hold on

subplot(2,1,1)
scatter(synsPerConn,ipsiTbarMeans,'k', 'filled')
title('Ipsi Connection Mean Tbar Vol Vs. Syns Per Conn')
%xlim([0 2*mean(ipsiTbarMeans)])
xlabel('Synapse Number')
ylabel('Mean Tbar Volume (nm^3)')
set(gca,'FontSize',18)

subplot(2,1,2)
scatter(synsPerConn,ipsiPNMeans,'r','filled')
  
title('Ipsi Connection Mean Post PN Area Vs. Syns Per Conn')
%xlim([0 2*mean(ipsiTbarMeans)])
xlabel('Synapse Number')
ylabel('Ave Post PN Memb Area (nm^2)')

set(gca,'FontSize',18)

    