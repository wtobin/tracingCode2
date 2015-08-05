%% Mean Min Path length worksheet 150523

%Move to tracing data directory
cd('~/tracing')

%% Load PN1 skeleton into the workplace

skelID=419138;
workingSkel=loadjson(strcat('~/tracing/skeletons/', num2str(skelID),'.json'));

%% generate an adjacency matrix indicating skeleton node connectivity

[ edgeMatrix, skelVertNames ] = getSkelAdjMat_DW( workingSkel );


%% Hard code ORN/PN skeleton IDs

rightORNs=[153798,366040,309595,321092,327347,392106,329095,331430,331514,...
    332797,332879,333916,339573,333379,360235,360361,362882,362982,362999,...
    373569,373736,379044,392665,395984,396156,402811];

leftORNs=[220151,225960,265283,317572,319492,320409,320688,328875,331413,...
    337396,337765,343030,362954,373935,379686,387843,398576,401197,401378,...
    401986,333138,403794,415503,420141];

%%  For each  ORN

ORNs=[leftORNs,rightORNs];

for o=1:length(ORNs)
    
    workingORN=ORNs(o);
    
    %Identify the positions on the PN 1 dendrite where this cell synapses
    %onto it
    
    synVerts=getSynapseVerts(workingSkel,workingORN);
    
    
    % Determine the mean min path length between these synapses and an
    % fixed, fictive "integrator" node
    
    %Define the integrator node, this is the last node of PN1s primary neurite
    integrator={'x0x39_4579'};
    
    [meanMinDists(o), stdMinDist(o), pathLengthsToIntegrator{o}, paths{o}]=meanPathToIntegrator(workingSkel,edgeMatrix,skelVertNames,synVerts,integrator);
    
    
end


%% Now I want to simulate many random ORNs and calculate their mean min path length

% create a vector containing the number of synapses made by each ORN onto
% PN1

for c=1:length(ORNs)
    orn2PNsynNum(c)=getSynapseNum(ORNs(c),skelID);
end


%Disconnect the primary neurite and axon from the PN1 dendritic tuft
modEdgeMatrix=edgeMatrix;

modEdgeMatrix(find(strcmp(skelVertNames,'x0x39_4509')),find(strcmp(skelVertNames,'x0x39_4510')))=0;
modEdgeMatrix(find(strcmp(skelVertNames,'x0x39_4510')),find(strcmp(skelVertNames,'x0x39_4509')))=0;
        

% turn the PN1 edgeMatrix into a biograph object
edgeGraph=biograph(modEdgeMatrix ,skelVertNames);

%Get all descendants of the first dendrite node after the cut made above

dendriteVerts=edgeGraph.Nodes(13236).getrelatives(700);

%% Run the simulation

for r=1:100
    r
    
    for fORN=1:50
        fORN
        %randomly pull a number of connections between our fictive ORN and the
        %PN
        
        shuffSynNums=orn2PNsynNum(randperm(length(orn2PNsynNum)));
        
        modSynNum=shuffSynNums(1);
        shuffSynNums(1)=[];
        
        
        modSynVerts=dendriteVerts(randi(length(dendriteVerts),[1, modSynNum]));
        
        %collect the modeled ORN input vert IDs into a cell array
        
        for v=1:length(modSynVerts)
            modSyns{v}=modSynVerts(v).ID;
        end
        
        % Calculate the mean min distance to the integrator node for this modeled
        % ORN
        
        [meanDists_model(fORN), stdDist_model(fORN), pathLengths_model{fORN},paths_model{fORN}]=meanPathToIntegrator(workingSkel,edgeMatrix,skelVertNames,modSyns,integrator);
        
    end
    
    popDists(r,:)=meanDists_model;
    cellSTDs(r,:)=stdDist_model;
    popMeans(r)= mean(meanDists_model);
    popSTDs(r)=std(meanDists_model);
    
    
    
end

