% The goal here is to generate a pie chart of input profile identity for
% PNs

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

%% Collect a list of postsynaptic profile skeleton IDs for each PN

%Loop over all PNs

for p=1:length(PNs)
    
    postSkel{p}=[];
    
    %loop over all connectors
    for i= 1 : length(connFields)
        
        %Make sure the connector doesnt have an empty presynaptic field
        if isempty(conns.(cell2mat(connFields(i))).pre) == 1
            
            % or an empty postsynaptic field, if its empty it will be a cell
            
        elseif iscell(conns.(cell2mat(connFields(i))).post) == 1
            
        else
            
            %Check to see if the current PN is presynaptic at this connector
            if PNs(p) == conns.(cell2mat(connFields(i))).pre
                
                %record the postsynaptic skel IDs
                postSkel{p}=[postSkel{p}, conns.(cell2mat(connFields(i))).post];
                
            else
                
                
            end

        end
    end
end




%% This block of code is written to see how many PN postsynaptic profiles have at least one annotation

annFields=fieldnames(annotations);

annSkels=[];

for a=1: length(annFields)
    annSkels=[annSkels, annotations.(cell2mat(annFields(a)))];
end

for p=1:5
    
    for s=1:length(postSkel{p})
       annCheck{p}(s)=ismember(postSkel{p}(s), annSkels);
    end
    
    fractAnn(p)=sum(annCheck{p})/length(postSkel{p})
end



%% Categorize presynaptic profiles

% Question, how many profiles can be accounted for as ORNs, PNs and LNs?


% Loop over each PN
for p=1:length(PNs)
    
    
    %loop over each presynaptic profile
    for s=1:length(postSkel{p})
        
        if ismember(postSkel{p}(s), ORNs) == 1
            
            postSynID{p}(s)=1;
            
            
        elseif ismember(postSkel{p}(s), PNs) == 1
            
            postSynID{p}(s)=2;
            
            
        elseif ismember(postSkel{p}(s), LNs) == 1
            
            postSynID{p}(s)=3;
            
            
        else
            postSynID{p}(s)=3;%4;
            
        end
        
    end
end


%% Plotting


%Tally up the identifications


%For each PN
for p=1:length(PNs)
    
    %for each category
    for id=1:3%4
        
        idenCounts(p,id)=sum(postSynID{p}==id);
        
    end
    
end

[v i]=sort(sum(idenCounts), 'descend');

labels={'ORN','PN','Multi-glomerular'};
order=[5,1,2,3,4];  
pnLabels={'PN1 LS', 'PN2 LS', 'PN3 LS', 'PN1 RS','PN2 RS'};

%Raw Numbers
figure()
bar(idenCounts(order,i),'stacked');
legend(labels(i),'Location', 'NorthWest')
ax=gca;
ax.XTickLabel=pnLabels;
ax.FontSize=18;
set(gcf,'color','w')
ylabel('Postsynaptic Profile Num')


%Fractions

%Normalize the postynaptic identity counts by tot number of postsynaptic
%profiles

for t=1:length(PNs)
    normIden(t,:)=idenCounts(order(t),i)./sum(idenCounts(order(t),i));
end

figure()

bar(normIden,'stacked');
legend(labels(i),'Location', 'NorthWest')
ax=gca;
ax.XTickLabel=pnLabels;
ax.FontSize=18;
ax.YLim=[0, 1.3];
ax.XLim=[-.2 6.0];
set(gcf,'color','w')
ylabel('Fraction Postsynaptic Profiles')

%Pie chart of average across PNs

figure()
h=pie(mean(normIden));
% title('Average Fractional Input')
set(gcf,'color','w')

textInds=[2:2:8];

for i=1:3%4
    h(textInds(i)).FontSize=16;
end



