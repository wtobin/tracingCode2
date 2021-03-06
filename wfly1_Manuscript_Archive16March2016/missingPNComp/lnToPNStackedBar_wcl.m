%% A. stacked bar chart showing number of presumptive LN synapses
%(unidentified profiles) onto left PNs (left bar, divided into three parts)
%and right PNs (right bar, divided into two parts)

% load('~/Dropbox/htem_team/code/wtobin/tracingCode2/wfly1_Manuscript/Figure1/lnToPn.mat');
load('~/Documents/MATLAB/tracingCode2/wfly1_Manuscript/lnToPn.mat')

lnToRPN(1)=sum(lnToPn(:,3));
lnToRPN(2)=sum(lnToPn(:,4));
lnToRPN(3)=0;

lnToLPN(1)=sum(lnToPn(:,5));
lnToLPN(2)=sum(lnToPn(:,1));
lnToLPN(3)=sum(lnToPn(:,2));

figure()
bar([lnToLPN; lnToRPN],.7, 'stacked')
set(gcf, 'Color', 'w')
colormap('winter')
ax=gca;
xlim([0 3]);
ax.XTick=[1:2];
ax.XTickLabel={'Left PNs', 'Right PNs'};
ax.FontSize=16;
ylabel('MG-->PN Contact Num', 'FontSize', 16);
% title('MG Inputs to PNs', 'FontSize', 16);
axis square
saveas(gcf,'figure3PanelC')
saveas(gcf,'figure3PanelC','epsc')


%% Now collect all inputs to PNs that are not ORNs or other PNs

%Load annotations and connectors

% Load annotations json. Generated by Wei's code gen_annotation_map.py
annotations=loadjson('~/Dropbox/htem_team/analysis/wfly1/tracing/sid_by_annotation.json');

% Return all skeleton IDs for R and L ORNs

ORNs_Left=annotations.Left_0x20_ORN;
ORNs_Right=annotations.Right_0x20_ORN;

%exclude unilateral ORNs for now

ORNs_Right(find(ORNs_Right == 499879))=[];
% ORNs_Left(find(ORNs_Left == 426230))=[];
ORNs_Left(find(ORNs_Left == 401378))=[];
% 
% %exclude ORN 8 because it was temporarily unilateral on 8/5 for testing 
% ORNs_Left(find(ORNs_Left == 593865))=[];

ORNs=[ORNs_Left, ORNs_Right];

%return all skeleton IDs of DM6 PNs
% PNs=annotations.PN;
PNs=sort(annotations.DM6_0x20_PN);

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
load('~/Dropbox/htem_team/analysis/wfly1/tracing/conns.mat')

%gen conn fieldname list
connFields=fieldnames(conns);

%% Collect a list of presynaptic profile skeleton IDs for each PN WITH duplicates

%Loop over all PNs
for p=1:numel(PNs)
    
preSkel{p}=[];

%loop over all connectors
for i= 1 : length(connFields)
    
   %Make sure the connector doesnt have an empty presynaptic field
    if isempty(conns.(cell2mat(connFields(i))).pre) == 1 
        
   %or an empty postsynaptic field, if its empty it will be a cell
    elseif iscell(conns.(cell2mat(connFields(i))).post) == 1
        
    else
        
        %Check to see if the current PN is postsynaptic at this connector
        if sum(ismember(PNs(p), conns.(cell2mat(connFields(i))).post))>=1
            
            %record the presynaptic skel ID once for each time the PN is
            %postsynaptic
            
            for s=1:length(conns.(cell2mat(connFields(i))).post)
                
                if conns.(cell2mat(connFields(i))).post(s) == PNs(p)
                    
                    preSkel{p}=[preSkel{p}, conns.(cell2mat(connFields(i))).pre];
                    
                else
                end
            end
           
                
          
        else
        end
    end
end



end

%% Categorize presynaptic profiles

% Question, how many profiles can be accounted for as ORNs, PNs and LNs?


% Loop over each PN
for p=1:length(PNs)
    
    
    %loop over each presynaptic profile
for s=1:length(preSkel{p})
    
     if ismember(preSkel{p}(s), ORNs) == 1
                
                preSynID{p}(s)=1;
                
                
            elseif ismember(preSkel{p}(s), PNs) == 1
                
                 preSynID{p}(s)=2;
                
                
            elseif ismember(preSkel{p}(s), LNs) == 1
                
                 preSynID{p}(s)=3;
                
                
            else
                 preSynID{p}(s)=3;
                
     end
    
end
end


otherToRPN(1)=sum(preSynID{3}==3);
otherToRPN(2)=sum(preSynID{4}==3);
otherToRPN(3)=0;

otherToLPN(1)=sum(preSynID{5}==3);
otherToLPN(2)=sum(preSynID{1}==3);
otherToLPN(3)=sum(preSynID{2}==3);

figure()
bar([otherToLPN; otherToRPN], 'stacked')
set(gcf, 'Color', 'w')
colormap('winter')
ax=gca;
xlim([0 3]);
ax.XTick=[1:2];
ax.XTickLabel={'Left PNs', 'Right PNs'};
ax.FontSize=16;
ylabel('Num Connections', 'FontSize', 16);
title('LN+Unclassified Inputs to PNs', 'FontSize', 16);


allToRPN(1)=numel(preSynID{3});
allToRPN(2)=numel(preSynID{4});
allToRPN(3)=0;

allToLPN(1)=numel(preSynID{5});
allToLPN(2)=numel(preSynID{1});
allToLPN(3)=numel(preSynID{2});

figure()
bar([allToLPN; allToRPN], 'stacked')
set(gcf, 'Color', 'w')
colormap('winter')
ax=gca;
xlim([0 3]);
ax.XTick=[1:2];
ax.XTickLabel={'Left PNs', 'Right PNs'};
ax.FontSize=16;
ylabel('Num Connections', 'FontSize', 16);
title('Total Inputs to PNs', 'FontSize', 16);


% I want to make a stacked bar graph of number of non-ORN inputs to each PN


nonORNToRPN(1)=sum(preSynID{3}~=1);
nonORNToRPN(2)=sum(preSynID{4}~=1);
nonORNToRPN(3)=0;

nonORNToLPN(1)=sum(preSynID{5}~=1);
nonORNToLPN(2)=sum(preSynID{1}~=1);
nonORNToLPN(3)=sum(preSynID{2}~=1);

figure()
bar([nonORNToLPN; nonORNToRPN], 'stacked')
set(gcf, 'Color', 'w')
colormap('winter')
ax=gca;
xlim([0 3]);
ax.XTick=[1:2];
ax.XTickLabel={'Left PNs', 'Right PNs'};
ax.FontSize=16;
ylabel('Num Connections', 'FontSize', 16);
title('Non-ORN Inputs to PNs', 'FontSize', 16);




