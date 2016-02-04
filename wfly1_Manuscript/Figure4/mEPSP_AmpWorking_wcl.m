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

%
% LNs=annotations.LN;
% LNs=[LNs, annotations.potential_0x20_LN];
% LNs=[LNs, annotations.Prospective_0x20_LN];
% LNs=[LNs, annotations.Likely_0x20_LN];


%Load the connector structure
load('~/tracing/conns.mat')

%gen conn fieldname list
connFields=fieldnames(conns);

%% Collect simulation results for PN1LS

pn1LS_Vm=importdata('~/nC_projects/PN1LS_allORNs/simulations/minis/neuron_PN1_LS_sk_419138_0.dat');
pn1LS_simTime=importdata('~/nC_projects/PN1LS_allORNs/simulations/minis/time.dat');

%collect ORN skel IDs from PN1LS hoc file, one for every synapse,  and save them in a txt file
idCommand='grep -Po ''(?<=^synapse_)\d*'' ~/nC_projects/PN1LS_allORNs/simulations/minis/PN1LS_allORNs.hoc > ~/nC_projects/PN1LS_allORNs/simulations/minis/synapseIDs.txt ';
system(idCommand);
synIDs=importdata('~/nC_projects/PN1LS_allORNs/simulations/minis/synapseIDs.txt');

fireTimeCmd='grep -Po ''((?<=.start = )\d*)'' ~/nC_projects/PN1LS_allORNs/simulations/minis/PN1LS_allORNs.hoc > ~/nC_projects/PN1LS_allORNs/simulations/minis/ornSpikeTimes.txt';
system(fireTimeCmd);
fireTimes=importdata('~/nC_projects/PN1LS_allORNs/simulations/minis/ornSpikeTimes.txt');


%% Collect mEPSPs in an array

leftCounter=1;
rightCounter=1;

for o=1:length(synIDs)
    
    if ismember(synIDs(o),ORNs_Left) == 1
        
        leftMEPSPs{1}(leftCounter,:)= pn1LS_Vm(find(pn1LS_simTime==fireTimes(o))-160:find(pn1LS_simTime==fireTimes(o))+7840);
        leftMEPSPs_idList{1}(leftCounter)=synIDs(o);
        leftCounter=leftCounter+1;
        
    elseif ismember(synIDs(o),ORNs_Right) == 1
        
       rightMEPSPs{1}(rightCounter,:)= pn1LS_Vm(find(pn1LS_simTime==fireTimes(o))-160:find(pn1LS_simTime==fireTimes(o))+7840);
       rightMEPSPs_idList{1}(rightCounter)=synIDs(o);
       rightCounter=rightCounter+1;
        
    end
    
end

%% Collect simulation results for PN2LS

pn2LS_Vm=importdata('~/nC_projects/PN2LS_allORNs/simulations/minis/neuron_PN2_LS_sk_427345_0.dat');
pn2LS_simTime=importdata('~/nC_projects/PN2LS_allORNs/simulations/minis/time.dat');

%collect ORN skel IDs from PN1LS hoc file and save them in a txt file
idCommand='grep -Po ''(?<=^synapse_)\d*'' ~/nC_projects/PN2LS_allORNs/simulations/minis/PN2LS_allORNs.hoc > ~/nC_projects/PN2LS_allORNs/simulations/minis/ornIDs.txt ';
system(idCommand);
synIDs=importdata('~/nC_projects/PN2LS_allORNs/simulations/minis/ornIDs.txt');

fireTimeCmd='grep -Po ''((?<=.start = )\d*)'' ~/nC_projects/PN2LS_allORNs/simulations/minis/PN2LS_allORNs.hoc > ~/nC_projects/PN2LS_allORNs/simulations/minis/ornSpikeTimes.txt';
system(fireTimeCmd);
fireTimes=importdata('~/nC_projects/PN2LS_allORNs/simulations/minis/ornSpikeTimes.txt');


%% Collect MEPSPs in an array

leftCounter=1;
rightCounter=1;

for o=1:length(synIDs)
    
    if ismember(synIDs(o),ORNs_Left) == 1
        
        leftMEPSPs{2}(leftCounter,:)= pn2LS_Vm(find(pn2LS_simTime==fireTimes(o))-160:find(pn2LS_simTime==fireTimes(o))+7840);
        leftMEPSPs_idList{2}(leftCounter)=synIDs(o);
        leftCounter=leftCounter+1;
        
    elseif ismember(synIDs(o),ORNs_Right) == 1
        
        rightMEPSPs{2}(rightCounter,:)= pn2LS_Vm(find(pn2LS_simTime==fireTimes(o))-160:find(pn2LS_simTime==fireTimes(o))+7840);
        rightMEPSPs_idList{2}(rightCounter)=synIDs(o);
        rightCounter=rightCounter+1;
        
    end
end


%% Collect simulation results for PN3LS

pn3LS_Vm=importdata('~/nC_projects/PN3LS_allORNs/simulations/minis/neuron_PN3_LS_sk_668267_0.dat');
pn3LS_simTime=importdata('~/nC_projects/PN3LS_allORNs/simulations/minis/time.dat');

%collect ORN skel IDs from PN1LS hoc file and save them in a txt file
idCommand='grep -Po ''(?<=^synapse_)\d*'' ~/nC_projects/PN3LS_allORNs/simulations/minis/PN3LS_allORNs.hoc > ~/nC_projects/PN3LS_allORNs/simulations/minis/ornIDs.txt ';
system(idCommand);
synIDs=importdata('~/nC_projects/PN3LS_allORNs/simulations/minis/ornIDs.txt');

fireTimeCmd='grep -Po ''((?<=.start = )\d*)'' ~/nC_projects/PN3LS_allORNs/simulations/minis/PN3LS_allORNs.hoc > ~/nC_projects/PN3LS_allORNs/simulations/minis/ornSpikeTimes.txt';
system(fireTimeCmd);
fireTimes=importdata('~/nC_projects/PN3LS_allORNs/simulations/minis/ornSpikeTimes.txt');


%% Collect MEPSPs in an array

leftCounter=1;
rightCounter=1;

for o=1:length(synIDs)
    
    if ismember(synIDs(o),ORNs_Left) == 1
        
        leftMEPSPs{3}(leftCounter,:)= pn3LS_Vm(find(pn3LS_simTime==fireTimes(o))-160:find(pn3LS_simTime==fireTimes(o))+7840);
        leftMEPSPs_idList{3}(leftCounter)=synIDs(o);
        leftCounter=leftCounter+1;
        
    elseif ismember(synIDs(o),ORNs_Right) == 1
        
        rightMEPSPs{3}(rightCounter,:)= pn3LS_Vm(find(pn3LS_simTime==fireTimes(o))-160:find(pn3LS_simTime==fireTimes(o))+7840);
        rightMEPSPs_idList{3}(rightCounter)=synIDs(o);
        rightCounter=rightCounter+1;
        
    end
end


%% Collect simulation results for PN1RS

pn1RS_Vm=importdata('~/nC_projects/PN1RS_allORNs/simulations/minis/neuron_PN1_RS_sk_638603_0.dat');
pn1RS_simTime=importdata('~/nC_projects/PN1RS_allORNs/simulations/minis/time.dat');

%collect ORN skel IDs from PN1LS hoc file and save them in a txt file
idCommand='grep -Po ''(?<=^synapse_)\d*'' ~/nC_projects/PN1RS_allORNs/simulations/minis/PN1RS_allORNs.hoc > ~/nC_projects/PN1RS_allORNs/simulations/minis/ornIDs.txt ';
system(idCommand);
synIDs=importdata('~/nC_projects/PN1RS_allORNs/simulations/minis/ornIDs.txt');

fireTimeCmd='grep -Po ''((?<=.start = )\d*)'' ~/nC_projects/PN1RS_allORNs/simulations/minis/PN1RS_allORNs.hoc > ~/nC_projects/PN1RS_allORNs/simulations/minis/ornSpikeTimes.txt';
system(fireTimeCmd);
fireTimes=importdata('~/nC_projects/PN1RS_allORNs/simulations/minis/ornSpikeTimes.txt');


%% Collect MEPSPs in an array

leftCounter=1;
rightCounter=1;

for o=1:length(synIDs)
    
    if ismember(synIDs(o),ORNs_Left) == 1
        
        leftMEPSPs{4}(leftCounter,:)= pn1RS_Vm(find(pn1RS_simTime==fireTimes(o))-160:find(pn1RS_simTime==fireTimes(o))+7840);
        leftMEPSPs_idList{4}(leftCounter)=synIDs(o);
        leftCounter=leftCounter+1;
        
    elseif ismember(synIDs(o),ORNs_Right) == 1
        
        rightMEPSPs{4}(rightCounter,:)= pn1RS_Vm(find(pn1RS_simTime==fireTimes(o))-160:find(pn1RS_simTime==fireTimes(o))+7840);
        rightMEPSPs_idList{4}(rightCounter)=synIDs(o);
        rightCounter=rightCounter+1;
        
    end
end

%% Collect simulation results for P2RS

pn2RS_Vm=importdata('~/nC_projects/PN2RS_allORNs/simulations/minis/neuron_PN2_RS_sk_480245_0.dat');
pn2RS_simTime=importdata('~/nC_projects/PN2RS_allORNs/simulations/minis/time.dat');

%collect ORN skel IDs from PN3LS hoc file and save them in a txt file
idCommand=['grep -Po ''(?<=^synapse_)\d*'' ', ...
    '~/nC_projects/PN2RS_allORNs/simulations/minis/PN2RS_allORNs.hoc > ~/nC_projects/PN2RS_allORNs/simulations/minis/ornIDs.txt'];
    
system(idCommand);
synIDs=importdata('~/nC_projects/PN2RS_allORNs/simulations/minis/ornIDs.txt');

fireTimeCmd=['grep -Po ''((?<=.start = )\d*)'' ', ...
    '~/nC_projects/PN2RS_allORNs/simulations/minis/PN2RS_allORNs.hoc > ~/nC_projects/PN2RS_allORNs/simulations/minis/ornSpikeTimes.txt'];
system(fireTimeCmd);
fireTimes=importdata('~/nC_projects/PN2RS_allORNs/simulations/minis/ornSpikeTimes.txt');


%% Collect MEPSPs in an array


leftCounter=1;
rightCounter=1;

for o=1:length(synIDs)
    
    if ismember(synIDs(o),ORNs_Left) == 1
        
        leftMEPSPs{5}(leftCounter,:)= pn2RS_Vm(find(pn2RS_simTime==fireTimes(o))-160:find(pn2RS_simTime==fireTimes(o))+7840);
        leftMEPSPs_idList{5}(leftCounter)=synIDs(o);
        leftCounter=leftCounter+1;
        
    elseif ismember(synIDs(o),ORNs_Right) == 1
        
        rightMEPSPs{5}(rightCounter,:)= pn2RS_Vm(find(pn2RS_simTime==fireTimes(o))-160:find(pn2RS_simTime==fireTimes(o))+7840);
        rightMEPSPs_idList{5}(rightCounter)=synIDs(o);
        rightCounter=rightCounter+1;
        
    end
end








