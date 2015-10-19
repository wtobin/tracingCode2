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

%% Determine the number of contacts between all pairs of categorized neurons


%Find contact numbers for connections where ORNs are presynaptic

% ORN--> PN
% ORN--> LN
% ORN--> ORN

%Loop over ORNs

for o=1:length(ORNs)
    tic 
    % get contact number between each ORN and each PN
    %loop over PNs
    for p=1:length(PNs)
        
        ornToPn(o,p)=getSynapseNum(ORNs(o),PNs(p));
    end
    
    % get contact number between each ORN and each LN
    %loop over LNs
    for l=1:length(LNs)
        
        ornToLn(o,l)=getSynapseNum(ORNs(o),LNs(l));
    end
    
    
    % get contact number between each ORN and each ORN
    %loop over ORNs
    for orn=1:length(ORNs)
        
        ornToOrn(o,orn)=getSynapseNum(ORNs(o),ORNs(orn));
    end
    toc
end

save('ornToPn','ornToPn')
save('ornToLn','ornToLn')
save('ornToOrn','ornToOrn')

%Find contact numbers for connections where PNs are presynaptic

% PN--> PN
% PN--> LN
% PN--> ORN

%Loop over PNs


for o=1:length(PNs)
    tic
    
    % get contact number between each PN and each PN
    %loop over PNs
    for p=1:length(PNs)
        
        pnToPn(o,p)=getSynapseNum(PNs(o),PNs(p));
    end
    
    % get contact number between each PN and each LN
    %loop over LNs
    for l=1:length(LNs)
        
        pnToLn(o,l)=getSynapseNum(PNs(o),LNs(l));
    end
    
    
    % get contact number between each PN and each ORN
    %loop over ORNs
    for orn=1:length(ORNs)
        
        pnToOrn(o,orn)=getSynapseNum(PNs(o),ORNs(orn));
    end
    toc
end

save('pnToPn','pnToPn')
save('pnToLn','pnToLn')
save('pnToOrn','pnToOrn')

%Find contact numbers for connections where LNs are presynaptic

% LN--> PN
% LN--> LN
% LN--> ORN

%Loop over LNs


for o=1:length(LNs)
    tic
    % get contact number between each LN and each PN
    %loop over PNs
    for p=1:length(PNs)
        
        lnToPn(o,p)=getSynapseNum(LNs(o),PNs(p));
    end
    
    % get contact number between each LN and each LN
    %loop over LNs
    for l=1:length(LNs)
        
        lnToLn(o,l)=getSynapseNum(LNs(o),LNs(l));
    end
    
    
    % get contact number between each LN and each ORN
    %loop over ORNs
    for orn=1:length(ORNs)
        
        lnToOrn(o,orn)=getSynapseNum(LNs(o),ORNs(orn));
    end
    toc
end

save('lnToPn','lnToPn')
save('lnToLn','lnToLn')
save('lnToOrn','lnToOrn')

%% Plotting

figure()
set(gcf,'color','w')


ornUnitaries{1}=ornToPn(:);
ornUnitaries{2}=ornToLn;
ornUnitaries{3}=ornToOrn;

subplot(3,1,1)

for t=1:3

jitterAmount = 0.25;
jitterValuesX = 2*(rand(1,length(ornUnitaries{t}))-0.5)*jitterAmount;   % +/-jitterAmount max
jitterValuesY = 2*(rand(size(ornUnitaries{t}))-0.5)*jitterAmount;   % +/-jitterAmount max

scatter(t*ones(1,length(ornUnitaries{t}))+jitterValuesX,ornUnitaries{t}+jitterValuesY)
hold on

end

ax=gca;
ylabel('Connections per Unitary')
ax.XLim=[0 4];
ax.YLim=[0 15];
ax.XTick=[1:3];
ax.XTickLabel={'ORN-->PN','ORN-->LN','ORN-->ORN'};


% Left off right here!! everything below needs to modified for this
% analysis
     
subplot(3,1,2)

for t=1:3

jitterAmount = 0.25;
jitterValuesX = 2*(rand(1,length(pnOuts{t}))-0.5)*jitterAmount;   % +/-jitterAmount max
jitterValuesY = 2*(rand(size(pnOuts{t}))-0.5)*jitterAmount;   % +/-jitterAmount max

scatter(t*ones(1,length(pnOuts{t}))+jitterValuesX,pnOuts{t}+jitterValuesY)
hold on


end

ax=gca;
ylabel('Num Post Partners')
ax.XLim=[0 4];
ax.YLim=[0 15];
ax.XTick=[1:3];
ax.XTickLabel={'PN-->PN','PN-->LN','PN-->ORN'}; 


subplot(3,1,3)

for t=1:3

jitterAmount = 0.25;
jitterValuesX = 2*(rand(1,length(lnOuts{t}))-0.5)*jitterAmount;   % +/-jitterAmount max
jitterValuesY = 2*(rand(size(lnOuts{t}))-0.5)*jitterAmount;   % +/-jitterAmount max

scatter(t*ones(1,length(lnOuts{t}))+jitterValuesX,lnOuts{t}+jitterValuesY)
hold on


end

ax=gca;
ylabel('Num Post Partners')
ax.XLim=[0 4];
ax.YLim=[0 15];
ax.XTick=[1:3];
ax.XTickLabel={'LN-->PN','LN-->LN','LN-->ORN'}; 

