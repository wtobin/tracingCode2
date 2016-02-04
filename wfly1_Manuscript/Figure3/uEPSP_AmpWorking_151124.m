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
PNs=annotations.DM6_0x20_PN;

%return all LN skel IDs
LNs=annotations.LN;
LNs=[LNs, annotations.potential_0x20_LN];
% LNs=[LNs, annotations.Prospective_0x20_LN];
% LNs=[LNs, annotations.Likely_0x20_LN];


%Load the connector structure
load('~/tracing/conns.mat')

%gen conn fieldname list
connFields=fieldnames(conns);

%Base dir for simulation results
baseDir='/home/william/nC_projects/';

%% Collect simulation results for PN1LS

pn1LS_Vm=importdata(strcat(baseDir, 'PN1LS_151125/simulations/unitaries_151125/neuron_PN1_LS_sk_419138_0.dat'));
pn1LS_simTime=importdata(strcat(baseDir, 'PN1LS_151125/simulations/unitaries_151125/time.dat'));

%collect ORN skel IDs from PN1LS hoc file and save them in a txt file
idCommand=['grep -Po ''(?<=objref spikesource_)\d*'' ', ...
    baseDir,'PN1LS_151125/simulations/unitaries_151125/PN1LS_151125.hoc > ',baseDir,'PN1LS_151125/simulations/unitaries_151125/ornIDs.txt'];
    
system(idCommand);
ornSkelIDs=importdata([baseDir,'PN1LS_151125/simulations/unitaries_151125/ornIDs.txt']);

fireTimeCmd=['grep -Po ''((?<=.start = )\d*)'' ', baseDir,...
    'PN1LS_151125/simulations/unitaries_151125/PN1LS_151125.hoc > ',baseDir, 'PN1LS_151125/simulations/unitaries_151125/ornSpikeTimes.txt'];
system(fireTimeCmd);
fireTimes=importdata([baseDir,'PN1LS_151125/simulations/unitaries_151125/ornSpikeTimes.txt']);


%% Collect uEPSPs in an array


for o=1:length(ornSkelIDs)
    
    if ismember(ornSkelIDs(o),ORNs_Left) == 1
        
        leftUEPSPs{1}(find(ORNs_Left==ornSkelIDs(o)),:)= pn1LS_Vm(find(pn1LS_simTime==fireTimes(o))-160:find(pn1LS_simTime==fireTimes(o))+4000);
        leftContactNum{1}(find(ORNs_Left==ornSkelIDs(o)))=getSynapseNum(ornSkelIDs(o),PNs(2));
        
        
    elseif ismember(ornSkelIDs(o),ORNs_Right) == 1
        
      rightUEPSPs{1}(find(ORNs_Right==ornSkelIDs(o)),:) = pn1LS_Vm(find(pn1LS_simTime==fireTimes(o))-160:find(pn1LS_simTime==fireTimes(o))+4000);
      rightContactNum{1}(find(ORNs_Right==ornSkelIDs(o)))=getSynapseNum(ornSkelIDs(o),PNs(2));
      
        
    end
end

%% Collect simulation results for PN2LS

pn2LS_Vm=importdata(strcat(baseDir, 'PN2LS_151125/simulations/unitaries_151125/neuron_PN2_LS_sk_427345_0.dat'));
pn2LS_simTime=importdata(strcat(baseDir, 'PN2LS_151125/simulations/unitaries_151125/time.dat'));

%collect ORN skel IDs from PN1LS hoc file and save them in a txt file
idCommand=['grep -Po ''(?<=objref spikesource_)\d*'' ', ...
    baseDir,'PN2LS_151125/simulations/unitaries_151125/PN2LS_151125.hoc > ',baseDir,'PN2LS_151125/simulations/unitaries_151125/ornIDs.txt'];
    
system(idCommand);
ornSkelIDs=importdata([baseDir,'PN2LS_151125/simulations/unitaries_151125/ornIDs.txt']);

fireTimeCmd=['grep -Po ''((?<=.start = )\d*)'' ', baseDir,...
    'PN2LS_151125/simulations/unitaries_151125/PN2LS_151125.hoc > ',baseDir, 'PN2LS_151125/simulations/unitaries_151125/ornSpikeTimes.txt'];
system(fireTimeCmd);
fireTimes=importdata([baseDir,'PN2LS_151125/simulations/unitaries_151125/ornSpikeTimes.txt']);


%% Collect uEPSPs in an array


for o=1:length(ornSkelIDs)
    
    if ismember(ornSkelIDs(o),ORNs_Left) == 1
        
        leftUEPSPs{2}(find(ORNs_Left==ornSkelIDs(o)),:)= pn2LS_Vm(find(pn2LS_simTime==fireTimes(o))-160:find(pn2LS_simTime==fireTimes(o))+4000);
        leftContactNum{2}(find(ORNs_Left==ornSkelIDs(o)))=getSynapseNum(ornSkelIDs(o),PNs(3));
      
        
    elseif ismember(ornSkelIDs(o),ORNs_Right) == 1
        
        rightUEPSPs{2}(find(ORNs_Right==ornSkelIDs(o)),:)= pn2LS_Vm(find(pn2LS_simTime==fireTimes(o))-160:find(pn2LS_simTime==fireTimes(o))+4000);
        rightContactNum{2}(find(ORNs_Right==ornSkelIDs(o)))=getSynapseNum(ornSkelIDs(o),PNs(3));
      
        
    end
end


%% Collect simulation results for PN3LS


pn3LS_Vm=importdata(strcat(baseDir, 'PN3LS_151125/simulations/unitaries_151125/neuron_PN3_LS_sk_668267_0.dat'));
pn3LS_simTime=importdata(strcat(baseDir, 'PN3LS_151125/simulations/unitaries_151125/time.dat'));

%collect ORN skel IDs from PN3LS hoc file and save them in a txt file
idCommand=['grep -Po ''(?<=objref spikesource_)\d*'' ', ...
    baseDir,'PN3LS_151125/simulations/unitaries_151125/PN3LS_151125.hoc > ',baseDir,'PN3LS_151125/simulations/unitaries_151125/ornIDs.txt'];
    
system(idCommand);
ornSkelIDs=importdata([baseDir,'PN3LS_151125/simulations/unitaries_151125/ornIDs.txt']);

fireTimeCmd=['grep -Po ''((?<=.start = )\d*)'' ', baseDir,...
    'PN3LS_151125/simulations/unitaries_151125/PN3LS_151125.hoc > ',baseDir, 'PN3LS_151125/simulations/unitaries_151125/ornSpikeTimes.txt'];
system(fireTimeCmd);
fireTimes=importdata([baseDir,'PN3LS_151125/simulations/unitaries_151125/ornSpikeTimes.txt']);



%% Collect uEPSPs in an array


for o=1:length(ornSkelIDs)
    
    if ismember(ornSkelIDs(o),ORNs_Left) == 1
        
        leftUEPSPs{3}(find(ORNs_Left==ornSkelIDs(o)),:)= pn3LS_Vm(find(pn3LS_simTime==fireTimes(o))-160:find(pn3LS_simTime==fireTimes(o))+4000);
        leftContactNum{3}(find(ORNs_Left==ornSkelIDs(o)))=getSynapseNum(ornSkelIDs(o),PNs(1));
        
        
    elseif ismember(ornSkelIDs(o),ORNs_Right) == 1
        
        rightUEPSPs{3}(find(ORNs_Right==ornSkelIDs(o)),:)= pn3LS_Vm(find(pn3LS_simTime==fireTimes(o))-160:find(pn3LS_simTime==fireTimes(o))+4000);
        rightContactNum{3}(find(ORNs_Right==ornSkelIDs(o)))=getSynapseNum(ornSkelIDs(o),PNs(1));
       
        
    end
end


%% Collecfind(ORNs_Right==ornSkelIDs(o)),:t simulation results for PN1RS

pn1RS_Vm=importdata(strcat(baseDir, 'PN1RS_151125/simulations/unitaries_151125/neuron_PN1_RS_sk_638603_0.dat'));
pn1RS_simTime=importdata(strcat(baseDir, 'PN1RS_151125/simulations/unitaries_151125/time.dat'));

%collect ORN skel IDs from PN1RS hoc file and save them in a txt file
idCommand=['grep -Po ''(?<=objref spikesource_)\d*'' ', ...
    baseDir,'PN1RS_151125/simulations/unitaries_151125/PN1RS_151125.hoc > ',baseDir,'PN1RS_151125/simulations/unitaries_151125/ornIDs.txt'];
    
system(idCommand);
ornSkelIDs=importdata([baseDir,'PN1RS_151125/simulations/unitaries_151125/ornIDs.txt']);

fireTimeCmd=['grep -Po ''((?<=.start = )\d*)'' ', baseDir,...
    'PN1RS_151125/simulations/unitaries_151125/PN1RS_151125.hoc > ',baseDir, 'PN1RS_151125/simulations/unitaries_151125/ornSpikeTimes.txt'];
system(fireTimeCmd);
fireTimes=importdata([baseDir,'PN1RS_151125/simulations/unitaries_151125/ornSpikeTimes.txt']);


%% Collect uEPSPs in an array

for o=1:length(ornSkelIDs)
    
    if ismember(ornSkelIDs(o),ORNs_Left) == 1
        
        leftUEPSPs{4}(find(ORNs_Left==ornSkelIDs(o)),:)= pn1RS_Vm(find(pn1RS_simTime==fireTimes(o))-160:find(pn1RS_simTime==fireTimes(o))+4000);
        leftContactNum{4}(find(ORNs_Left==ornSkelIDs(o)))=getSynapseNum(ornSkelIDs(o),PNs(5));
      
        
    elseif ismember(ornSkelIDs(o),ORNs_Right) == 1
        
        rightUEPSPs{4}(find(ORNs_Right==ornSkelIDs(o)),:)= pn1RS_Vm(find(pn1RS_simTime==fireTimes(o))-160:find(pn1RS_simTime==fireTimes(o))+4000);
        rightContactNum{4}(find(ORNs_Right==ornSkelIDs(o)))=getSynapseNum(ornSkelIDs(o),PNs(5));
        
        
    end
end

%% Collect simulation results for P2RS

pn2RS_Vm=importdata(strcat(baseDir, 'PN2RS_151125/simulations/unitaries_151125/neuron_PN2_RS_sk_480245_0.dat'));
pn2RS_simTime=importdata(strcat(baseDir, 'PN2RS_151125/simulations/unitaries_151125/time.dat'));

%collect ORN skel IDs from PN2RS hoc file and save them in a txt file
idCommand=['grep -Po ''(?<=objref spikesource_)\d*'' ', ...
    baseDir,'PN2RS_151125/simulations/unitaries_151125/PN2RS_151125.hoc > ',baseDir,'PN2RS_151125/simulations/unitaries_151125/ornIDs.txt'];
    
system(idCommand);
ornSkelIDs=importdata([baseDir,'PN2RS_151125/simulations/unitaries_151125/ornIDs.txt']);

fireTimeCmd=['grep -Po ''((?<=.start = )\d*)'' ', baseDir,...
    'PN2RS_151125/simulations/unitaries_151125/PN2RS_151125.hoc > ',baseDir, 'PN2RS_151125/simulations/unitaries_151125/ornSpikeTimes.txt'];
system(fireTimeCmd);
fireTimes=importdata([baseDir,'PN2RS_151125/simulations/unitaries_151125/ornSpikeTimes.txt']);


%% Collect uEPSPs in an array




for o=1:length(ornSkelIDs)
    
    if ismember(ornSkelIDs(o),ORNs_Left) == 1
        
        leftUEPSPs{5}(find(ORNs_Left==ornSkelIDs(o)),:)= ...
            pn2RS_Vm(find(pn2RS_simTime==fireTimes(o))-160:find(pn2RS_simTime==fireTimes(o))+4000);
        leftContactNum{5}(find(ORNs_Left==ornSkelIDs(o)))=getSynapseNum(ornSkelIDs(o),PNs(4));
      
        
    elseif ismember(ornSkelIDs(o),ORNs_Right) == 1
        
        rightUEPSPs{5}(find(ORNs_Right==ornSkelIDs(o)),:)=...
            pn2RS_Vm(find(pn2RS_simTime==fireTimes(o))-160:find(pn2RS_simTime==fireTimes(o))+4000);
        rightContactNum{5}(find(ORNs_Right==ornSkelIDs(o)))=getSynapseNum(ornSkelIDs(o),PNs(4));
        
        
    end
end



