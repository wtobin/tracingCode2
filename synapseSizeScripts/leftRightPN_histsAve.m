%Script  assumes aveSizes and aveSizes matricies are in the workspace

%% Display Distributions for ipsi and contra tbar volumes broken out by tracer

figure()
hold on

pnLeftPool=[];
pnRightPool=[];

for o=1:10
    
    
        leftConns=aveSizes(o,[1,2,5]);
        rightConns=aveSizes(o,[3,4]);
        
    
    
    for i=1:numel(leftConns)
        
        pnLeftPool=[pnLeftPool;leftConns{i}(:,2)];
        
    end
    
    for c=1:numel(rightConns)
        
        pnRightPool=[pnRightPool;rightConns{c}(:,2)];
        
    end
    
    
end

[p,h]=ranksum(pnLeftPool,pnRightPool);
h=histogram(pnLeftPool,30);
histogram(pnRightPool,h.BinEdges)
title(['Wilcoxon rank sum p: ',num2str(p)])
xlabel('Tbar Vol (nm^3)','FontSize',14)
ylabel('Freq','FontSize',14)
legend({'Left PN';'Right PN'}, 'FontSize',18)
set(gca,'FontSize',18)


