% The purpose of this code is to generate a two bar bar graph of mean local
% mEPSP amplitude for right and left PNs



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

%% For this code to run you must first run pullmEPSPs

%load the local mini matrix
load('~/nC_projects/localMinis.mat')

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

%% L v R local mEPSP amplitude

lAmp=[localMiniAmps{1},localMiniAmps{2},localMiniAmps{3}];
rAmp=[localMiniAmps{4},localMiniAmps{5}];

gpsU = [ones(size(lAmp)),2.*ones(size(rAmp))];
valsU = [lAmp,rAmp];
[YUmean,YUsem,YUstd,YUci] = grpstats(valsU,gpsU,{'mean','sem','std','meanci'});


%% Simple bar plot Left-Right PN mEPSP decay
%Ipsi and contra broken out

%move to the figure directory to save the plot
cd('~/Documents/MATLAB/tracingCode2/currentWfly1ManuscriptFigures/leftRightMinisAndUnitaries/localMinis/')

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
ax.XTickLabel = {'Left PNs';'RightPNs'};
ax.FontSize=16;
ylabel('Local mEPSP Amp (mV)')
axis square
saveas(gcf,'meanmEPSPAmpLvR')
saveas(gcf,'meanmEPSPAmpLvR','epsc')



