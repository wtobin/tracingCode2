% { What I want to do here is identify all synapses of the following types
% 
% ORN--> PN
% ORN--> LN
% ORN--> ORN
% 
% PN-->PN
% PN-->LN
% PN-->ORN
% 
% LN-->PN
% LN-->LN
% LN-->ORN
% 
% Then I need to count the number of postsynaptic elements at each of them

% Strategy for identifying ORNs, PNs and LNs

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

%% Count number of postsynaptic profiles at each type of synapse

% find ORN--> synapses, count post profiles

% Loop over ORNs



    PNCounter=1;
    LNCounter=1;
    ORNCounter=1;

for o=1:length(ORNs)
    

    %loop over all connectors
    for i= 1 : length(connFields)
        
        %Make sure the connector doesnt have an empty presynaptic field
        if isempty(conns.(cell2mat(connFields(i))).pre) == 1
            
        else
            
            %Check to see if the working skel is presynaptic at this
            %connector and if a PN is postsynaptic
            if conns.(cell2mat(connFields(i))).pre == ORNs(o) && sum(ismember((PNs), conns.(cell2mat(connFields(i))).post))>=1;
                
                ornOuts{1}(PNCounter)= length(conns.(cell2mat(connFields(i))).post);
                
                PNCounter=PNCounter+1;
                
                
            else
            end
            
            %Check to see if the working skel is presynaptic at this
            %connector and if a LN is postsynaptic
            if conns.(cell2mat(connFields(i))).pre == ORNs(o) && sum(ismember((LNs), conns.(cell2mat(connFields(i))).post))>=1;
                
                ornOuts{2}(LNCounter)= length(conns.(cell2mat(connFields(i))).post);
                
                LNCounter=LNCounter+1;
                
                
            else
            end
            
            %Check to see if the working skel is presynaptic at this
            %connector and if an ORN is postsynaptic
            if conns.(cell2mat(connFields(i))).pre == ORNs(o) && sum(ismember((ORNs), conns.(cell2mat(connFields(i))).post))>=1;
                
                ornOuts{3}(ORNCounter)= length(conns.(cell2mat(connFields(i))).post);
                
                ORNCounter=ORNCounter+1;
                
                
            else
            end
            
            
        end
    end
    
end


% find PN--> synapses, count post profiles

% Loop over PNs

    PNCounter=1;
    LNCounter=1;
    ORNCounter=1;
    
for o=1:length(PNs)
 
    
    %loop over all connectors
    for i= 1 : length(connFields)
        
        %Make sure the connector doesnt have an empty presynaptic field
        if isempty(conns.(cell2mat(connFields(i))).pre) == 1
            
        else
            
            %Check to see if the working skel is presynaptic at this
            %connector and if a PN is postsynaptic
            if conns.(cell2mat(connFields(i))).pre == PNs(o) && sum(ismember((PNs), conns.(cell2mat(connFields(i))).post))>=1;
                
                pnOuts{1}(PNCounter)= length(conns.(cell2mat(connFields(i))).post);
                
                PNCounter=PNCounter+1;
                
                
            else
            end
            
            %Check to see if the working skel is presynaptic at this
            %connector and if a LN is postsynaptic
            if conns.(cell2mat(connFields(i))).pre == PNs(o) && sum(ismember((LNs), conns.(cell2mat(connFields(i))).post))>=1;
                
                pnOuts{2}(LNCounter)= length(conns.(cell2mat(connFields(i))).post);
                
                LNCounter=LNCounter+1;
                
                
            else
            end
            
            %Check to see if the working skel is presynaptic at this
            %connector and if an ORN is postsynaptic
            if conns.(cell2mat(connFields(i))).pre == PNs(o) && sum(ismember((ORNs), conns.(cell2mat(connFields(i))).post))>=1;
                
                pnOuts{3}(ORNCounter)= length(conns.(cell2mat(connFields(i))).post);
                
                ORNCounter=ORNCounter+1;
                
                
            else
            end
            
            
        end
    end
    
end



% find LN--> synapses, count post profiles

    PNCounter=1;
    LNCounter=1;
    ORNCounter=1;
    
% Loop over LNs
for o=1:length(LNs)
    

    
    %loop over all connectors
    for i= 1 : length(connFields)
        
        %Make sure the connector doesnt have an empty presynaptic field
        if isempty(conns.(cell2mat(connFields(i))).pre) == 1
            
        else
            
            %Check to see if the working skel is presynaptic at this
            %connector and if a PN is postsynaptic
            if conns.(cell2mat(connFields(i))).pre == LNs(o) && sum(ismember((PNs), conns.(cell2mat(connFields(i))).post))>=1;
                
                lnOuts{1}(PNCounter)= length(conns.(cell2mat(connFields(i))).post);
                
                PNCounter=PNCounter+1;
                
                
            else
            end
            
            %Check to see if the working skel is presynaptic at this
            %connector and if a LN is postsynaptic
            if conns.(cell2mat(connFields(i))).pre == LNs(o) && sum(ismember((LNs), conns.(cell2mat(connFields(i))).post))>=1;
                
                lnOuts{2}(LNCounter)= length(conns.(cell2mat(connFields(i))).post);
                
                LNCounter=LNCounter+1;
                
                
            else
            end
            
            %Check to see if the working skel is presynaptic at this
            %connector and if an ORN is postsynaptic
            if conns.(cell2mat(connFields(i))).pre == LNs(o) && sum(ismember((ORNs), conns.(cell2mat(connFields(i))).post))>=1;
                
                lnOuts{3}(ORNCounter)= length(conns.(cell2mat(connFields(i))).post);
                
                ORNCounter=ORNCounter+1;
                
                
            else
            end
            
            
        end
    end
    
end

%% Plotting

figure()
set(gcf,'color','w')

subplot(3,1,1)

for t=1:3

jitterAmount = 0.25;
jitterValuesX = 2*(rand(1,length(ornOuts{t}))-0.5)*jitterAmount;   % +/-jitterAmount max
jitterValuesY = 2*(rand(size(ornOuts{t}))-0.5)*jitterAmount;   % +/-jitterAmount max

scatter(t*ones(1,length(ornOuts{t}))+jitterValuesX,ornOuts{t}+jitterValuesY)
hold on


end

ax=gca;
ax.XLim=[0 4];
ax.YLim=[0 15];
ax.XTick=[1:3];
ax.XTickLabel={'ORN-->PN','ORN-->LN','ORN-->ORN'};
ax.FontSize=16;
        
     
subplot(3,1,2)

for t=1:3

jitterAmount = 0.25;
jitterValuesX = 2*(rand(1,length(pnOuts{t}))-0.5)*jitterAmount;   % +/-jitterAmount max
jitterValuesY = 2*(rand(size(pnOuts{t}))-0.5)*jitterAmount;   % +/-jitterAmount max

scatter(t*ones(1,length(pnOuts{t}))+jitterValuesX,pnOuts{t}+jitterValuesY)
hold on


end

ax=gca;
ylabel('Num Post Partners', 'FontSize', 16)
ax.XLim=[0 4];
ax.YLim=[0 15];
ax.XTick=[1:3];
ax.XTickLabel={'PN-->PN','PN-->LN','PN-->ORN'}; 
ax.FontSize=16;
        

subplot(3,1,3)

for t=1:3

jitterAmount = 0.25;
jitterValuesX = 2*(rand(1,length(lnOuts{t}))-0.5)*jitterAmount;   % +/-jitterAmount max
jitterValuesY = 2*(rand(size(lnOuts{t}))-0.5)*jitterAmount;   % +/-jitterAmount max

scatter(t*ones(1,length(lnOuts{t}))+jitterValuesX,lnOuts{t}+jitterValuesY)
hold on


end

ax=gca;
ax.XLim=[0 4];
ax.YLim=[0 15];
ax.XTick=[1:3];
ax.XTickLabel={'LN-->PN','LN-->LN','LN-->ORN'}; 
ax.FontSize=16;
        

%Histograms


figure()
set(gcf,'color','w')
types={'ORN-->PN','ORN-->LN','ORN-->ORN'};


for t=1:3

subplot(3,3,t)
[N Edges]=histcounts(ornOuts{t});
histogram(ornOuts{t},Edges)
title(types(t), 'FontSize', 16)
ylim([0 1500])
xlim([0 12])
ax=gca;
ax.FontSize=16;
ax.XTick=[0:2:12];

end

types={'PN-->PN','PN-->LN','PN-->ORN'};


for t=1:3

subplot(3,3,t+3)
[N Edges]=histcounts(pnOuts{t})
histogram(pnOuts{t},Edges)
title(types(t),'FontSize', 16)
ylim([0 200])
xlim([0 12])
ax=gca;
ax.FontSize=16;
ax.XTick=[0:2:12];

end

types={'LN-->PN','LN-->LN','LN-->ORN'};

for t=1:3

subplot(3,3,t+6)
[N Edges]=histcounts(lnOuts{t})
histogram(lnOuts{t},Edges);
title(types(t),'FontSize', 16)
ylim([0 400])
xlim([0 12])

if t==1
    xlabel('Num Post Profiles', 'FontSize', 16)
    ylabel('Freq','FontSize', 16)
end

ax=gca;
ax.FontSize=16;
ax.XTick=[0:2:12];

end