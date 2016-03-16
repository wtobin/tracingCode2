
figure()
ornIDsL=unique(leftIDs);


for i=1:length(ornIDsL)
    
    
    scatter(i*ones(1,sum(leftIDs==ornIDsL(i))),max(leftmEPSPs{1}(find(leftIDs==ornIDsL(i)),:)')-mean(leftmEPSPs{1}(find(leftIDs==ornIDsL(i)),1:39)'), 'b')
    hold on
    
end
    

ornIDsR=unique(rightIDs);
ornIDsL

for i=1:length(ornIDsR)
    
    
    scatter((i+length(ornIDsL))*ones(1,sum(rightIDs==ornIDsR(i))),max(rightmEPSPs{1}(find(rightIDs==ornIDsR(i)),:)')-mean(rightmEPSPs{1}(find(rightIDs==ornIDsR(i)),1:39)'), 'r')
    hold on
    
end

set(gcf, 'Color', 'w')
xlabel('ORNs')
ylabel('miniature EPSP Amp (mV)')
    