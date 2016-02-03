for i=1:25
    
    CVs(i,1)=std(outcomes(i,:,1))/mean(outcomes(i,:,1))
    means(i,1)=mean(outcomes(i,:,1));
    
    CVs(i,2)=std(outcomes(i,:,2))/mean(outcomes(i,:,2))
        means(i,2)=mean(outcomes(i,:,2));
    CVs(i,3)=std(outcomes_eq(i,:,2))/mean(outcomes_eq(i,:,2))
        means(i,3)=mean(outcomes_eq(i,:,2));
end

plot(CVs(:,1), 'k')
hold on
plot(CVs(:,2),'r')
plot(CVs(:,3),'b')

curves={'ORN Spike Count','Mean PN Voltage', 'Mean PN Voltage eq cont num'}
ylabel('CV', 'FontSize', 16)
xlabel('ORN Num', 'FontSize',16)
ax=gca;
ax.FontSize=18;
set(gcf, 'Color', 'w')
legend(curves)





plot(means(:,1), 'k')
hold on
plot(means(:,2),'r')
plot(means(:,3),'b')

