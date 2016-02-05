% This code relies on the products of localMini_working and
% mEPSP_ampWorking_wcl.m



%% Load annotations and connectors

% Load annotations json. Generated by Wei's code gen_annotation_map.py
annotations=loadjson('~/tracing/sid_by_annotation.json');

% Return all skeleton IDs for R and L ORNs

ORNs_Left=annotations.Left_0x20_ORN;
ORNs_Right=annotations.Right_0x20_ORN;

ORNs=[ORNs_Left, ORNs_Right];

%return all skeleton IDs of DM6 PNs
PNs=sort(annotations.DM6_0x20_PN);

% return all skel IDs with *LN* in fieldname
Fn = fieldnames(annotations);
selFn = Fn(~cellfun(@isempty,regexp(Fn,'LN')));

LNs=[];
for i = 1:numel(selFn)
    LNs=[LNs, annotations.(selFn{i})];
end

LNs = unique(LNs);

%Load the connector structure
load('~/tracing/conns.mat')

%gen conn fieldname list
connFields=fieldnames(conns);

%%


%localMinis have been measured for each synapse in the PN models
%sequentially. mEPSPs have been measued sequentially but stored in either
%leftMEPSPs or rightMEPSPs.

PN_Names={'PN1LS','PN2LS', 'PN3LS', 'PN1RS', 'PN2RS'};

%Loop over each PN
for p=1:5
    PN=PN_Names{p};
    
    %move to the PNs mini result directory
    cd(['~/nC_projects/',PN,'_allORNs/simulations/minis'])
    
    %Import the list of ORN skel IDs corresponding to each synapse, this
    %was generated during mEPSP_AmpWorking_wcl.m
    
    synIDs=importdata('ornIDs.txt');
    
    localCounter=1;
    leftCounter=1;
    rightCounter=1;
    
    for s=1:length(synIDs)
        
        if ismember(synIDs(s),ORNs_Left) == 1
            leftDecay{p}(leftCounter)=(max(leftMEPSPs{p}(leftCounter,:))+60)/(max(localMinis{p}(localCounter,:))+60);
            leftCounter=leftCounter+1;
            localCounter=localCounter+1;
            
        elseif ismember(synIDs(s),ORNs_Right) == 1
            
            rightDecay{p}(rightCounter)=(max(rightMEPSPs{p}(rightCounter,:))+60)/(max(localMinis{p}(localCounter,:))+60);
            rightCounter=rightCounter+1;
            localCounter=localCounter+1;
            
        end
        
        localMiniAmps{p}(s)=max(localMinis{p}(s,:))+60;
        
    end
    

    
end



lDecay=[leftDecay{1},rightDecay{1},leftDecay{2},rightDecay{2},leftDecay{3},rightDecay{3}];
rDecay=[leftDecay{4},rightDecay{4},leftDecay{5},rightDecay{5}];

gpsU = [ones(size(lDecay)),2.*ones(size(rDecay))];
valsU = [lDecay,rDecay];
[YUmean,YUsem,YUstd,YUci] = grpstats(valsU,gpsU,{'mean','sem','std','meanci'});


%% Simple bar plot Left-Right PN mEPSP decay
%Ipsi and contra broken out

%move to the figure directory to save the plot
cd('~/Documents/MATLAB/tracingCode2/wfly1_Manuscript/Figure3/')

figure
set(gcf,'Color', 'w')
bar(YUmean,.4,'FaceColor','k','LineWidth',2)
hold on
he = errorbar(YUmean,YUsem,'k','LineStyle','none'); % error bars are std
he.LineWidth=1;
xlim([0.5 2.5])
% ylim([0 80])
ax = gca;
ax.XTick = [1 2];
ax.XTickLabel = {'Left';'Right'};
ax.FontSize=16;
ylabel('mEPSP fractional decay')
axis square
saveas(gcf,'mEPSPDecay','epsc')




