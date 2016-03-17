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

% for o=1:length(ORNs_Left)
%     
%     
%     for p=1:length(PNs)
%     
%     contactNum(o,p)=leftContactNum{p}(o);
%     
%     end
%     
%     
% end
%     
% 
% for o=1:length(ORNs_Right)
%     
%     for p=1:length(PNs)
%     
%     contactNum(o+length(ORNs_Left),p)=rightContactNum{p}(o);
%     
%     end
%     
% end
%    


%% Load annotations and connectors

% Load annotations json. Generated by Wei's code gen_annotation_map.py
annotations=loadjson('~/tracing/sid_by_annotation.json');

% Return all skeleton IDs for R and L ORNs

ORNs_Left=annotations.Left_0x20_ORN;
ORNs_Right=annotations.Right_0x20_ORN;

ORNs=[ORNs_Left, ORNs_Right];

%return all skeleton IDs of DM6 PNs
% PNs=annotations.PN;
PNs=sort(annotations.DM6_0x20_PN);
% PNs=annotations.DM6_0x20_PN;

% return all skel IDs with *LN* in fieldname
Fn = fieldnames(annotations);
selFn = Fn(~cellfun(@isempty,regexp(Fn,'LN')));

LNs=[];
for i = 1:numel(selFn)
    LNs=[LNs, annotations.(selFn{i})];
end

LNs = unique(LNs);

%
% LNs=annotations.LN;
% LNs=[LNs, annotations.potential_0x20_LN];
% LNs=[LNs, annotations.Prospective_0x20_LN];
% LNs=[LNs, annotations.Likely_0x20_LN];


%Load the connector structure
load('~/tracing/conns.mat')

%gen conn fieldname list
connFields=fieldnames(conns);

%%


%Load ornToPn contact Num matrix
load('~/Documents/MATLAB/tracingCode2/wfly1_Manuscript/ornToPn.mat');
    

% Now divide each element by the sum of the column it is in

for c=1:5
    
    contactNum_Fract(:,c)=ornToPn(:,c)./sum(ornToPn(:,c));
    
end



%vsort rows from lowest to highest 
% mean ipsilateral percentage (averaged across all ipsilateral PNs)

[v i]=sort(mean(contactNum_Fract(1:length(ORNs_Left),[1,2,5])'));

sorted_ContNumFracts(1:length(ORNs_Left),:)=contactNum_Fract(i,[1,2,5,4,3]);


[v2 i2]=sort(mean(contactNum_Fract(length(ORNs_Left)+1:end,[3,4])'));

sorted_ContNumFracts(length(ORNs_Left)+1:length(ORNs_Left)+length(ORNs_Right),:)=contactNum_Fract(i2+length(ORNs_Left),[1,2,5,4,3]);
    
%% Plotting

figure()
set(gcf, 'Color', 'w')

imagesc(sorted_ContNumFracts(28:end,1:3), [.006 .035])
colorbar()
xlabel('Left PNs', 'FontSize',18)
ylabel('Right ORNs', 'FontSize',18)

saveas(gcf,'fractionalInputHeatmap_4','epsc')
saveas(gcf,'fractionalInputHeatmap_4')
 
 
 %% Plotting 2
 
figure()
set(gcf, 'Color', 'w')



scatter(mean(sorted_ContNumFracts(1:27,[1:3]),2),mean(sorted_ContNumFracts(1:27,[4:5]),2), 'filled')
hold on
scatter(mean(sorted_ContNumFracts(28:end,[1:3]),2),mean(sorted_ContNumFracts(28:end,[4:5]),2),'r', 'filled')

legend({'Left ORNs','Right ORNs'})

ax=gca;
ax.XLim=[0 .04];
ax.YLim=[0 .04];
xlabel('Mean Fractional Input to Left PNs');
ylabel('Mean Fractional Input to Right PNs');
saveas(gcf,'fractionalInputScatter','epsc')
saveas(gcf,'fractionalInputScatter')


ipsi=[mean(sorted_ContNumFracts(1:27,[1:3]),2);mean(sorted_ContNumFracts(28:end,[4:5]),2)]
contra=[mean(sorted_ContNumFracts(1:27,[4:5]),2);mean(sorted_ContNumFracts(28:end,[1:3]),2)]
 