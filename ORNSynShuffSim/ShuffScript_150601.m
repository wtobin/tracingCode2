%% Some variables were created using other scripts, namely meanMinPathLenghtScrathch and 150527_scratch

%% In this simulation I want to shuffle the identity of ORN synapses

ORNs=[leftORNs,rightORNs];

synVerts_master=[];
for o=1:length(ORNs)
    
    workingORN=ORNs(o);
    
    %Identify the positions on the PN 1 dendrite where this cell synapses
    %onto it
    
    workingSynVerts=getSynapseVerts(workingSkel,workingORN);
    synVerts_master=[synVerts_master,workingSynVerts];

end

% create a vector containing the number of synapses made by each ORN onto
% PN1


for c=1:length(ORNs)
    orn2PNsynNum(c)=getSynapseNum(ORNs(c),skelID);
end



for i=1:400
    tic
    synVerts=synVerts_master;
    
    %create a shuffling vector
    shuffInds=randperm(length(synVerts));
    
    %shuffle the synapses
    synVerts=synVerts(shuffInds);
    
    
    % Assign shuffled synapses locations to each of 50 fictive ORNs
    
    for c=1:length(ORNs)
        
        shuffORNs{c}=synVerts(1:orn2PNsynNum(c));
        synVerts(1:orn2PNsynNum(c))=[];
        
    end
    
    % Calculate path length for each of the
    
    
    for o=1:length(ORNs)
        
        
        
        % Determine the mean min path length between these synapses and an
        % fixed, fictive "integrator" node
        
        %Define the integrator node, this is the last node of PN1s primary neurite
        integrator={'x0x39_4579'};
        
        [shuffMeanDists{i}(o), shuffStdDist{i}(o), shuffPathsToIntegrator{i}{o}, paths{i}{o}]=meanPathToIntegrator(workingSkel,edgeMatrix,skelVertNames,shuffORNs{o},integrator);
        
        
    end
    toc
    
end


save('shuffMeanDists', 'shuffMeanDists')
save('shuffStdDist', 'shuffStdDist')
save('shuffPathsToIntegrator', 'shuffPathsToIntegrator')
save('paths','paths')


for i=1:400
    shuffDistSTDs(i)=std(shuffMeanDists{i});
end


%% some plotting
test=[];

for i=1:400;
    
    test=[test, shuffMeanDists{i}];

end


[n1,p1]=hist(test,50)
[n2,p2]=hist(meanPathLengths,50)

bar(p1, n1)
hold on
bar(p2,n2,'r')