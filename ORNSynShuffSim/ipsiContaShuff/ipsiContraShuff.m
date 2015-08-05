%% In this simulation I want to shuffle the identity of ORN synapses

%Identify the positions on the postsynaptic neuron whereleft ORNs contact
%it

synVerts_master=[];

for o=1:length(leftORNs)
    
    workingORN=leftORNs(o);
    
    %Identify the positions on the PN 1 dendrite where this cell synapses
    %onto it
    
    workingSynVerts=getSynapseVerts(workingSkel,workingORN);
    synVerts_master=[synVerts_master,workingSynVerts];

end

% create a vector containing the number of synapses made by each ORN onto
% PN1


for c=1:length(leftORNs)
    orn2PNsynNum(c)=getSynapseNum(leftORNs(c),skelID);
end



for i=1:500
    i
    synVerts=synVerts_master;
    
    %create a shuffling vectorsave('shuffMeanDistsR', 'shuffMeanDists')
    shuffInds=randperm(length(synVerts));
    
    %shuffle the synapses
    synVerts=synVerts(shuffInds);
    
    
    % Assign shuffled synapses locations to each of 50 fictive ORNs
    
    for c=1:length(leftORNs)
        
        shuffORNs{c}=synVerts(1:orn2PNsynNum(c));
        synVerts(1:orn2PNsynNum(c))=[];
        
    end


    
    % Calculate path length for each of the
    
    
    for o=1:length(leftORNs)
        
        
        
        % Determine the mean min path length between these synapses and an
        % fixed, fictive "integrator" node
        
        %Define the integrator node, this is the last node of PN1s primary neurite
        integrator={'x0x39_4579'};
        
        [shuffMeanDists{i}(o), shuffStdDist{i}(o), shuffPathsToIntegrator{i}{o}, paths{i}{o}]=meanPathToIntegrator(workingSkel,edgeMatrix,skelVertNames,shuffORNs{o},integrator);
        
        
    end
    
    
end

cd('~/Documents/MATLAB/tracingCode/ORNSynShuffSim/ipsiContaShuff/')
save('shuffMeanDistsL', 'shuffMeanDists')
save('shuffStdDistL', 'shuffStdDist')
save('shuffPathsToIntegratorL', 'shuffPathsToIntegrator')
save('pathsL','paths')


%% In this simulation I want to shuffle the identity of ORN synapses

synVerts_master=[];
for o=1:length(rightORNs)
    
    workingORN=rightORNs(o);
    
    %Identify the positions on the PN 1 dendrite where this cell synapses
    %onto it
    
    workingSynVerts=getSynapseVerts(workingSkel,workingORN);
    synVerts_master=[synVerts_master,workingSynVerts];

end

% create a400 vector containing the number of synapses made by each ORN onto
% PN1

for c=1:length(rightORNs)
    orn2PNsynNum(c)=getSynapseNum(rightORNs(c),skelID);
end



for i=1:500
    
    tic
    synVerts=synVerts_master;
    
    %create a shuffling vector
    shuffInds=randperm(length(synVerts));
    
    %shuffle the synapses
    synVerts=synVerts(shuffInds);
    
    
    % Assign shuffled synapses locations to each fictive ORN
    
    for c=1:length(rightORNs)
        
        shuffORNs{c}=synVerts(1:orn2PNsynNum(c));
        synVerts(1:orn2PNsynNum(c))=[];
        
    end


    
    % Calculate path length for each of the
    
    
    for o=1:length(rightORNs)
        
        
        
        % Determine the mean min path length between these synapses and an
        % fixed, fictive "integrator" node
        
        %Define the integrator node, this is the last node of PN1s primary neurite
        integrator={'x0x39_4579'};
        leftORNs
        [shuffMeanDists{i}(o), shuffStdDist{i}(o), shuffPathsToIntegrator{i}{o}, paths{i}{o}]=meanPathToIntegrator(workingSkel,edgeMatrix,skelVertNames,shuffORNs{o},integrator);
        
        
    end
[n1,p1]=hist(test,50)
[n2,p2]=hist(meanPathLengths,50)

bar(p1, n1)
hold on
bar(p2,n2,'r')
    toc
    
end

cd('~/Documents/MATLAB/tracingCode/ORNSynShuffSim/ipsiContaShuff/')
save('shuffMeanDistsR', 'shuffMeanDists')
save('shuffStdDistR', 'shuffStdDist')
save('shuffPathsToIntegratorR', 'shuffPathsToIntegrator')
save('pathsR','paths')



%%

for i=1:500
    popMeans(i)=mean(shuffMeanDists{i});
end

figure()
hist(popMeans,100)
set(gcf,'color','w')
xlabel('Path Distance (nm)')
title('Mean Contra ORN syn distance to primary neurite for 500 shuffled pops')
savefig('popMeansR')
export_fig popMeansR.png


for i=1:500
    popSTDs(i)=std(shuffMeanDists{i});
end

figure()
hist(popSTDs,100)
set(gcf,'color','w')
xlabel('std (nm)')
title('std of Contra ORN syn distance to primary neurite for 500 shuffled pops')
savefig('popSTDsR')
export_fig popSTDsR.png

sum(popSTDs >= std(meanMinDistsR))/500


for i=1:500
    meanSTDs(i)=mean(shuffStdDist{i});
end

figure()
hist(meanSTDs,100)
set(gcf,'color','w')
xlabel('mean std (nm)')
title('mean std of Contra ORN syn distance to primary neurite for 500 shuffled pops')
savefig('meanSTDsR')
export_fig meanSTDsR.png

sum(meanSTDs >= mean(stdMinDistR))/500

% Now for the ipsi ORNs

for i=1:500
    popMeans(i)=mean(shuffMeanDists{i});
end

figure()
hist(popMeans,100)
set(gcf,'color','w')
xlabel('Path Distance (nm)')
title('Mean Ipsi ORN syn distance to primary neurite for 500 shuffled pops')
savefig('popMeansL')
export_fig popMeansL.png


for i=1:500
    popSTDs(i)=std(shuffMeanDists{i});
end

figure()
hist(popSTDs,100)
set(gcf,'color','w')
xlabel('std (nm)')
title('std of Ipsi ORN syn distance to primary neurite for 500 shuffled pops')
savefig('popSTDsL')
export_fig popSTDsL.png

sum(popSTDs >= std(meanDistsL))/500


for i=1:500
    meanSTDs(i)=mean(shuffStdDist{i});
end

figure()
hist(meanSTDs,100)
set(gcf,'color','w')
xlabel('mean std (nm)')
title('mean std of ipss ORN syn distance to primary neurite for 500 shuffled pops')
savefig('meanSTDsL')
export_fig meanSTDsL.png

sum(meanSTDs >= mean(stdDistL))/500





dists=[]
for i=1:500
%     for j
    dists=[dists pathLengthsL{i}]
end







[n1,p1]=hist(meanMinDistsL,50)
[n2,p2]=hist(shuffMeanDists,50)

bar(p1, n1)
hold on
bar(p2,n2,'r')


        [testMeanDists{i}(o), testStdDist{i}(o), testPathsToIntegrator{i}{o}, testPaths{i}{o}]=meanPathToIntegrator(workingSkel,edgeMatrix,skelVertNames,synVerts_master,integrator);
        
