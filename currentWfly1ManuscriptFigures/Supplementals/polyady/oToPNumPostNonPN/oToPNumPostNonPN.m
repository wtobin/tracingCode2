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


%% Count the number of postsynaptic PN profiles at each ORN-PN synapse

numPostNonPN=[];


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
            
            
            numPostNonPN=[numPostNonPN,numel(post)-sum(ismember(post,PNs))];
                
            
            
        else
        end
        
    end
    
    
    
end

%%

figure('units','normalized','outerposition',[0 0 1 1])
set(gcf,'Color','w')
set(gcf,'renderer','painters');

h=histogram(numPostNonPN);

box off
ylabel('T-bar Counts')
xlabel('# Postsynaptic Non-PN Profiles')
%legend({'Left Glomerulus','Right Glomerulus'})
ylim([0 2000])
xlim([-2 13])
set(gca,'FontSize',18)
set(gca,'TickDir','out')
axis square

saveas(gcf,'oToPNumPostNonPN','epsc')
saveas(gcf,'oToPNumPostNonPN')
