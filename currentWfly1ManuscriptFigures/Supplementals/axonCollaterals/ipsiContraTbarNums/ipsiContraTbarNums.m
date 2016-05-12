%The goal of this code is to generate a figure showing the number of tbars
%formed by ipsi and contra axons

%% Load annotations and connectors

% Load annotations json. Generated by Wei's code gen_annotation_map.py
annotations=loadjson('~/tracing/sid_by_annotation.json');

% Return all skeleton IDs for R and L ORNs

ORNs_Left=annotations.Left_0x20_ORN;
ORNs_Right=annotations.Right_0x20_ORN;

%exclude unilateral ORNs for now

ORNs=[ORNs_Left, ORNs_Right];

%return all skeleton IDs of DM6 PNs
PNs=sort(annotations.DM6_0x20_PN);

%% %% Load postsynaptic skeleton info


load('~/Documents/MATLAB/tracingCode2/currentWfly1ManuscriptFigures/Supplementals/axonCollaterals/ipsiContraPolyady/rightPostSkelsBySyn')
load('~/Documents/MATLAB/tracingCode2/currentWfly1ManuscriptFigures/Supplementals/axonCollaterals/ipsiContraPolyady/leftPostSkelsBySyn')



% For each ORN collect its total number of connections within each
% glomerulus as well as the total number of PN connections


leftCounter=1;
rightCounter=1;

for o=1:length(ORNs)
    
      if isempty(leftPostSkelsBySyn{o})==1
        
    else
    tbarsLeft(leftCounter)=length(leftPostSkelsBySyn{o});
    leftCounter=leftCounter+1;
    
    end
    
    if isempty(rightPostSkelsBySyn{o})==1
        
    else
    tbarsRight(rightCounter)=length(rightPostSkelsBySyn{o});
    rightCounter=rightCounter+1;
    end
    
end


%% Plotting

figure()
set(gcf, 'Color', 'w')



h=boxplot([tbarsLeft(1:27), tbarsRight(27:end),...
  tbarsLeft(28:end), tbarsRight(1:26) ]', [ones(53,1); 2*ones(51,1)], 'Color', 'k', 'notch','on');

h.LineWidth = 2;
ax=gca;
ax.XTickLabel={'Ipsi Axons','Contra Axons'};
ylabel('Total Tbars Number', 'Fontsize',16)
ylim([0 90])
ax.YTick=[0:30:90];
ax.FontSize=16;
axis square

saveas(gcf,'ipsiContraTbarNums')
saveas(gcf,'ipsiContraTbarNums','epsc')
