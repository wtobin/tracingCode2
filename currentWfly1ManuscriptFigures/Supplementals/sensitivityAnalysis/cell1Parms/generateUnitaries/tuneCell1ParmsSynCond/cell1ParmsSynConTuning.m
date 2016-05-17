%The goal of this piece of code is to adjust the modeled synaptic
%conductance to match EPSP amplitude between models with different
%parameters

%% setup the simulation folder and modify the  NEURON text files



   
PN='PN1LS';

%Move to the PN1 LS project directory
cd(['~/nC_projects/',PN,'_allORNs/'])

%make a dir in simulations called detTask
system('mkdir simulations/cell1ParmsCondAdj')

 %path to the dir containing the hoc files to be run
path1=['~/nC_projects/',PN,'_allORNs/simulations/cell1ParmsCondAdj/'];
cd(path1)
 
% Copy the contents of the Cell1Parms dir to this dir
system('cp -a ../cell1Parms/. ./')

%run the first 300ms of the simulation

%Setsim duration
runTime=10500; %in ms
runTCmd=['sed -i -e ''s#tstop\s\=\s.*#tstop \= ',num2str(runTime),'#'' ',PN,'_allORNs.hoc'];
system(runTCmd)

%replace the simReference file
system(['sed -i -e ''s#"unitaries"#"output"#'' ', PN,'_allORNs.hoc'])

%replace the simsDirPath
system(['sed -i -e ''s#\/simulations\/cell1Parms\/#\/simulations\/cell1ParmsCondAdj\/#'' ', PN,'_allORNs.hoc'])

%make output directory

system('mkdir output')

% Run the simulation
system(['nrniv ',PN,'_allORNs.hoc'])

%Import the resulting uEPSP
testP=load('./output/neuron_PN1_LS_sk_419138_0.dat');

%Calculate the percent difference between this max amp and that w/ cell3
%parms
discrep=((max(testP)+60)/(5.0819))-1;

while abs(discrep)>0.005

% Pull gmax value from the DoubExpSynA.mod file
[s, gmax]=system('grep -oP ''gmax = \K.*'' DoubExpSynA.mod');


%replace this value w/ ascaled version based on the diff value calculated
%above

new_gmax=str2num(gmax)+((-discrep)*str2num(gmax))
chngGCmd=['sed -i -e ''s#gmax = ',gmax(1:end-1),'#gmax = ',num2str(new_gmax),'#'' DoubExpSynA.mod'];
system(chngGCmd)

%Compile mod files in this Dir
system('nrnivmodl')

% Run the simulation
system(['nrniv ',PN,'_allORNs.hoc'])

%Import the resulting uEPSP
testP=load('./output/neuron_PN1_LS_sk_419138_0.dat');

%Calculate the percent difference between this max amp and that w/ cell3
%parms
discrep=((max(testP)+60)/(5.0819))-1;

end

system('cp DoubExpSynA.mod ../cell1Parms/')
