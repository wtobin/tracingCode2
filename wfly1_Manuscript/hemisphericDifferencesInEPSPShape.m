for p=1:3

counter=1;

for o=1:size(leftUEPSPs{p},1)
    
    workingUEPSP=leftUEPSPs{p}(o,:)+59.3999;
leftEPSPs(p,1,counter,:)=workingUEPSP;
    leftEPSPs(p,2,counter,:)=workingUEPSP./max(workingUEPSP);
    counter=counter+1;
    
end

for o=1:size(rightUEPSPs{p},1)
    
    workingUEPSP=rightUEPSPs{p}(o,:)+59.3999;
    leftEPSPs(p,1,counter,:)=workingUEPSP;
    leftEPSPs(p,2,counter,:)=workingUEPSP./max(workingUEPSP);
    counter=counter+1;
    
end

end


pnCounter=1;
for p=4:5

counter=1;

for o=1:size(leftUEPSPs{p},1)
    
    workingUEPSP=leftUEPSPs{p}(o,:)+59.3999;
    rightEPSPs(pnCounter,1,counter,:)=workingUEPSP;
    rightEPSPs(pnCounter,2,counter,:)=workingUEPSP./max(workingUEPSP);
    counter=counter+1;
    
end

for o=1:size(rightUEPSPs{p},1)
    
    workingUEPSP=rightUEPSPs{p}(o,:)+59.3999;
    rightEPSPs(pnCounter,1,counter,:)=workingUEPSP;
    rightEPSPs(pnCounter,2,counter,:)=workingUEPSP./max(workingUEPSP);
    counter=counter+1;
    
end

pnCounter=pnCounter+1;

end



%Sum area under unitaries, histogram it

summedL=sum(leftEPSPs,4);
summedR=sum(rightEPSPs,4);
figure()
set(gcf,'Color','w')
histogram(summedL(:,1,:),30)
hold on
histogram(summedR(:,1,:),30)
rightMean=mean(mean(summedR(:,1,:)));
leftMean=mean(mean(summedL(:,1,:)));
text(6500,11,['Mean L =',num2str(leftMean)])
text(6500,10.5,['Mean R =',num2str(rightMean)])
xlabel('Area under unitary EPSPs')
ylabel('Freq')
legend({'Left PNs','Right PNs'}, 'Location', 'NorthWest')

figure()
set(gcf,'Color','w')


leftReals=squeeze(leftEPSPs(:,1,:,:));
rightReals=squeeze(rightEPSPs(:,1,:,:));

plot([0:1/40:200],squeeze(mean(mean(leftReals,2)))')
hold on
plot([0:1/40:200],squeeze(mean(mean(rightReals,2)))')
xlim([0 75])
xlabel('Time(ms)')
ylabel('Vm (mV)')
title('Mean uEPSPs')
legend({'Left PNs', 'Right PNs'})








