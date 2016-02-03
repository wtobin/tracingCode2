function [ contacts ] = pullContactNums(skelIDs, path1, hocFile)
%pullContactNums Args:
% skelIDs - list of skeleton IDs that synapse onto the PN being simulated
% path1 - path to the sim dir containing hocFile
% hocFile - name of the hoc file containing the contacts whose vecFile nums
% you are pulling

%It will return an array whose first column contains the
%number of the spikeVector file this contact receives and the second
%column contains a number idicating which SkelID it is associated with.

startingDir=pwd;

cd(path1)

%Find the name of the hoc file, must start w/ "PN"

counter =1;
contacts=[];

for sk=1:length(skelIDs)
    
    grepCommand=['grep -oP ''', num2str(skelIDs(sk)),'\[\d*\].ropen\(".*/spikeVector\K\d*'' ' , hocFile];
    
    
    %         [status, synapseNumsR{ro}]=system(grepCommand);
    %         synapseNumsR{ro}=unique(str2num(synapseNumsR{ro}));
    

        
    
  % A hacky solution to the weird problem that sometimes the system call
  % returns a truncated output
  
    [status, synsW]=system(grepCommand);
    synsW=str2num(synsW);
    
    [status, synsW2]=system(grepCommand);
    synsW2=str2num(synsW2);
    
   while numel(synsW) ~= numel(synsW2)
      
       [status, synsW]=system(grepCommand);
       synsW=str2num(synsW);
       
       [status, synsW2]=system(grepCommand);
       synsW2=str2num(synsW2);
       
   
    end
    
   
    contacts=[contacts; [synsW,counter*ones(numel(synsW),1)]];
    counter=counter+1;
    synsW=[];
    
end

cd(startingDir)



end

