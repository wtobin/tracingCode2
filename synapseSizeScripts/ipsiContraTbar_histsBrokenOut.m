%Script  assumes biasCorrSizes and biasCorrSizes matricies are in the workspace

%% Display Distributions for ipsi and contra tbar volumes broken out by tracer

figure()

%loop over tracers
for u=1:4
    
    ornIpsiPool=[];
    ornContraPool=[];
    
    for o=1:10
        
        if o<=5
            ipsiConns=biasCorrSizes(o,[1,2,5],u);
            contraConns=biasCorrSizes(o,[3,4],u);
            
        else
            
            contraConns=biasCorrSizes(o,[1,2,5],u);
            ipsiConns=biasCorrSizes(o,[3,4],u);
            
        end
        
        for i=1:numel(ipsiConns)
            
            ornIpsiPool=[ornIpsiPool;ipsiConns{i}(:,1)];
            
        end
        
        for c=1:numel(contraConns)
            
            ornContraPool=[ornContraPool;contraConns{c}(:,1)];
            
        end
        
        
    end
    
    [p,h]=ranksum(ornIpsiPool,ornContraPool);
    subplot(2,2,u)
    hold on
    h=histogram(ornIpsiPool,30);
    histogram(ornContraPool,h.BinEdges)
    title(['Tracer ',num2str(u), ' Wilcoxon rank sum p: ',num2str(p)])
    xlabel('Tbar Vol (nm^3)','FontSize',14)
    ylabel('Freq','FontSize',14)
    legend({'Ipsilateral Tbars';'Contralateral Tbars'}, 'FontSize',18)
    set(gca,'FontSize',18)
    
    
end
