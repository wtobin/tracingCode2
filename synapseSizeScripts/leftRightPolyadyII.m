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

numPostElL=[];
numPNsL=[];


numPostElR=[];
numPNsR=[];



for c = 1:length(connFields)
    
    curConnID=cell2mat(connFields(c));
    
    %Make sure the connector doesnt have an empty presynaptic field
    if isempty(conns.(curConnID).pre) == 1
        
        %or an empty postsynaptic field, if its empty it will be a cell
    elseif iscell(conns.(curConnID).post) == 1
        
    else
        
        pre=conns.(curConnID).pre;
        post=conns.(curConnID).post;
        
        if ismember(pre,ORNs)==1 && sum(ismember(post,PNs))>0
            
            if ismember(max(find(ismember(PNs, post))),[1,2,5]) == 1
                
                numPostElL=[numPostElL,numel(post)];
                numPNsL=[numPNsL,sum(ismember(post,PNs))];
                
            else
                
                numPostElR=[numPostElR,numel(post)];
                numPNsR=[numPNsR,sum(ismember(post,PNs))];
                
            end
        else
        end
    end
    
    
    
end


%% Plotting

figure()
set(gcf,'color','w')
h1=histogram(numPostElL,'Normalization','probability');
hold on 
histogram(numPostElR,h1.BinEdges,'Normalization','probability')
legend({'Left','Right'})
xlabel('Number of Postsynaptic Profiles')
ylabel('Prob Normalized Freq')
set(gca,'FontSize',18)

grpdForBoxplot=[[numPostElL',zeros(size(numPostElL,2),1)];...
    [numPostElR',ones(size(numPostElR,2),1)]];

figure()
set(gcf,'color','w')
boxplot(grpdForBoxplot(:,1),grpdForBoxplot(:,2),'Labels',...
    {'Left Syns','Right Syns'},'Notch','on')

ylabel('Number of Postsynaptic Profiles')
set(gca,'FontSize',18)


figure()
set(gcf,'color','w')
h2=histogram((numPNsL./numPostElL),'Normalization','probability');
hold on 
histogram((numPNsR./numPostElR),h2.BinEdges,'Normalization','probability')
legend({'Left Syns','Right Syns'})
xlabel('Fraction of Post Profiles That are PNs')
ylabel('Prob Normalized Freq')
set(gca,'FontSize',18)

grpdForBoxplo2t=[[(numPNsL./numPostElL)',zeros(size(numPostElL,2),1)];...
    [(numPNsR./numPostElR)',ones(size(numPostElR,2),1)]];


figure()
set(gcf,'color','w')
boxplot(grpdForBoxplot2(:,1),grpdForBoxplot2(:,2),'Labels',...
    {'Left Syns','Right Syns'},'Notch','on')

ylabel('Fract of Postsynaptic Profiles That are PNs')
set(gca,'FontSize',18)









