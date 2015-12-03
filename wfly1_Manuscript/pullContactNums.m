function [ contacts ] = pullContactNums(skelIDs, path1, path2)
%pullContactNums Args:
% skelIDs - list of skeleton IDs that synapse onto the PN being simulated
% path1 - path to the dir containing the hoc file that specifies the simulation( modified by hocEdsv2.py)
% path2 - path to the dir containg the spikeVectors that will be used to
% specifify synapse activity in the sim


%It will return an array whose first column contains the
%number of the spikeVector file this contact receives and the second
%column contains a number idicating which SkelID it is associated with.

startingDir=pwd;

cd(path1)

%Find the name of the hoc file, must start w/ "PN"

tmp=dir('PN*.hoc');
hocFile=tmp.name;


counter =1;
contacts=[];

for sk=1:length(skelIDs)
    
    grepCommand=['grep -oP ''', num2str(skelIDs(sk)),'\[\d*\].ropen\("',path2,'/spikeVector\K\d*'' ' , hocFile];
    
    
    %         [status, synapseNumsR{ro}]=system(grepCommand);
    %         synapseNumsR{ro}=unique(str2num(synapseNumsR{ro}));
    
   counter=0;
   
    for i=1:10000
        
    [status, synsW]=unix(grepCommand);
    synsW=str2num(synsW);
    
%     [status, synsW2]=unix(grepCommand);
%     synsW2=str2num(synsW2);
%     
%     if numel(synsW) ~= numel(synsW2)
%        counter=counter+1; 
%     else
%     end
%     
%     end
%     
    % For some reason i cant figure out, synsW is returned empty and when
    % the grep command is run again it comes back doubled..???
    
%    while isempty(synsW)==1
%        
%     [status, synsW]=system(grepCommand);
%     synsW=str2num(unique(synsW));
%     
%    end
%     
    contacts=[contacts; [synsW,counter*ones(numel(synsW),1)]];
    counter=counter+1;
    synsW=[];
    
end

cd(startingDir)



end
