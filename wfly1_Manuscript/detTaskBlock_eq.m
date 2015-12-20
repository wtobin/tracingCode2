
function [] = detTaskBlock_eq( jobNum, reps, dF, PN)

%Add my matlab dir to the path 
addpath(genpath('/home/wft2/Matlab'));

%path to the dir containing the hoc files to be run
path1=['/home/wft2/nC_projects/',PN,'_allORNs/simulations/detTask/'];
cd(path1)

%I need a loop right here that will jobNumeat this ~35 times
for i= jobNum*reps-reps+1:jobNum*reps

%make a copy of the hoc file
hocCpName=[PN, '_', num2str(i) , '_TEST.hoc ' ];
cpCmd=['cp ',PN, '_allORNs.hoc ',hocCpName ];
system(cpCmd);

%find the spike Vector file Number each synapse looks to for its
%activity
grepNumCommand=['grep -oP ''spikeVector\K\d*'' ' , hocCpName];
[status, totSynapseNums]=system(grepNumCommand);
totSynapseNums=str2num(totSynapseNums);

% Load annotations json. Generated by Wei's code gen_annotation_map.py
annotations=loadjson('~/tracing/sid_by_annotation.json');

%Load ipsi ORN skel IDs
if strcmp(PN, 'PN1RS') ==1  || strcmp(PN, 'PN2RS') ==1
    % Return all skeleton IDs for R and L ORNs
    ipsiORNs=annotations.Right_0x20_ORN;
else
    % Return all skeleton IDs for R and L ORNs
    ipsiORNs=annotations.Left_0x20_ORN;
end

% Find synapse ids for all ipsi ORN synapses
activeSyns=[];
activeSyns=pullContactNums(ipsiORNs,path1,hocCpName);


%Here is where I distribute the ipsi ORN synapses equally among all ORNs
%NEEDS TO BE TESTED

%shuffle the rows of activesyns
activeSyns=activeSyns(randperm(size(activeSyns,1),size(activeSyns,1)),:);
rem=[];

for e=1:floor(size(activeSyns,1)/numel(ipsiORNs))
    
    activeSyns(e*numel(ipsiORNs)-numel(ipsiORNs)+1:e*numel(ipsiORNs),2)=[1:numel(ipsiORNs)];
    rem(e*numel(ipsiORNs)-numel(ipsiORNs)+1:e*numel(ipsiORNs))=1;
    
end
activeSyns(sum(rem)+1:end,2)=randsample(numel(ipsiORNs),size(activeSyns,1)-sum(rem));


% make a spikeVector dir for this sim
svDirName=['spikeVectors_',num2str(i)];
mkSVDirCmd=['mkdir ../../',svDirName];
system(mkSVDirCmd);

% Change the simReference = line in the hoc file and simsDir
simName='detTask';
simRefCmd=['sed -i -e ''s/simReference\s\=\s\".*\"/simReference \= \"',simName,'\"/'' ',hocCpName];
system(simRefCmd)

% Change the hoc file code to look to this spikeVector dir
chngSVDirCmd=['sed -i -e ''s#spikeVectors#',svDirName,'#'' ',hocCpName];
system(chngSVDirCmd)

%Set the name of the directory to which the results will be saved
if ctg(ctgCounter) == 1
    resultDir=['dtResultSpon_',num2str(i)];
    
else
     resultDir=['dtResultDri_',num2str(i)];
end

mkdir(resultDir)
chngResDir=['sed -i -e ''s#{ sprint(targetDir, "%s%s/", simsDir, simReference)}#targetDir="',path1,resultDir,'/"#'' ',hocCpName];
system(chngResDir)

%path to the dir containing the spikeVectors that specify this models
%activity
path2=['/home/wft2/nC_projects/',PN,'_allORNs/',svDirName];

%Fill the directory with spontaneous or driven spikes according to the
%corresponding value in ctgs

%Clear the spike trains/times variables
clear spikeTrain
clear spikeTimes


%generate a spike train at the spon rate for all neurons
%that will be activated
if ctg(ctgCounter) == 1
        
        %generate a spike train at the spon rate for all neurons
        %that will be activated
        
        for o=1:numel(unique(activeSyns(:,2)))
            
            spikeTrain(o,:)=makeSpikes(.001,2.25,.20);
            spikeTimes{o}=find(spikeTrain(o,:)==1);
            
        end
        
    else
        
        %generate a spike train at the driven rate for all neurons
        %that will be activated
        
        for o=1:numel(unique(activeSyns(:,2)))
            
            spikeTrain(o,:)=[makeSpikes(.001,2.25,.099),makeSpikes(.001,(2.25+dF),.10)];
            spikeTimes{o}=find(spikeTrain(o,:)==1);
            
        end
        
    end


%Save a file for every synapse in the simulation. The files associated
%with the selected ORNs should contain the above generated spike times
%while all other files are blank

saveSpikeVectors(totSynapseNums,activeSyns,spikeTimes,path2)


%add a line to my script that will run this simulation
runCmd=['/groups/htem/code/neuron/nrn/x86_64/bin/nrniv ', hocCpName];
system(runCmd);


system(['rm -rf ',hocCpName])
system(['rm -rf ../../',svDirName])

ctgCounter=ctgCounter+1;

end





end
