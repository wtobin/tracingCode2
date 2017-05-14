%Script  assumes elementSizes and aveSizes matricies are in the workspace

%% Determine the mean size of each pns ipsi and Contra Tbars

leftMeans=[];
rightMeans=[];

for o=1:10
    
    pnLeftPool=[];
    pnRightPool=[];

    leftConns=aveSizes(o,[1,2,5]);
    rightConns=aveSizes(o,[3,4]);
    
    for i=1:numel(leftConns)
        
        pnLeftPool=[pnLeftPool;leftConns{i}(:,2)];
        
    end
    
    for c=1:numel(rightConns)
        
        pnRightPool=[pnRightPool;rightConns{c}(:,2)];
        
    end
    
    leftMeans(o)=mean(pnLeftPool);
    rightMeans(o)=mean(pnRightPool);
    
    
end

%% Plotting
figure()
set(gcf, 'Color','w')
hold on

for o=1:10
    scatter(1,leftMeans(o),'filled', 'k')
    scatter(2,rightMeans(o),'filled','k')
    line([1,2],[leftMeans(o),rightMeans(o)])
end


title('Mean PN Area Broken out by ORN')
xlim([0 3])

set(gca,'XTick',[1,2])
set(gca,'XTickLabel',{'Left';'Right'})
set(gca,'FontSize',18)
