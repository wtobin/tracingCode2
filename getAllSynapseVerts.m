function [ synVerts ] = getAllSynapseVerts( skel, inOrOut )
% getAllSynapseVerts accepts a skeleton structure, produced
% by loading a skeleton file with loadjson, and a flag indicating whether
% locations of pre or postsynaptic contacts are desired. It will return a
% list of nodes from the skel that participate in either input or output synapses.
% inOrOut=1 for input synapses
% inOrOut=2 for output synapses

% Assumes tracing data files are located in ~/tracing

%move to tracing directory
cd('~/tracing')

%load connectors matrix
load('conns.mat');

workingSkel=skel;

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
        
        
        if inOrOut == 1
            %looking for nodes presynaptic to working postSkel node
            if strcmp(workingSkel.connectivity.(cell2mat(nodesWithConnections(i))).(cell2mat(connectedTo(j))).type, 'presynaptic_to')==1
                
                synVerts(counter)=nodesWithConnections(i);
                
                
                counter=counter+1;
            else
            end
            
        elseif inOrOut == 2
            
            if strcmp(workingSkel.connectivity.(cell2mat(nodesWithConnections(i))).(cell2mat(connectedTo(j))).type, 'postsynaptic_to')==1
                
                synVerts(counter)=nodesWithConnections(i);
                
                counter=counter+1;
                
            else
            end
            
        end
    end
    
end


end


