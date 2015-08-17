% What I want to do here is calculate the path length between all pairs of
% orn to pn input synapses form the same orn



% Load annotations json. Generated by Wei's code gen_annotation_map.py
annotations=loadjson('~/tracing/sid_by_annotation.json');

% Return all skeleton IDs for R and L ORNs

ORNs_Left=annotations.Left_0x20_ORN;
ORNs_Right=annotations.Right_0x20_ORN;

%exclude unilateral ORNs for now
ORNs_Right(find(ORNs_Right == 499879))=[];
ORNs_Left(find(ORNs_Left == 426230))=[];
ORNs_Left(find(ORNs_Left == 401378))=[];


%return all skeleton IDs of DM6 PNs
PNs=annotations.PN;

%For each PN
for p=1:length(PNs)
    
  %Load the PN2 RS skeleton into the workspace
    workingPN=loadjson(strcat('~/tracing/skeletons/', num2str(PNs(p)),'.json'));
    
    % generate an adjacency matrix indicating skeleton node connectivity
    [ edgeMatrix, verts ] = getSkelAdjMat_UW( workingPN );
    
    
% Loop over each left ORN
for o=1:length(ORNs_Left)

    
  
    
   
        % for each ORN identify the positions on the PN dendrite where it
        % forms input synapses
        
  workingORN=ORNs_Left(o);
  inputSynsMaster=getSynapseVerts(workingPN,workingORN);
   
  
  %loop over input synapses
  
  for s=1:length(inputSynsMaster)
      
      workingSyns=inputSynsMaster;
      curSyn=workingSyns(s);
      
      %exclude the current synapse from the workingSyns list
      workingSyns(s)=[];

        %Contact Averaged Path Lengths (CAPLs) calculated and stored
        [synToSynAvesL{p}(o), synToSynSTDsL{p}(o), synToSynIndLengthsL{p}{o},synToSynPathsL{p}{o}]=meanPathToIntegrator_undirected(workingPN,edgeMatrix,verts,workingSyns,curSyn);
        
    end
    
    
end

for o=1:length(ORNs_Right)

   
        % for each ORN identify the positions on the PN dendrite where it
        % forms input synapses
        
  workingORN=ORNs_Right(o);
  inputSynsMaster=getSynapseVerts(workingPN,workingORN);
   
  
  %loop over input synapses
  
  for s=1:length(inputSynsMaster)
      
      workingSyns=inputSynsMaster;
      curSyn=workingSyns(s);
      
      %exclude the current synapse from the workingSyns list
      workingSyns(s)=[];

        %Contact Averaged Path Lengths (CAPLs) calculated and stored
        [synToSynAvesR{p}(o), synToSynSTDsR{p}(o), synToSynIndLengthsR{p}{o},synToSynPathsR{p}{o}]=meanPathToIntegrator_undirected(workingPN,edgeMatrix,verts,workingSyns,curSyn);
        
    end
    
    
end

end
