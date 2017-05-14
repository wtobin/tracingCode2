%Script  assumes elementSizes and elementSizes matricies are in the workspace

%% Display Distributions for ipsi and contra tbar volumes broken out by tracer

figure()

%loop over tracers
for u=1:4
    
    pnIpsiPool=[];
    pnContraPool=[];
    
    for o=1:10
        
        if o<=5
            ipsiConns=elementSizes(o,[1,2,5],u);
            contraConns=elementSizes(o,[3,4],u);
            
        else
            
            contraConns=elementSizes(o,[1,2,5],u);
            ipsiConns=elementSizes(o,[3,4],u);
            
        end
        
        for i=1:numel(ipsiConns)
            
            pnIpsiPool=[pnIpsiPool;ipsiConns{i}(:,2)];
            
        end
        
        for c=1:numel(contraConns)
            
            pnContraPool=[pnContraPool;contraConns{c}(:,2)];
            
        end
        
        
    end
    
    [p,h]=ranksum(pnIpsiPool,pnContraPool);
    subplot(2,2,u)
    hold on
    h=histogram(pnIpsiPool,30);
    histogram(pnContraPool,h.BinEdges)
    title(['Tracer ',num2str(u), ' Wilcoxon rank sum p: ',num2str(p)])
    xlabel('PN Area (nm^2)','FontSize',14)
    ylabel('Freq','FontSize',14)
    legend({'Ipsi PN Area';'Contra PN Area'}, 'FontSize',18)
    set(gca,'FontSize',18)
    xlim([0 15*10^4])
    ylim([0 100])
    
    
end
