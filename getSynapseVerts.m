function [ synVerts ] = getSynapseVerts( postSkel, preID )
% getSynapsePos accepts a post-synaptic skeleton structure, produced
% by loading a skeleton file with loadjson, and a presynaptic skeleton ID.
% It returns a list of fieldnames for postSkel.verticies that correspond to
% verticies where postSkel receives input from preID. 

% Assumes tracing data files are located in ~/tracing

%move to tracing directory
cd('~/tracing')

%load connectors matrix
load('conns.mat');

workingSkel=postSkel;

%generate a list of nodes that form some kind of connection
nodesWithConnections=fieldnames(workingSkel.connectivity);

%counter for number of synapses from preID onto postSkel
counter=1;

%loop over connected nodes
for i=1:length(nodesWithConnections)
    
    
    %create a list of partner nodes
    connectedTo=fieldnames(workingSkel.connectivity.(cell2mat(nodesWithConnections(i))));
    
    %loop over partner nodes
    for j=1:length(connectedTo)
        
        %looking for nodes presynaptic to working postSkel node
        if strcmp(workingSkel.connectivity.(cell2mat(nodesWithConnections(i))).(cell2mat(connectedTo(j))).type, 'presynaptic_to')==1
            
            %check whether the presynaptic neuron is preID
            if conns.(cell2mat(connectedTo(j))).pre == preID
                
                %if so record the location of the postSkel node that recieves
                %this input
                synVerts(counter)=nodesWithConnections(i);
               
              
                counter=counter+1;
            else
            end
            
        else
            
        end
    end
end



end


