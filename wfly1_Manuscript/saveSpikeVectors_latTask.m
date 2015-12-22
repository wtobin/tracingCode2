function [] = saveSpikeVectors_latTask( totSynapseNums,activeSynsL, activeSynsR,spikeTimesL, spikeTimesR, p )
%saveSpikeVectors
%{
totSynapseNums - a list of the spikeVector file numbers that every contact
in the hoc file looks to for its firing pattern

activeSyns - generated by pullContNums described there as the output
"contacts"

spikeTimes - a list of spike times for each skeleton in activeSyns

p - path to the directory in which spike vector files will be saved

%}


%Save a file for every synapse in the simulation. The files associated
%with the active skeletons should contain the times from spikeTimes
%while all other files are blank

for f=1:numel(totSynapseNums)
    
    s=totSynapseNums(f);
    
    if ismember(s,activeSynsL(:,1))
        
        
        % If there are no spikes, dont try to write the
        % empty spikeTimes array, it snarls nrn. [] seems to
        % do fine?
        
        if isempty(spikeTimesL{activeSyns(find(activeSyns(:,1) == s),2)}) == 1
            
            vector=[];
            save([p,'/spikeVector',num2str(totSynapseNums(f)),'.txt'],'vector','-ascii')
            
        else
            
            vector=spikeTimesL{activeSyns(find(activeSyns(:,1) == s),2)};
            save([p,'/spikeVector',num2str(totSynapseNums(f)),'.txt'],'vector','-ascii')
            
        end
        
    elseif ismember(s,activeSynsR(:,1))
         % If there are no spikes, dont try to write the
        % empty spikeTimes array, it snarls nrn. [] seems to
        % do fine?
        
        if isempty(spikeTimesR{activeSyns(find(activeSynsR(:,1) == s),2)}) == 1
            
            vector=[];
            save([p,'/spikeVector',num2str(totSynapseNums(f)),'.txt'],'vector','-ascii')
            
        else
            
            vector=spikeTimesR{activeSyns(find(activeSyns(:,1) == s),2)};
            save([p,'/spikeVector',num2str(totSynapseNums(f)),'.txt'],'vector','-ascii')
            
        end
        
    else
        
        vector=[];
        save([p,'/spikeVector',num2str(totSynapseNums(f)),'.txt'],'vector','-ascii')
        
    end
end

end

