%% Panel 1 Contact num as fract of total heatmap


% This code relies on the products of uEPSP_AmpWorking which should be found in Fig 2 dir


% square category plot (51 ORN rows versus 5 PN columns) showing the percentage
% contribution of each ORN to a PN?s total ORN synapses (percentages in colorscale);
% keep the 3 L PNs together on the left and the two R PNs together on the right;
% arrange all L ORNs at the top half and all R ORNs at the bottom half; 
% then within the top and bottom halves, sort rows from lowest to highest 
% mean ipsilateral percentage (averaged across all ipsilateral PNs) 
% (for each group of ipsilateral PNs,  test of there is a significant correlation
% by doing PCA [you should get 51 PCs, I think] and asking if the 
% eigenvalue associated with PC1 is larger than when you get 95% of the time 
% when you independently shuffle the ORN labels on each PN?s synapses before doing PCA)

% Collect contact nums in a matrix with ORNs as rows and PNs as columns.
% Left ORNs will occupy the top of the matrix, right orns the bottom. Left
% PNs will occupy the left columns and right PNs the right

for o=1:length(ORNs_Left)
    
    for p=1:length(PNs)
    
    contactNum(o,p)=leftContactNum{p}(o);
    
    end
    
end
    

for o=1:length(ORNs_Right)
    
    for p=1:length(PNs)
    
    contactNum(o+length(ORNs_Left),p)=rightContactNum{p}(o);
    
    end
    
end
    
    

% Now divide each element by the sum of the column it is in

for c=1:5
    
    contactNum_Fract(:,c)=contactNum(:,c)./sum(contactNum(:,c));
    
end



%vsort rows from lowest to highest 
% mean ipsilateral percentage (averaged across all ipsilateral PNs)

[v i]=sort(mean(contactNum_Fract(1:length(ORNs_Left),[1:3])'));

sorted_ContNumFracts(1:length(ORNs_Left),:)=contactNum_Fract(i,:);


[v2 i2]=sort(mean(contactNum_Fract(length(ORNs_Left)+1:end,[4,5])'));

sorted_ContNumFracts(length(ORNs_Left)+1:length(ORNs_Left)+length(ORNs_Right),:)=contactNum_Fract(i2+length(ORNs_Left),:);
    
%% Plotting


figure()
set(gcf, 'Color', 'w')

imagesc(sorted_ContNumFracts, [.006 .035])
colorbar()
xlabel('PNs', 'FontSize',18)
ylabel('ORNs', 'FontSize',18)
title('Heatmap of ORN-->PN contact num as fract of tot ','Fontsize', 20)

