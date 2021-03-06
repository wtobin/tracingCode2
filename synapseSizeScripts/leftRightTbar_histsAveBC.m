%Script  assumes aveSizesBC and aveSizesBC matricies are in the workspace

%% Display Distributions for ipsi and contra tbar volumes broken out by tracer

figure()
hold on

ornLeftPool=[];
ornRightPool=[];

for o=1:10
    
    
        leftConns=aveSizesBC(o,[1,2,5]);
        rightConns=aveSizesBC(o,[3,4]);
        
    
    
    for i=1:numel(leftConns)
        
        ornLeftPool=[ornLeftPool;leftConns{i}(:,1)];
        
    end
    
    for c=1:numel(rightConns)
        
        ornRightPool=[ornRightPool;rightConns{c}(:,1)];
        
    end
    
    
end

[p,h]=ranksum(ornLeftPool,ornRightPool);
h=histogram(ornLeftPool,30);
histogram(ornRightPool,h.BinEdges)
title(['Wilcoxon rank sum p: ',num2str(p)])
xlabel('Tbar Vol (nm^3)','FontSize',14)
ylabel('Freq','FontSize',14)
legend({'Left Tbars';'Right Tbars'}, 'FontSize',18)
set(gca,'FontSize',18)


