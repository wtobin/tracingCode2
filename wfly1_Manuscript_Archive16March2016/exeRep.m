function [ output_args ] = exeRep( rep)
%This function moves to a dir, specified by path, containing a PN
%simulation hoc file and all other necessary files. It then copies the hoc
%file, edits it to refer to a specific spikeVector dir and results dir.
%Currently it fills the spike vector dir with spontaneous activity for 

%Add my matlab dir to the path 
addpath(genpath('/home/wft2/Matlab'));

PN_Names={'PN1LS','PN2LS', 'PN3LS', 'PN1RS', 'PN2RS'};

PN=cell2mat(PN_Names(1));

%path to the dir containing the hoc files to be run
path1=['/home/wft2/nC_projects/',PN,'_allORNs/simulations/convergTest/'];
cd(path1)

loopsPerRep=150;

%I need a loop right here that will repeat this ~35 times
for i= rep*loopsPerRep-loopsPerRep+1:rep*loopsPerRep

%make a copy of the hoc file
hocCpName=[PN, '_', num2str(i) , '.hoc ' ];
cpCmd=['cp ',PN, '_allORNs.hoc ',hocCpName ];
system(cpCmd);

%find the spike Vector file Number each synapse looks to for its
%activity
grepCommand=['grep -oP ''spikeVector\K\d*'' ' , hocCpName];
[status, totSynapseNums]=system(grepCommand);
totSynapseNums=str2num(totSynapseNums);

% Load annotations json. Generated by Wei's code gen_annotation_map.py
annotations=loadjson('~/tracing/sid_by_annotation.json');

% Return all skeleton IDs for R and L ORNs
ORNs_Left=annotations.Left_0x20_ORN;

% Find synapse ids for all ipsi ORN synapses
activeSyns=[];
activeSyns=pullContactNums(ORNs_Left,path1);

% make a spikeVector dir for this sim
svDirName=['spikeVectors_',num2str(i)];
mkSVDirCmd=['mkdir ../../',svDirName];
system(mkSVDirCmd);

% Change the simReference = line in the hoc file and simsDir
simName='convergTest';
simRefCmd=['sed -i -e ''s/simReference\s\=\s\".*\"/simReference \= \"',simName,'\"/'' ',hocCpName];
system(simRefCmd)

% Change the hoc file code to look to this spikeVector dir
chngSVDirCmd=['sed -i -e ''s#spikeVectors#',svDirName,'#'' ',hocCpName];
system(chngSVDirCmd)

%Set the name of the directory to which the results will be saved
mkdir(['cnvTestResults',num2str(i)])
chngResDir=['sed -i -e ''s#{ sprint(targetDir, "%s%s/", simsDir, simReference)}#targetDir="',path1, 'cnvTestResults',num2str(i),'/"#'' ',hocCpName];
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

for o=1:numel(unique(activeSyns(:,2)))
    
    spikeTrain(o,:)=makeSpikes(.001,2.25,.20);
    spikeTimes{o}=find(spikeTrain(o,:)==1);
    
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

end


end

