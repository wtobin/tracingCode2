%Script  assumes elementSizes and aveSizes matricies are in the workspace

%% Determine the mean size of each pns ipsi and Contra Tbars

iPNPool=[];
cPNPool=[];

for o=1:5
    
    ipsiPool=[];
    contraPool=[];
    
    if ismember(o,[1,2,5])
        ipsiConns=aveSizes(1:5,o);
        contraConns=aveSizes(6:10,o);
    else
        ipsiConns=aveSizes(6:10,o);
        contraConns=aveSizes(1:5,o);
        
    end
    
    for i=1:numel(ipsiConns)
        
        ipsiPool=[ipsiPool;ipsiConns{i}(:,2)];
        
    end
    
      for i=1:numel(contraConns)
        
        contraPool=[contraPool;contraConns{i}(:,2)];
        
    end

    iPNPool{o}=ipsiPool;
    cPNPool{o}=contraPool;
    
end

%% Plotting
figure()
set(gcf, 'Color','w')
hold on

forBoxPlot=[];

labels={'1LS Ipsi','1LS Contra','2LS Ipsi','2LS Contra',...
    '2RS Ipsi','2RS Contra','1RS Ipsi','1RS Contra',...
    '3LS Ipsi','3LS Contra'};

for o=1:5
    
   forBoxPlot=[forBoxPlot;...
       [(o*2-1)*ones(numel(iPNPool{o}),1),iPNPool{o}];...
       [(o*2)*ones(numel(cPNPool{o}),1),cPNPool{o}]];
       
    
end

boxplot(forBoxPlot(:,2),forBoxPlot(:,1),'Notch',...
    'on','Labels',labels)
title('Post PN Area Broken out by PN ID, Ipsi/Contra Tbars')

set(gca,'FontSize',18)
set(findobj(gca,'Type','text'),'FontSize',18)