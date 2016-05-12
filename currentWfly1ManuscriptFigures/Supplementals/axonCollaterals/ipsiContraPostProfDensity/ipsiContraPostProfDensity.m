%The goal of this code is to generate a figure showing mean connection density 
% for ipsi and contra output synapses

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

%% Load the axon lengths

%Load the axon length and presynaptic site number data
load('~/Documents/MATLAB/tracingCode2/currentWfly1ManuscriptFigures/Supplementals/ornOutputSynDensity/leftAxons')
load('~/Documents/MATLAB/tracingCode2/currentWfly1ManuscriptFigures/Supplementals/ornOutputSynDensity/rightAxons')


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


%% Collect conn nums 

load('~/Documents/MATLAB/tracingCode2/currentWfly1ManuscriptFigures/Supplementals/ornPostsynOrphans/rightPostSkels.mat')
load('~/Documents/MATLAB/tracingCode2/currentWfly1ManuscriptFigures/Supplementals/ornPostsynOrphans/leftPostSkels.mat')


% Loop over each ORN

counter=1;
for p=1:length(ORNs)
    
    if isempty(leftPostSkels{p})
        
    else
        
      numPostProfL(counter)=numel(leftPostSkels{p});
      counter=counter+1;
      
    end
end

counter=1;
for p=1:length(ORNs)
    
    if isempty(rightPostSkels{p})
        
    else
      numPostProfR(counter)=numel(rightPostSkels{p});
      counter=counter+1;
    end
end


%% Collect conn nums 

load('~/Documents/MATLAB/tracingCode2/currentWfly1ManuscriptFigures/Supplementals/ornPostsynOrphans/rightPostSkels.mat')
load('~/Documents/MATLAB/tracingCode2/currentWfly1ManuscriptFigures/Supplementals/ornPostsynOrphans/leftPostSkels.mat')


% Loop over each ORN

counter=1;
for p=1:length(ORNs)
    
    if isempty(leftPostSkels{p})
        
    else
        
      numPostProfL(counter)=numel(leftPostSkels{p});
      counter=counter+1;
      
    end
end

counter=1;
for p=1:length(ORNs)
    
    if isempty(rightPostSkels{p})
        
    else
      numPostProfR(counter)=numel(rightPostSkels{p});
      counter=counter+1;
    end
end



%% Plotting

figure()
set(gcf, 'Color', 'w')

%Check this result, boxplot changed and I am not sure why

h=boxplot([numPostProfL(1:27)./leftLengths(1:27),numPostProfR(27:end)./rightLengths(27:end),...
  numPostProfL(28:end)./leftLengths(28:end),numPostProfR(1:26)./rightLengths(1:26) ]', [ones(53,1); 2*ones(51,1)], 'Color', 'k', 'notch','on');

h.LineWidth = 2;
ax=gca;
ax.XTickLabel={'ipsi axons','contra axons'};
ylabel('postsynaptic profiles per nm', 'Fontsize',16)
ylim([0 2*10^-3])
ax.YTick=[0:1*10^-3:2*10^-3];
ax.FontSize=16;
axis square

saveas(gcf,'ipsiContraPostProfDensity')
saveas(gcf,'ipsiContraPostProfDensity','epsc')

