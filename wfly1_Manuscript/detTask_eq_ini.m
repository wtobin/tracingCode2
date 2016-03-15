%{
DetTask initialization commands. These should be run for each PN once
before running the detTask simulations. PLEASE READ OVER/THINK CAREFULLY,
THIS CODE IS A ROUGH DRAFT HARD CODED FOR PN1LS

%}

%% Load annotations

% Load annotations json. Generated by Wei's code gen_annotation_map.py
annotations=loadjson('~/tracing/sid_by_annotation.json');

% Return all skeleton IDs for R and L ORNs

ORNs_Left=annotations.Left_0x20_ORN;
ORNs_Right=annotations.Right_0x20_ORN;

ORNs=[ORNs_Left, ORNs_Right];



%%

for i = 1:5
   
PN_Names={'PN1LS','PN2LS', 'PN3LS', 'PN1RS', 'PN2RS'};
PN=cell2mat(PN_Names(i)); 

%Move to the PN1 LS project directory
cd(['~/nC_projects/',PN,'_allORNs/'])

%make a dir in simulations called detTask
system('mkdir simulations/detTask_eq')

 %path to the dir containing the hoc files to be run
path1=['/home/wft2/nC_projects/',PN,'_allORNs/simulations/detTask_eq/'];
cd(path1)
 

% Copy the contents of the generatedNEURON dir to detTask
system('cp -a ../../generatedNEURON_detTaskEq/. ./')

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
initVm=-60; %in mv
runVCmd=['sed -i -e ''s#v\s\=\s\-65\.\0#v = \',num2str(initVm),'#'' ', PN,'_allORNs.hoc'];
system(runVCmd)


%Setsim duration
runTime=400; %in ms
runTCmd=['sed -i -e ''s#tstop\s\=\s.*#tstop \= ',num2str(runTime),'#'' ',PN,'_allORNs.hoc'];
system(runTCmd)

end