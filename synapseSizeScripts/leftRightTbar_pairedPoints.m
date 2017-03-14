%Script  assumes elementSizes and aveSizes matricies are in the workspace

%% Determine the mean size of each ORNs ipsi and Contra Tbars

leftMeans=[];
rightMeans=[];

for o=1:10
    
    ornLeftPool=[];
    ornRightPool=[];

    leftConns=aveSizes(o,[1,2,5]);
    rightConns=aveSizes(o,[3,4]);
    
    for i=1:numel(leftConns)
        
        ornLeftPool=[ornLeftPool;leftConns{i}(:,1)]
        
    end
    
    for c=1:numel(rightConns)
        
        ornRightPool=[ornRightPool;rightConns{c}(:,1)];
        
    end
    
    leftMeans(o)=mean(ornLeftPool);
    rightMeans(o)=mean(ornRightPool);
    
    
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


title('Mean Tbar Vol Broken out by ORN')
xlim([0 3])

set(gca,'XTick',[1,2])
set(gca,'XTickLabel',{'Left';'Right'})
set(gca,'FontSize',18)
