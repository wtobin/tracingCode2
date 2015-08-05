%% 
%% Hard code ORN/PN skeleton IDs

rightORNs=[153798,366040,309595,321092,327347,392106,329095,331430,331514,...
    332797,332879,333916,339573,333379,360235,360361,362882,362982,362999,...
    373569,373736,379044,392665,395984,396156,402811];

leftORNs=[220151,225960,265283,317572,319492,320409,320688,328875,331413,...
    337396,337765,343030,362954,373935,379686,387843,398576,401197,401378,...
    401986,333138,403794,415503,420141];



%%  For each  ORN

ORNs=rightORNs;

for o=1:length(ORNs)
    
    workingORN=ORNs(o);
    
    %Identify the positions on the PN 1 dendrite where this cell synapses
    %onto it
    
    synVerts=getSynapseVerts(workingSkel,workingORN);
    
    
    % Determine the mean min path length between these synapses and an
    % fixed, fictive "integrator" node
    
    %Define the integrator node, this is the last node of PN1s primary neurite
    integrator={'x0x39_4579'};
    
    [meanMinDistsR(o), stdMinDistR(o), pathsToIntegratorR{o}]=meanPathToIntegrator(workingSkel,edgeMatrix,skelVertNames,synVerts,integrator);
    
    
end



ORNs=leftORNs;

for o=1:length(ORNs)
    
    workingORN=ORNs(o);
    
    %Identify the positions on the PN 1 dendrite where this cell synapses
    %onto it
    
    synVerts=getSynapseVerts(workingSkel,workingORN);
    
    
    % Determine the mean min path length between these synapses and an
    % fixed, fictive "integrator" node
    
    %Define the integrator node, this is the last node of PN1s primary neurite
    integrator={'x0x39_4579'};
    
    [meanMinDistsL(o), stdMinDistL(o), pathsToIntegratorL{o}]=meanPathToIntegrator(workingSkel,edgeMatrix,skelVertNames,synVerts,integrator);
    
    
end


sPathsL=[]
for i=1:length(pathsToIntegratorL)
    
    sPathsL=[sPathsL,  sort(pathsToIntegratorL{i})];
    
end

sPathsR=[]
for i=1:length(pathsToIntegratorR)
    
    sPathsR=[sPathsR,  sort(pathsToIntegratorR{i})];
    
end




figure()
hold on
for i=1:length(pathsToIntegratorL)
    
    plot(sPathsL{i}, 'r')
    
end

for i=1:length(pathsToIntegratorR)
    
    plot(sPathsR{i}, 'k')
    
end


