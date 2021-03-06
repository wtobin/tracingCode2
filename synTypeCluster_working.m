%% this script is written to ask whether synapses from ORNs are closer to
% each other on PN dendrites than randomly selected input synapses

% Load annotations json. Generated by Wei's code
annotations=loadjson('/home/wtobin/tracing/sid_by_annotation.json');

% Return all skeleton IDs for R and L ORNs

ORNs_Left=annotations.Left_0x20_ORN;
ORNs_Right=annotations.Right_0x20_ORN;

%exclude unilateral ORNs for now

ORNs_Right(find(ORNs_Right == 499879))=[];
ORNs_Left(find(ORNs_Left == 426230))=[];
ORNs_Left(find(ORNs_Left == 401378))=[];

%return all skeleton IDs of DM6 PNs
PNs=annotations.PN;

% For each PN
for p=1:length(PNs)


%Load the PN skeleton into the workspace
workingPN=loadjson(strcat('~/tracing/skeletons/', num2str(PNs(p)),'.json'));
 
% Collect all synapses coming from ORNs
ORNs=[ORNs_Left,ORNs_Right];

ornSynPool=[];
    
for orn=1:length(ORNs)
   
curSyns=getSynapseVerts(workingPN,ORNs(orn));
ornSynPool=[ornSynPool,curSyns];

end


% create a list of all input synapses on the PN dendrite

allInputs=getAllSynapseVerts(workingPN,1);

% remove the ORN input synapses from this pool
counter=1;

for i=1:length(allInputs)
    
    if ismember(allInputs(i), ornSynPool) == 1
        
        ornSynInds(counter)=i;
        counter=counter+1;
    else
         
    end
    
end

nonORNInputs=allInputs;
nonORNInputs(ornSynInds)=[];

%go through each ORN synapse, remove that ORN's synapses from the ORN syn
%pool and calculate the path length to all other ORN and non-ORN synpases

for o =1:length(ORNs)
    
workingORNID=ORNs(o);
workingORNSyns=getSynapseVerts(workingPN,workingORNID);
workingORNPool=ornSynPool;

counter=1;

for i=1:length(workingORNPool)
    
    if ismember(workingORNPool(i),workingORNSyns)
        workingORNSynInds(counter)=i;
        counter=counter+1;
    else
    end
end

workingORNPool(workingORNSynInds)=[];


%generate an undirected weighted edge matrix for the working PN
[ edgeMatrix, skelVertNames ] = getSkelAdjMat_UW( workingPN );

for j=1:length(workingORNSyns)

%Calulcate paths between each synapse and all other ORN synapses
tic
[meanOrnToOrnPathL{p,o,j}, ornPathLengthStd{p,o,j}, ornPathLengths{p,o,j}, ornPaths{p,o,j} ]=meanPathToIntegrator_undirected(workingPN, edgeMatrix, skelVertNames, workingORNPool, workingORNSyns(j));
toc

%Calulcate paths between each synapse of my working ORN synapse and all other non-ORN
%synapses

[meanOrnToNotPathL{p,o,j}, pathLengthStd_nonOrn{p,o,j}, pathLengths_nonOrn{p,o,j}, paths_nonOrns{p,o,j} ]=meanPathToIntegrator_undirected(workingPN, edgeMatrix, skelVertNames, nonORNInputs, workingORNSyns(j));

end

clear workingORNSynInds


end

end

