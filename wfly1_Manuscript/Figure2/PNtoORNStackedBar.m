%% stacked bar chart showing number of PN synapses onto ORNs for left PNs
% (left bar, divided into three parts) and right PNs (right bar, divided into two parts)


%Load PN-->ORN connectivity data, generated by file panel6_unitaryContNums
%in Figure 1 directory

load('~/Documents/MATLAB/tracingCode2/wfly1_Manuscript/pnToOrn.mat')

leftPNToORN=[sum(pnToOrn(5,:)),sum(pnToOrn(1,:)),sum(pnToOrn(2,:))];

rightORNToPN=[sum(pnToOrn(3,:)),sum(pnToOrn(4,:)),0];


figure()
bar([leftPNToORN; rightORNToPN], 'stacked')
set(gcf, 'Color', 'w')
colormap('winter')
ax=gca;
xlim([0 3]);
ax.XTick=[1:2];
ax.XTickLabel={'Left PNs', 'Right PNs'};
ax.FontSize=16;
ylabel('PN-->ORN Contact Num', 'FontSize', 16);


load('~/Documents/MATLAB/tracingCode2/wfly1_Manuscript/pnToPn.mat')

leftPNToPN=[sum(pnToPn(5,:)),sum(pnToPn(1,:)),sum(pnToPn(2,:))];

rightPNToPN=[sum(pnToPn(3,:)),sum(pnToPn(4,:)),0];


figure()
bar([leftPNToPN; rightPNToPN], 'stacked')
set(gcf, 'Color', 'w')
colormap('winter')
ax=gca;
xlim([0 3]);
ax.XTick=[1:2];
ax.XTickLabel={'Left PNs', 'Right PNs'};
ax.FontSize=16;
ylabel('PN-->PN Contact Num', 'FontSize', 16);


load('~/Documents/MATLAB/tracingCode2/wfly1_Manuscript/lnToPn.mat')

leftPNToPN=[sum(pnToPn(5,:)),sum(pnToPn(1,:)),sum(pnToPn(2,:))];

rightPNToPN=[sum(pnToPn(3,:)),sum(pnToPn(4,:)),0];


figure()
bar([leftPNToPN; rightPNToPN], 'stacked')
set(gcf, 'Color', 'w')
colormap('winter')
ax=gca;
xlim([0 3]);
ax.XTick=[1:2];
ax.XTickLabel={'Left PNs', 'Right PNs'};
ax.FontSize=16;
ylabel('PN-->PN Contact Num', 'FontSize', 16);

%% I would also like to look at the overall number of outputs each PN makes
%% Load annotations and connectors

% Load annotations json. Generated by Wei's code gen_annotation_map.py
annotations=loadjson('~/tracing/sid_by_annotation.json');

% Return all skeleton IDs for R and L ORNs

ORNs_Left=annotations.Left_0x20_ORN;
ORNs_Right=annotations.Right_0x20_ORN;

%exclude unilateral ORNs for now

ORNs_Right(find(ORNs_Right == 499879))=[];
ORNs_Left(find(ORNs_Left == 426230))=[];
ORNs_Left(find(ORNs_Left == 401378))=[];
% 
% %exclude ORN 8 because it was temporarily unilateral on 8/5 for testing 
% ORNs_Left(find(ORNs_Left == 593865))=[];

ORNs=[ORNs_Left, ORNs_Right];

%return all skeleton IDs of DM6 PNs
PNs=annotations.PN;

%return all LN skel IDs
LNs=annotations.LN;
LNs=[LNs, annotations.potential_0x20_LN];
LNs=[LNs, annotations.Prospective_0x20_LN];
LNs=[LNs, annotations.Likely_0x20_LN];


%Load the connector structure
load('~/tracing/conns.mat')

%gen conn fieldname list
connFields=fieldnames(conns);


%Loop over all PNs
for p=1:numel(PNs)
    
presynCounter=1;

%loop over all connectors
for i= 1 : length(connFields)
    
   %Make sure the connector doesnt have an empty presynaptic field
    if isempty(conns.(cell2mat(connFields(i))).pre) == 1 
        
   %or an empty postsynaptic field, if its empty it will be a cell
    elseif iscell(conns.(cell2mat(connFields(i))).post) == 1
        
    else
        
        %Check to see if the current PN is presynaptic at this connector
        if sum(ismember(PNs(p), conns.(cell2mat(connFields(i))).pre))>=1
            presynCounter=presynCounter+1;
           
                
          
        else
        end
    end
end

numOut(p)=presynCounter;

end



figure()
bar([numOut([5,1,2]);  [numOut([3,4]),0]], 'stacked')
set(gcf, 'Color', 'w')
colormap('winter')
ax=gca;
xlim([0 3]);
ax.XTick=[1:2];
ax.XTickLabel={'Left PNs', 'Right PNs'};
ax.FontSize=16;
ylabel('Presynaptic sites', 'FontSize', 16);
title('Overall number of PN presynaptic sites', 'FontSize', 16)