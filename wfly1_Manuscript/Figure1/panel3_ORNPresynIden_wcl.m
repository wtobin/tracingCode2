% The goal here is to generate a pie chart of input profile identity for
% PNs

%% Load annotations and connectors
clear

% Load annotations json. Generated by Wei's code gen_annotation_map.py
annotations=loadjson('~/Dropbox/htem_team/analysis/wfly1/tracing/sid_by_annotation.json');

% Return all skeleton IDs for R and L ORNs

ORNs_Left=annotations.Left_0x20_ORN;
ORNs_Right=annotations.Right_0x20_ORN;

%exclude unilateral ORNs for now

ORNs_Right(find(ORNs_Right == 499879))=[];
% ORNs_Left(find(ORNs_Left == 426230))=[]; % resolved
ORNs_Left(find(ORNs_Left == 401378))=[];
% 
% %exclude ORN 8 because it was temporarily unilateral on 8/5 for testing 
% ORNs_Left(find(ORNs_Left == 593865))=[];

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
load('~/Dropbox/htem_team/analysis/wfly1/tracing/conns.mat')

%gen conn fieldname list
connFields=fieldnames(conns);

%% Collect a list of presynaptic profile skeleton IDs for each ORN

ORNs=[ORNs_Left,ORNs_Right];

%Loop over all ORNs

for o=1:length(ORNs)
    
preSkel{o}=[];

%loop over all connectors
for i= 1 : length(connFields)
    
    %Make sure the connector doesnt have an empty presynaptic field
    if isempty(conns.(cell2mat(connFields(i))).pre) == 1 
        
        % or an empty postsynaptic field, if its empty it will be a cell
        
    elseif iscell(conns.(cell2mat(connFields(i))).post) == 1
        
    else
        
        %Check to see if the current ORN is postsynaptic at this connector
        if sum(ismember(ORNs(o), conns.(cell2mat(connFields(i))).post))>=1
            
            %record the presynaptic skel ID once for each time the ORN is
            %postsynaptic
            
            for s=1:length(conns.(cell2mat(connFields(i))).post)
                
               
                
                if conns.(cell2mat(connFields(i))).post(s) == ORNs(o)
                    
                    preSkel{o}=[preSkel{o}, conns.(cell2mat(connFields(i))).pre];
                    
                else
                end
            end
           
                
          
        else
        end
    end
end



end

%% This block of code is written to see how many ORN presynaptic profiles have at least one annotation

annFields=fieldnames(annotations);

annSkels=[];

for a=1: length(annFields)
    annSkels=[annSkels, annotations.(cell2mat(annFields(a)))];
end

for o=1:length(ORNs)
    
    for s=1:length(preSkel{o})
       annCheck{o}(s)=ismember(preSkel{o}(s), annSkels);
    end
    
    fractAnn(o)=sum(annCheck{o})/length(preSkel{o})
end



%% Categorize presynaptic profiles

% Question, how many profiles can be accounted for as ORNs, PNs and LNs?


% Loop over each ORN
for p=1:length(ORNs)
    
    
    %loop over each presynaptic profile
for s=1:length(preSkel{p})
    
     if ismember(preSkel{p}(s), ORNs) == 1
                
                preSynID{p}(s)=1;
                
                
            elseif ismember(preSkel{p}(s), PNs) == 1
                
                 preSynID{p}(s)=2;
                
                
            elseif ismember(preSkel{p}(s), LNs) == 1
                
                 preSynID{p}(s)=3;
                
                
            else
                 preSynID{p}(s)=3; %4;
                
     end
    
end
end


%% Plotting

%stacked bar chart the averages


%Tally up the identifications

    
for o=1:length(ORNs)
    
 
    
  for id=1:3 %4
    idenCounts(o,id)=sum(preSynID{o}==id);


  end

end


[v i]=sort(sum(idenCounts), 'descend');

%labels={'ORN','PN','LN','Unclassified'};
 
labels={'ORN','PN','Multi-glomerular'};

% myC= [.5 .5 .5 
%   0 0 0
%   1 1 1]; % k: ORN, w: PN, gray: multi

myC= [1 1 1
  0.87 0.80 0.47
  0 0 1]; % y: ORN, b: PN, gray: multi

%Raw Numbers
figure()
h=bar(idenCounts(:,i),'stacked');
legend(labels(i),'Location', 'NorthWest')

for k = i
    set(h(k),'facecolor',myC(k,:))
    set(h(k),'edgecolor','k')
end

ax=gca;
ax.FontSize=11;
set(gcf,'color','w')

ylabel('Presynaptic Profile Num')
xlabel('ORNs')
xlim([0.5 51.5])

%% Fractions

%Normalize the prsynaptic identity counts by tot number of presynaptic
%profiles

for t=1:length(ORNs)
    normIden(t,:)=idenCounts(t,i)./sum(idenCounts(t,i));
end

figure()
h=bar(normIden,'stacked');
legend(labels(i),'Location', 'NorthEast')

for k = i
    set(h(k),'facecolor',myC(k,:))
    set(h(k),'edgecolor','k')
end

ax=gca;
ax.FontSize=11;
ax.YLim=[0, 1.2];
% ax.XLim=[-.2 60]
set(gcf,'color','w')
ylabel('Fraction Presynaptic Profiles')
xlabel('ORNs')
xlim([0.5 51.5])

%% Pie chart of average across ORNs

figure()
h=pie(mean(normIden));
% title('Average Fractional Input')
set(gcf,'color','w')

hp = findobj(h, 'Type', 'patch');
set(hp(1), 'facecolor', 'w');
set(hp(2), 'facecolor', [0.87 0.80 0.47]);
set(hp(3), 'facecolor', 'b');

textInds=[2:2:8];

for i=1:3%4
    h(textInds(i)).FontSize=16;
end


mean(normIden)
std(normIden)/sqrt(length(normIden))

