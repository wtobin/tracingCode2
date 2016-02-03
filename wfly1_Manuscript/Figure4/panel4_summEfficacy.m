% the purpose of this script is to generate a plot of uEPSP amp vs. uEPSP Amp/sum(mEPSP amps)
%  for all 5 PNs. It relies on the uEPSP_AmpWorking and
% mEPSP_AmpWorking


figure()
set(gcf, 'color', 'w')

% Loop over each PN

for p=1:5
    
    % For left ORN inputs 
    
    for o=1:length(ORNs_Left)
        
        ampArray(p,o,1)=max(leftUEPSPs{p}(o,:)+59.4);

        ampArray(p,o,2)=sum(max(leftMEPSPs{p}(find(leftMEPSPs_idList{p}==leftUEPSPs_idList{1}(o)),:)')+59.4);

    end
   
    
    for o=1:length(ORNs_Right)
        
        ampArray(p,o+length(ORNs_Left),1)=max(rightUEPSPs{p}(o,:))-mean(rightUEPSPs{p}(o,1:40));
        
        ampArray(p,o+length(ORNs_Left),2)=(max(rightUEPSPs{p}(o,:))-mean(rightUEPSPs{p}(o,1:40)))/sum(max(rightMEPSPs{p}(find(rightMEPSPs_idList{p}==o),:)')...
            -mean(rightMEPSPs{p}(find(rightMEPSPs_idList{p}==o),1:40)'));
        
    end
    
    
scatter(ampArray(p,:,1),ampArray(p,:,2), 'filled')
hold on

clear ampArray
    
end



xlabel('uEPSP Amp (mV)', 'FontSize',18)
ylabel('sum mEPSP Amp (mV)', 'FontSize',18)
legend({'PN1 LS', 'PN2 LS', 'PN3 LS', 'PN1 RS', 'PN2 RS'}, 'Location', 'NorthWest')

refline(1,0)

