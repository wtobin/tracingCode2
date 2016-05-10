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

%% Calculate Path length

load('~/Documents/MATLAB/tracingCode2/currentWfly1ManuscriptFigures/Supplamentals/ornOutputSynDensity/leftAxons')
load('~/Documents/MATLAB/tracingCode2/currentWfly1ManuscriptFigures/Supplamentals/ornOutputSynDensity/rightAxons')

% For each ORN calculate its total within glomerulus axon lengths
leftCounter=1;
rightCounter=1;

for p=1:length(ORNs)
    
    leftRunL=[];
    leftRunPS=[];
    
    
    for j=1:size(leftAxons{p},2)
        
        leftRunL=[leftRunL, leftAxons{p}(1,j)];
        leftRunPS=[leftRunPS,leftAxons{p}(2,j)];
        
    end
    
    if isnan(leftRunPS)==1
        
    else
        
        leftLengths(leftCounter)=sum(leftRunL);
        leftPreSites(leftCounter)=sum(leftRunPS);
        leftCounter=leftCounter+1;
        
    end
    
    rightRunL=[];
    rightRunPS=[];
    
    
    for j=1:size(rightAxons{p},2)
        
        rightRunL=[rightRunL, rightAxons{p}(1,j)];
        rightRunPS=[rightRunPS,rightAxons{p}(2,j)];
        
    end
    
    if isnan(rightRunPS)==1
    else
        
        rightLengths(rightCounter)=sum(rightRunL);
        rightPreSites(rightCounter)=sum(rightRunPS);
        rightCounter=rightCounter+1;
    end
end



%% create array of length and Density for ipsi and Contra axons


ipsiLenDens(:,1)=[leftLengths(1:27),rightLengths(27:end)];
ipsiLenDens(:,2)=[leftPreSites(1:27)./leftLengths(1:27),rightPreSites(27:end)./rightLengths(27:end)];

contraLenDens(:,1)=[leftLengths(28:end),rightLengths(1:26)];
contraLenDens(:,2)=[leftPreSites(28:end)./leftLengths(28:end),rightPreSites(1:26)./rightLengths(1:26)];

%% Plotting
figure()

set(gcf,'Color','w')
boxplot([ipsiLenDens(:,1);contraLenDens(:,1)], [ones(53,1);2*ones(51,1)], 'color', 'k')
ax=gca;
ax.XTickLabel={'ipsi axons','contra axons'};
ax.FontSize=16;
ylabel('cable length(nm)','FontSize',16);
axis square
saveas(gcf,'ipsiContraLength')
saveas(gcf,'ipsiContraLength','png')


figure()
set(gcf,'Color','w')
boxplot([ipsiLenDens(:,2);contraLenDens(:,2)], [ones(53,1);2*ones(51,1)],'color', 'k')
ax=gca;
ax.XTickLabel={'ipsi axons','contra axons'};
ylabel('tbar density (tbars/nm)', 'FontSize',16);
axis square
ax.FontSize=16;
saveas(gcf,'ipsiContraDens')
saveas(gcf,'ipsiContraDens','png')
