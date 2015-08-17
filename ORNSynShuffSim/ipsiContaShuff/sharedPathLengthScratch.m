



% Loop over PNs
for p=1:length(realPathsL)
    
    %Loop over Left ORN inputs to each PN
    for o=1:length(realPathsL{p})
        o
        % Loop over all synapses for each ORN
        for s=1:length(realPathsL{p}{o})
            tic
            workingPath=realPathsL{p}{o}{s};
            counter=1;
            %Compare the path to this synapse to all other paths to this
            %neurons synapses. Im doing this with a loop so we loop over all
            %synapses again
            for c=1:length(realPathsL{p}{o})
                
                % We dont want to compare the working synapses path to itself
                if c == o
                    
                else
                    
                    %store the path for comparison
                    comparisonPath=realPathsL{p}{o}{c};
                    
                    %Determine which path is smaller
                    
                    if numel(workingPath)>=numel(comparisonPath)
                        
                        t=0;
                        
                        
                        % Find the step at which the working and comparison paths
                        % diverge
                        
                        while strcmp(workingPath(end-t),comparisonPath(end-t)) == 1
                            
                            t=t+1;
                            
                            % if t has reached the end of the smaller path exit the
                            % while loop and record t
                            if t == numel(comparisonPath)
                                break
                            else
                            end
                            
                            
                        end
                        
                        realDiver{p,o}(s,counter)=t+1;
                        counter=counter+1;
                        
                    
                    
                else
                    t=0;
                    
                    
                    % Find the step at which the working and comparison paths
                    % diverge
                    
                    while strcmp(workingPath(end-t),comparisonPath(end-t)) == 1
                        t=t+1;
                        % if t has reached the end of the smaller path exit the
                        % while loop and record t
                        
                        if t == numel(workingPath)
                            break
                        else
                        end
                        
                    end
                    
                    realDiver{p,o}(s,counter)=t+1;
                    counter=counter+1;
                    
                end
            end
           
        end
    end
end
end

%pool all shared path lengths for all ORN synapses onto PN 1. real data
realPooled=[];
for p=1:size(realDiver,2)
    realPooled=[pooled;realDiver{3,p}(:)];
end

%Plot histo of each ORNs shared path lengths
for p=1:5
    figure()
for i=1:25
    subplot(5,5,i)
    hist(realDiver{p,i}(:))
    xlim([100 600])
end
end


%Now I want to make a comparison to the shuffled data

%Son of bitch! Paths didnt save during the shuffle

allShuffPaths=load('pathsL.mat');

for rep=1:10
   rep
    shuffPathsL=allShuffPaths.;
    
   %Loop over Left ORN inputs to each PN
    
    for o=1:length(shuffPathsL)
       
        % Loop over all synapses for each ORN
        for s=1:length(shuffPathsL{o})
            tic
            workingPath=shuffPathsL{o}{s};
            counter=1;
            %Compare the path to this synapse to all other paths to this
            %neurons synapses. Im doing this with a loop so we loop over all
            %synapses again
            for c=1:length(shuffPathsL{p}{o})
                
                % We dont want to compare the working synapses path to itself
                if c == o
                    
                else
                    
                    %store the path for comparison
                    comparisonPath=shuffPathsL{p}{o}{c};
                    
                    %Determine which path is smaller
                    
                    if numel(workingPath)>=numel(comparisonPath)
                        
                        t=0;
                        
                        
                        % Find the step at which the working and comparison paths
                        % diverge
                        
                        while strcmp(workingPath(end-t),comparisonPath(end-t)) == 1
                            
                            t=t+1;
                            
                            % if t has reached the end of the smaller path exit the
                            % while loop and record t
                            if t == numel(comparisonPath)
                                break
                            else
                            end
                            
                            
                        end
                        
                        realDiver{p,o}(s,counter)=t+1;
                        counter=counter+1;
                        
                    
                    
                else
                    t=0;
                    
                    
                    % Find the step at which the working and comparison paths
                    % diverge
                    
                    while strcmp(workingPath(end-t),comparisonPath(end-t)) == 1
                        t=t+1;
                        % if t has reached the end of the smaller path exit the
                        % while loop and record t
                        
                        if t == numel(workingPath)
                            break
                        else
                        end
                        
                    end
                    
                    realDiver{p,o}(s,counter)=t+1;
                    counter=counter+1;
                    
                end
            end
           
        end
    end
end
    
end



