%% Many of the variables used here were generated using meanMinPathLengthScratch


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
    
    
    
    [meanMinDistsR(o), stdMinDistR(o), pathLengthsR{o}, pathsR{o}]=meanPathToIntegrator(workingSkel,edgeMatrix,skelVertNames,synVerts,integrator);
    
    
end



ORNs=leftORNs;

for o=1:length(ORNs)
    
    workingORN=ORNs(o);
    
    %Identify the positions on the PN 1 dendrite where this cell synapses
    %onto it
    
    synVertsL{o}=getSynapseVerts(workingSkel,workingORN);
    
    
    % Determine the mean min path length between these synapses and an
    % fixed, fictive "integrator" node
    
    %Define the integrator node, this is the last node of PN1s primary neurite
    integrator={'x0x39_4579'};
    
    [meanDistsL(o), stdDistL(o), pathLengthsL{o}, pathsl{o}]=meanPathToIntegrator(workingSkel,edgeMatrix,skelVertNames,synVertsL{o},integrator);
    
    
end
%% synapse distance to primary neurite is bimodally distributed, 

pathsToIntegrator=[pathLengthsL, pathLengthsR];

pLengths=[]
pGrps=[]



for i=1:length(pathsToIntegrator)
    pLengths=[pLengths, pathsToIntegrator{i}]
    pGrps=[pGrps, i*ones(1,length(pathsToIntegrator{i}))]
end

h1=figure()
hist(pLengths, 100)
xlabel('distance from synapse to primary neurite', 'FontSize', 14)
ylabel('Freq', 'FontSize', 14)
set(gcf,'color','w');
title('path length to PN1 primary neurite for all ORN input synapses')
save('ornSynPathLengthDist','h1')

h2=figure()
scatter(pGrps, pLengths)
xlabel('ORN Number', 'FontSize', 14)
ylabel('Dist to prim neurite', 'FontSize', 14)
set(gcf,'color','w');
title('path length to PN1 primary neurite for each ORN->PN synapse')
save('ornSynPathLengths','h2')

%% hists of path lengths to integrator for each ORN

figure()
hold on
for c=1:50
    subplot(10,5,c)
    hist(pathsToIntegrator{c},20)
     xlim([0 100])
     ylim([0 200])
end
    
    
   

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

mkdir('ORNSynShuffSim/')
cd('ORNSynShuffSim/')
save('shuffMeanDists', 'shuffMeanDists')
save('shuffStdDist', 'shuffStdDist')
save('shuffPathsToIntegrator', 'shuffPathsToIntegrator')
save('paths','paths')



%% box plot meanMinDists for L and R ORNs
h3=figure()
meanDistsLR=[meanDistsL,meanMinDistsR]
lrGrps=[zeros(1,length(meanDistsL)),ones(1,length(meanMinDistsR))];
boxplot(meanDistsLR,lrGrps, 'labels',{'ipsi ORNs','contra ORNs'})
set(gcf,'color','w');
ylabel('mean distance to end of primary neurite', 'FontSize', 14)
save('ipsiContraMeanPathLengths', 'h3')


%% I want to sort paths based on length then create a vector containing the number of shared nodes w/ the longest path for each path


for i=1:length(pathsR)
    
    for j=1:length(pathsR{i})
        
        pLengthsForSort(i,j)=length(pathsR{i}{j});
        
    end
end
    
    [M,I]=max(pLengthsForSort,[],2)
      [M2,I2]=max(M)
      
      maxPath=pathsR{I2}{I(19)};
      
      
% for each path determine the number of shared nodes with the longest path 
counter=1;

%for each ORN
for i=1:length(pathsR)
    
    %And for each of its synapses
    for j=1:length(pathsR{i})
        
        %Find the node at which it divergest from the longest path from a R
        %ORN synapse to integrator
        
        k=0;
        
        while strcmp(pathsR{i}{j}(length(pathsR{i}{j})-k),maxPath(length(maxPath)-k)) == 1
            k=k+1;
            
            if k == length(pathsR{i}{j})
                
                break
            else
                
            end
        end
        %store the name of the first vertex beyond the divergence along the
        %max path and the number of shared path nodes for each path
        if (length(maxPath)-k)==0
            divNodeR(counter)={nan};
            sharedNodesR(counter)=k;
            counter=counter+1;
        else
            divNodeR(counter)=maxPath(length(maxPath)-k);
            sharedNodesR(counter)=k;
            pLengthsR(counter)=pathLengthsR{i}(j);
            counter=counter+1;
        end
        
    end
end

%
% for each path determine the number of shared nodes with the longest path 
counter=1;

%for each ORN
for i=1:length(pathsl)
    
    %And for each of its synapses
    for j=1:length(pathsl{i})
        
        %Find the node at which it divergest from the longest path from a R
        %ORN synapse to integrator
        
        k=0;
        
        while strcmp(pathsl{i}{j}(length(pathsl{i}{j})-k),maxPath(length(maxPath)-k)) == 1
            k=k+1;
            
            if k == length(pathsl{i}{j})
                
                break
            else
                
            end
        end
        %store the name of the first vertex beyond the divergence along the
        %max path and the number of shared path nodes for each path
        if (length(maxPath)-k)==0
            divNodeL(counter)={nan};
            sharedNodesL(counter)=k;
            counter=counter+1;
        else
            divNodeL(counter)=maxPath(length(maxPath)-k);
            sharedNodesL(counter)=k;
            pLengthsL(counter)=pathLengthsL{i}(j);
            counter=counter+1;
        end
        
    end
end


h4=figure()
scatter(pLengthsR, sharedNodesR,'r')
hold on
scatter(pLengthsL, sharedNodesL, 'b')

xlabel('Path Length to Primary Neurite (nm)', 'FontSize', 14)
ylabel('nodes shared with path to most distant contra synapse', 'FontSize', 14)
set(gcf,'color','w');
legend('Contra ORNs', 'Ipsi ORNs')

save('pathLengthDivergence','h4')
   
%%


figure()

for i=1:length(branchesR)
    
    subplot(2,4,i)
% hist(vertsSharedWLongestL(find(vertsSharedWLongestL~=0)), 200)
[n1,p1]=hist(distalDomain{i},100);
[n2,p2]=hist(proximalDomain{i},100);
bar(p1,n1);hold on;bar(p2,n2, 'r')

end

