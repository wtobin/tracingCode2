function [ edgeMatrix, skelVertNames ] = getSkelAdjMat_DB( workingSkel )
% This function accepts a skeleton structure that has been loaded into the
% workspace using the loadjson function. It returns an adjacency matrix
%idicating the connectivity pattern among the nodes of the skeleton. A zero
%in the adjacency matrix indicates that two nodes are not connected while a
%1 indicates a connection. Additionally, the function returns a list of
%workingSkel node field names in the order that they are represented in the
%adjacency matrix.


% I want the adjacency matrix to be NxN where N is the number of skeleton
% nodes. Here I will generate a vector containing the indicies of skel
% nodes in the workingSkel.verticies list.


%create a cell array of skeleton node names

vertNames=fieldnames(workingSkel.vertices);

counter=1;
for v=1:length(vertNames)
    if strcmp(workingSkel.vertices.(cell2mat(vertNames(v))).type, 'skeleton')==1
        
        % exclude the soma node because it is not found in the
        % workingSkel.connectivity list. *** I dont know why or whats happening
        % there ***
        
        if strcmp(workingSkel.vertices.(cell2mat(vertNames(v))).labels,'soma')==1
        else
            
            skelVertInds(counter)=v;
            counter=counter+1;
        end
        
    else
    end
end

%Generate a list of skeleton node fieldnames
skelVertNames=vertNames(skelVertInds);

%initialize the adjacency matrix
edgeMatrix=zeros(length(skelVertNames));



% loop over all skeleton nodes
for v=1:length(skelVertNames)
    
    % Look up and store what nodes the working node is connected to
    wConNodes=workingSkel.connectivity.(cell2mat(skelVertNames(v)));
    wConNames=fieldnames(wConNodes);
  
    
    %loop over the connected nodes
    for c=1:length(wConNames)
        
        % Once again, the soma node is snarling up my code for some reason
        % and will be excluded
        
        if strcmp(workingSkel.vertices.(cell2mat(wConNames(c))).labels,'soma')==1
        else
            
            
            % Find connections between skeleton nodes
            if strcmp(wConNodes.(cell2mat(wConNames(c))).type, 'neurite') == 1
                
                % Find their location in the skelVertNames list
                
                p=find(strcmp(skelVertNames,wConNames(c)));
                %
                %             %calculate their euclidean distance and store it in the
                %             %adjacency matrix
                %
                %             points(1,1)=workingSkel.vertices.(cell2mat(skelVertNames(v))).x;
                %             points(1,2)=workingSkel.vertices.(cell2mat(skelVertNames(v))).y;
                %             points(1,3)=workingSkel.vertices.(cell2mat(skelVertNames(v))).z;
                %
                %             points(2,1)=workingSkel.vertices.(cell2mat(skelVertNames(p))).x;
                %             points(2,2)=workingSkel.vertices.(cell2mat(skelVertNames(p))).y;
                %             points(2,3)=workingSkel.vertices.(cell2mat(skelVertNames(p))).z;
                %
                %             dist=pdist(points);
                
                
                %             edgeMatrix(v,p)=dist;
                edgeMatrix(v,p)=1;
                
                
            else
            end
            
        end
    end
end

% %This loop makes the connectivity matrix symetrical about the diagonal.
% Generates an undirected adjacency matrix

% for i=1:size(edgeMatrix,1)
%
%     edgeMatrix(i,:)=edgeMatrix(i,:)+edgeMatrix(:,i)';
%     edgeMatrix(:,i)=edgeMatrix(i,:)'+edgeMatrix(:,i);
% end




end

