%% Panel 1 uEPSP heatmap


% This code relies on the products of uEPSP_AmpWorking which should be found in Fig 2 dir


% For Left ORNs
for l=1:length(ORNs_Left)
    
    %loop over PNs
    for p=1:4
        
        uEPSP_Amps(l,p)=max(leftUEPSPs{p}(l,:))-mean(leftUEPSPs{p}(l,1:100));
        
    end
    
end


%For the R ORNs
for r=1:length(ORNs_Right)
    
    %loop over PNs
    for p=1:4
        
        uEPSP_Amps(r+length(ORNs_Left),p)=max(rightUEPSPs{p}(r,:))-mean(rightUEPSPs{p}(r,1:100));
        
    end
    
end


% 
% %Now I want to normalize each unitary by the mean unitary amp over all ORNs
% %from the same hemisphere in each PN
% 
% for c=1:4
%     
%     normUEPSP(1:length(ORNs_Left),c)=uEPSP_Amps(1:length(ORNs_Left),c)./...
%     max(uEPSP_Amps(1:length(ORNs_Left),c));
%     
%     normUEPSP(length(ORNs_Left)+1:length(ORNs_Left)+length(ORNs_Right),c)=...
%         uEPSP_Amps(length(ORNs_Left)+1:end,c)./ max(uEPSP_Amps(length(ORNs_Left)+1:end,c));
%     
% end

%Normalize by each PNs mean uEPSP Amp
 for c=1:4
    
    normUEPSP(:,c)=uEPSP_Amps(:,c)./mean(uEPSP_Amps(:,c));
   
    
end


% sort rows from lowest to highest 
% mean ipsilateral percentage (averaged across all ipsilateral PNs)

[v i]=sort(mean(normUEPSP(1:length(ORNs_Left),[1:3])'));

sorted_uEPSPAmps(1:length(ORNs_Left),:)=normUEPSP(i,:);

% NOTE: Currently only for PN1 RS!!

[v2 i2]=sort(normUEPSP(length(ORNs_Left)+1:end,4));

sorted_uEPSPAmps(length(ORNs_Left)+1:length(ORNs_Left)+length(ORNs_Right),:)=normUEPSP(i2+length(ORNs_Left),:);
    


figure()
set(gcf, 'Color', 'w')

imagesc(sorted_uEPSPAmps, [.4 1.6])
colorbar()
xlabel('PNs', 'FontSize',18)
ylabel('ORNs', 'FontSize',18)
title('Heatmap of ORN-->PN uEPSP Amp','Fontsize', 20)

