%The goal of this piece of code is to change PN model parameters to Gouwens & Wilson cell #1 and rerun
%the mini and unitary analyses

%% setup the simulation folder and modify the  NEURON text files

for p = 1:5
   
PN_Names={'PN1LS','PN2LS', 'PN3LS', 'PN1RS', 'PN2RS'};
PN=cell2mat(PN_Names(p)); 

%Move to the PN  project directory
cd(['~/nC_projects/',PN,'_allORNs/'])

%make a dir in simulations called detTask
system('mkdir simulations/cell2Parms')

 %path to the dir containing the hoc files to be run
path1=['~/nC_projects/',PN,'_allORNs/simulations/cell2Parms/'];
cd(path1)
 

% Copy the contents of the generatedNEURON dir to detTask
system('cp -a ../../generatedNEURON/. ./')

% Copy the synaptic conductance model that has been tuned to these parms
% into this dir
system('cp -a ../../../PN1LS_allORNs/simulations/cell2ParmsCondAdj/DoubExpSynA.mod ./')

%get the neuron hoc file name
neuronFileName=dir('neuron*.hoc');
neuronFileName=neuronFileName.name;

%replace the value for axial resistance in the neuron hoc file 
Ra=102.5 ; %in ohm*cm
chngRaCmd=['sed -i -e ''s#Ra = 266.1#Ra = ',num2str(Ra),'#'' ',neuronFileName];
system(chngRaCmd)


%replace the value for specific membrane capacitance in the neuron hoc file 
cm=1.5 ; %in uF*cm^-2
chngCmCmd=['sed -i -e ''s#cm = 0.8#cm = ',num2str(cm),'#'' ',neuronFileName];
system(chngCmCmd)

%replace the value for gmax of leak conductance in the neuron hoc file 
gmax=1/(20.4*1000) ; %in uF*cm^-2
%multiplication of gmax here is simply to match the format in the neuron
%file, I hardcode the E-4
chngGmaxCmd_nrnFile=['sed -i -e ''s#gmax_LeakConductance = 4.8E-5#gmax_LeakConductance = ',num2str(gmax*100000,2),'E-5#'' ',neuronFileName];
system(chngGmaxCmd_nrnFile)

%replace the value for gmax in the LeakConductance.mod file 
gmax=1/(20.4*1000) ; %in uF*cm^-2
chngGmaxCmd=['sed -i -e ''s#gmax = 0.000048#gmax = ',num2str(gmax,'%10f'),'#'' LeakConductance.mod'];
system(chngGmaxCmd)

%replace the value for gmax in the LeakConductance.mod file, this value is
%listed at the top of the file in different units and should be written
%over but I am going to change it anyway
gmax=1/(20.4) ; %in ?
chngGmaxCmd=['sed -i -e ''s#gmax = 0.048#gmax = ',num2str(gmax,'%10f'),'#'' LeakConductance.mod'];
system(chngGmaxCmd)

%Compile mod files in this Dir
system('nrnivmodl')

%run hocEd3 on the sim hoc file, ?sets up unitary simulation
hocEdCmd=['python ../../../hocEd3.py ',PN,'_allORNs.hoc '];
system(hocEdCmd)

%replace the simsDirPath
system(['sed -i -e ''s#\/simulations\/#\/simulations\/cell2Parms\/#'' ', PN,'_allORNs.hoc'])


% make a directory to store the results
system('mkdir unitaries')

%replace the simReference file
system(['sed -i -e ''s#"Sim_1"#"unitaries"#'' ', PN,'_allORNs.hoc'])


%Set initial Vm
initVm=-60; %in mv
runVCmd=['sed -i -e ''s#v\s\=\s\-65\.\0#v = \',num2str(initVm),'#'' ', PN,'_allORNs.hoc'];
system(runVCmd)


%Setsim duration
runTime=11000; %in ms
runTCmd=['sed -i -e ''s#tstop\s\=\s.*#tstop \= ',num2str(runTime),'#'' ',PN,'_allORNs.hoc'];
system(runTCmd)

% Run the simulation
system(['nrniv ',PN,'_allORNs.hoc'])


end