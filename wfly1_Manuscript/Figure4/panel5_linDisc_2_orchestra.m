%% Load annotations

%Add my matlab dir to the path 
addpath(genpath('/home/wft2/Matlab'));

% Load annotations json. Generated by Wei's code gen_annotation_map.py
annotations=loadjson('~/tracing/sid_by_annotation.json');

% Return all skeleton IDs for R and L ORNs

ORNs_Left=annotations.Left_0x20_ORN;
ORNs_Right=annotations.Right_0x20_ORN;

ORNs=[ORNs_Left, ORNs_Right];

PN_Names={'PN1LS','PN2LS', 'PN3LS', 'PN1RS', 'PN2RS'};

%% Create Dirs for detection simulation 

for p=1:numel(PN_Names)
    
    PN=PN_Names(p);
    
%Move to the PN project directory
cd(['~/nC_projects/',PN,'_allORNs/'])


%make a dir in simulations called detTask
system('mkdir simulations/detTask')


% Copy the contents of the generatedNEURON dir to detTask
system('cp -a generatedNEURON/. simulations/detTask/')


%path to the dir containing the hoc files to be run
path1=['/home/wft2/nC_projects/',PN,'_allORNs/simulations/detTask/'];
cd(path1)

%copy vecEvent.mod to this Dir
system('cp /groups/htem/code/neuron/nrn/share/examples/nrniv/netcon/vecevent.mod ./')

%Compile mod files in this Dir
system('/groups/htem/code/neuron/nrn/bin/nrnivmodl')

%run Orchestra version of hocEdsv2 on the hoc file
hocEdCmd=['python ../../../hocEdsv2_Orchestra.py ',PN,'_allORNs.hoc ', PN,'_allORNs'];
system(hocEdCmd)

%replace any remaining paths for the simulation computer with orchestra
%path
system(['sed -i -e ''s#\/home\/simulation\/#\/home\/wft2\/#'' ', PN,'_allORNs.hoc'])

%Set initial Vm
initVm=-59.4; %in mv
runVCmd=['sed -i -e ''s#v\s\=\s\-65\.\0#v = \',num2str(initVm),'#'' ', PN,'_allORNs.hoc'];
system(runVCmd)

%Setsim duration
runTime=200; %in ms
runTCmd=['sed -i -e ''s#tstop\s\=\s.*#tstop \= ',num2str(runTime),'#'' ',PN,'_allORNs.hoc'];
system(runTCmd)

%Define the number of repetitions I want each job to run
reps=100;



%Make a file that I will write nrn run commands to 

for f=1:parReps
    
    %make a copy of the hoc file
    hocCpName=[PN, '_', num2str(f) , '.hoc ' ];
    cpCmd=['cp ',PN, '_151125.hoc ',hocCpName ];
    system(cpCmd);
    
    % make a spikeVector dir for this sim
    svDirName=['spikeVectors_',num2str(f)];
    mkSVDirCmd=['mkdir ../../',svDirName];
    system(mkSVDirCmd);
    
    % Change the hoc file code to look to this spikeVector dir
    chngSVDirCmd=['sed -i -e ''s#spikeVectors#',svDirName,'#'' ',hocCpName];
    system(chngSVDirCmd)
    
    
    %path to the dir containing the spikeVectors that specify this models
    %activity
    path2=['/home/wft2/nC_projects/',PN,'_linDisSim/',svDirName];
    
    %Is this model running spontaneous or driven activity?
    trType=ctgs(f);
    
    
    %Fill the directory with spontaneous or driven spikes according to the
    %corresponding value in ctgs
    
    %Clear the spike trains/times variables
    clear spikeTrain
    clear spikeTimes
    
    
    if trType == 1
        
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
    
    %add a
    
end




%Running reps

for rep=1:1000
    tic
    
    %initilize array to hold the synapse numbers activated in this
    %sim. It will be a 2d array in which one column hold synapse
    %numbers and the other holds a number which identifies the ORN
    %the syn came from
    
    
    
    %I want to run the simulation
    
    runCmd=['/groups/htem/code/neuron/nrn/x86_64/bin/nrniv ', PN, '_151125.hoc'];
    system(runCmd);
    
    
    %I want to import the PNs simulated voltage trace
    
    
    %find its name
    pnResults=dir('neuron_PN*.dat');
    
    pnVm1=importdata(pnResults.name);
    
    %PN voltage storage
    pnVms(p,dFCount,t,rep,:)=pnVm1;
    
    
    toc
end

% Calculate the mean voltage for all reps
vmMeans(p,dFCount,t,:)=mean(squeeze(pnVms(p,dFCount,t,:,4000:end))');





% Train a discriminant object on of the sets of repetitions and test it
% on the other


predictors=squeeze(vmMeans(p,dFCount,1,:));
categories=squeeze(ctg(p,dFCount,1,:));

cls = fitcdiscr(predictors,categories);


K=cls.Coeffs(1,2).Const;
L=cls.Coeffs(1,2).Linear;

thresh=-K/L;

%see how well it did on the training data

performance(p,dFCount,1)=(sum(categories(find(predictors<thresh))== 1)+...
    sum(categories(find(predictors>thresh))== 2))/numel(categories)


%see how well it did on the test data
performance(p,dFCount,2)= (sum(ctg(p,dFCount,2,find(vmMeans(p,dFCount,2,:)< thresh))==1)+...
    sum(ctg(p,dFCount,2,find(vmMeans(p,dFCount,2,:)> thresh))==2))/numel(ctg(p,dFCount,2,:))


dFCount=dFCount+1;


%% Save some stuff

save('disrimSim_realCon_Cat','ctg')
save('disrimSim_realCon_pnVms','pnVms')
save('disrimSim_realCon_meanVms','vmMeans')