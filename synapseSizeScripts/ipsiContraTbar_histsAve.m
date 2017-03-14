%Script  assumes aveSizes and aveSizes matricies are in the workspace

%% Display Distributions for ipsi and contra tbar volumes broken out by tracer

figure()
hold on

ornIpsiPool=[];
ornContraPool=[];

for o=1:10
    
    if o<=5
        ipsiConns=aveSizes(o,[1,2,5]);
        contraConns=aveSizes(o,[3,4]);
        
    else
        
        contraConns=aveSizes(o,[1,2,5]);
        ipsiConns=aveSizes(o,[3,4]);
        
    end
    
    for i=1:numel(ipsiConns)
        
        ornIpsiPool=[ornIpsiPool;ipsiConns{i}(:,1)];
        
    end
    
    for c=1:numel(contraConns)
        
        ornContraPool=[ornContraPool;contraConns{c}(:,1)];
        
    end
    
    
end

[p,h]=ranksum(ornIpsiPool,ornContraPool);
h=histogram(ornIpsiPool,30);
histogram(ornContraPool,h.BinEdges)
title(['Wilcoxon rank sum p: ',num2str(p)])
xlabel('Tbar Vol (nm^3)','FontSize',14)
ylabel('Freq','FontSize',14)
legend({'Ipsilateral Tbars';'Contralateral Tbars'}, 'FontSize',18)
set(gca,'FontSize',18)


