%Script  assumes aveSizes and aveSizes matricies are in the workspace

%% Display Distributions for ipsi and contra tbar volumes broken out by tracer

figure()
hold on


pnIpsiPool=[];
pnContraPool=[];

for o=1:10
    
    if o<=5
        ipsiConns=aveSizes(o,[1,2,5]);
        contraConns=aveSizes(o,[3,4]);
        
    else
        
        contraConns=aveSizes(o,[1,2,5]);
        ipsiConns=aveSizes(o,[3,4]);
        
    end
    
    for i=1:numel(ipsiConns)
        
        pnIpsiPool=[pnIpsiPool;ipsiConns{i}(:,2)];
        
    end
    
    for c=1:numel(contraConns)
        
        pnContraPool=[pnContraPool;contraConns{c}(:,2)];
        
    end
    
    
end

[p,h]=ranksum(pnIpsiPool,pnContraPool);
h=histogram(pnIpsiPool,30);
histogram(pnContraPool,h.BinEdges)
title(['Wilcoxon rank sum p: ',num2str(p)])
xlabel('PN Area (nm^2)','FontSize',14)
ylabel('Freq','FontSize',14)
legend({'Ipsi Post PN Area';'Contra Post PN Area'}, 'FontSize',18)
set(gca,'FontSize',18)


