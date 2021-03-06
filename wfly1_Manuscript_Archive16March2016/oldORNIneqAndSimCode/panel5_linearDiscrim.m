
%% The goal of the following code is to run a simulation in which 2:25 ipsi ORNs are selected
% at random and driven with a poisson spike train. The CV of spike
% counts will be calculated. Additionally, the time-averaged CV of our modeled PN
%response will also be calculated. Finally, I will give all of these ORNs
%the same number of contacts and recalculate the PN response CV

%% Load annotations

% Load annotations json. Generated by Wei's code gen_annotation_map.py
annotations=loadjson('~/tracing/sid_by_annotation.json');

% Return all skeleton IDs for R and L ORNs

ORNs_Left=annotations.Left_0x20_ORN;
ORNs_Right=annotations.Right_0x20_ORN;

%exclude unilateral ORNs for now

ORNs_Right(find(ORNs_Right == 499879))=[];
ORNs_Left(find(ORNs_Left == 426230))=[];
ORNs_Left(find(ORNs_Left == 401378))=[];
%
% %exclude ORN 8 because it was temporarily unilateral on 8/5 for testing
% ORNs_Left(find(ORNs_Left == 593865))=[];

ORNs=[ORNs_Left, ORNs_Right];

%% File handling

% I want to make a copy of each nC_projects PN directory

PN_Names={'PN1LS','PN2LS', 'PN3LS', 'PN1RS', 'PN2RS'};

for p=1:length(PN_Names)
    
    PN=PN_Names{p};
    
    % Move to the current PNs directory within the nC_Projects dir
    % Path structure for my Ubuntu machine
    cd('/home/william/nC_projects/');
    
    % First things first, I need to make a copy of the current generatedNEURON
    % directory. This is where we will be working
    
    copyFileCommand = ['cp -R ', [PN, '_151125'], ' ',[PN,'_linDisSim']];
    
    system(copyFileCommand);
    
    mkdir(['./',[PN,'_linDisSim/spikeVectors']]);
  
end

% I want to run Wei's script to copy/compile VecEvent.mod in each
% PN_linDisSim/generatedNEURON dir. Also run hocEdsv_WTMod.py on each PN.hoc
% file


for p=1:length(PN_Names)
    
    PN=PN_Names{p};
    
    % Move to the current PNs linDisSim/generatedNEURON dir
    cd(['/home/william/nC_projects/',PN,'_linDisSim/generatedNEURON']);
    
    % copy vecEvent.mod to the cur dir and compile it
    vecEventcmd='bash ../../copy_comp.sh';
    system(vecEventcmd);
    
    %run hocEdsv_WTMod.py on the PN_151125.hocfile in the cur dir. NOTE: What is
    %needed here is a modified hocED file that allows definition of the
    %path to spikeVectors dir and simRef
    
    hocModcmd=['python ../../hocEdsv2.py ', PN ,'_151125.hoc ', PN, '_linDisSim'];
    system(hocModcmd)
    
    % Change the simReference = line in the hoc file and simsDir
    simName='linDisSim';
    simRefCmd=['sed -i -e ''s/simReference\s\=\s\".*\"/simReference \= \"',simName,'\"/'' ',PN, '_151125.hoc'];
    system(simRefCmd)
    
    simDir=['/home/william/nC_projects/',PN,'_linDisSim/simulations/'];
    simRefCmd=['sed -i -e ''s#simsDir\s\=\s\".*\"#simsDir \= \"',simDir,'\"#'' ',PN, '_151125.hoc'];
    system(simRefCmd)
    
    %Set initial Vm
    initVm=-59.4; %in mv
    runVCmd=['sed -i -e ''s#v\s\=\s\-65\.\0#v = \',num2str(initVm),'#'' ',PN, '_151125.hoc'];
    system(runVCmd)
    
    
     %Setsim duration
    runTime=500; %in ms
    runTCmd=['sed -i -e ''s#tstop\s\=\s.*#tstop \= ',num2str(runTime),'#'' ',PN, '_151125.hoc'];
    system(runTCmd)
    
    % Copy the contents of the generated NEURON folder into the linDisSim dir
    mkdir(['/home/william/nC_projects/',PN,'_linDisSim/simulations/linDisSim']);
    cpCmd=['cp -a /home/william/nC_projects/',PN,'_linDisSim/generatedNEURON/. /home/william/nC_projects/',PN,'_linDisSim/simulations/linDisSim/'];
    system(cpCmd);
    
end

%% Generate the one spike distribution


% We want to run this simulation for all PNs
PN_Names={'PN1LS','PN2LS', 'PN3LS', 'PN1RS', 'PN2RS'};


for p=1%:length(PN_Names)
    
    PN=cell2mat(PN_Names(p));
    cd(['/home/william/nC_projects/',PN,'_linDisSim/simulations/linDisSim/'])
    
    
    
    %find the total number of synapses
    grepCommand=['grep -oP ''\[\d*\].ropen\("/home/william/nC_projects/',PN,'_linDisSim/spikeVectors/spikeVector\K\d*'' ' , PN,'_151125.hoc'];
    [status, totSynapseNums]=system(grepCommand);
    totSynapseNums=str2num(totSynapseNums);
    
    
    %first, just put one spike in each ipsi neuron presynaptic to this PN
    %sequentially
    

        
        if strcmp(PN, 'PN1RS') == 1 || strcmp(PN,'PN2RS') == 1 %For Right PNs
            
            
            for o=1:length(ORNs_Right)
                
                
                skelID=ORNs_Right(o);
                
                
                %Search the simulation hoc file and return the synapse numbers
                %associated with this ORN
                
                
                grepCommand=['grep -oP ''', num2str(skelID),'\[\d*\].ropen\("/home/william/nC_projects/',PN,'_linDisSim/spikeVectors/spikeVector\K\d*'' ' , PN,'_151125.hoc'];
                [status, syns]=system(grepCommand);
                syns=str2num(syns);
                
                % Save spike vector files for all synapses on this PN with a single
                % spike at the synapses from selected ORN
                
                for f=1:numel(totSynapseNums)
                    
                    s=totSynapseNums(f);
                    
                    if ismember(s,syns)
                        
                        vector=[100];
                        save(['~/nC_projects/',PN,'_linDisSim/spikeVectors/spikeVector',num2str(totSynapseNums(f)),'.txt'],'vector','-ascii')
                        
                    else
                        
                        vector=[];
                        save(['~/nC_projects/',PN,'_linDisSim/spikeVectors/spikeVector',num2str(totSynapseNums(f)),'.txt'],'vector','-ascii')
                        
                    end
                end
                
                %I want to run the simulation
                
                runCmd=['nrniv ', PN, '_151125.hoc'];
                system(runCmd);
                
                
                %I want to import the PNs simulated voltage trace
                
                %find its name
                pnResults=dir('neuron_PN*.dat');
                
                pnVm1=importdata(pnResults.name);
                
                %PN voltage storage
                oneSpikeVms{p}(o,:)=pnVm1;
            end
            
        else % For L PNs
            
            for o=1:length(ORNs_Left)
                
                {p}
                skelID=ORNs_Left(o);
                
                
                %Search the simulation hoc file and return the synapse numbers
                %associated with this ORN
                
                
                grepCommand=['grep -oP ''', num2str(skelID),'\[\d*\].ropen\("/home/william/nC_projects/',PN,'_linDisSim/spikeVectors/spikeVector\K\d*'' ' , PN,'_151125.hoc'];
                [status, syns]=system(grepCommand);
                syns=str2num(syns);
                
                % Save spike vector files for all synapses on this PN with a single
                % spike at the synapses from selected ORN
                
                for f=1:numel(totSynapseNums)
                    
                    s=totSynapseNums(f);
                    
                    if ismember(s,syns)
                        
                        vector=[100];
                        save(['~/nC_projects/',PN,'_linDisSim/spikeVectors/spikeVector',num2str(totSynapseNums(f)),'.txt'],'vector','-ascii')
                        
                    else
                        
                        vector=[];
                        save(['~/nC_projects/',PN,'_linDisSim/spikeVectors/spikeVector',num2str(totSynapseNums(f)),'.txt'],'vector','-ascii')
                        
                    end
                end
                
                %I want to run the simulation
                
                runCmd=['nrniv ', PN, '_151125.hoc'];
                system(runCmd);
                
                
                %I want to import the PNs simulated voltage trace
                
                %find its name
                pnResults=dir('neuron_PN*.dat');
                
                pnVm1=importdata(pnResults.name);
                
                %PN voltage storage
                oneSpikeVms(p,o,:)=pnVm1;
                
                
            end
            
            
        end
        
        oneSpikeMeans(p,:)=mean(oneSpikeVms,3);
        
end
    

    

     
%% Generate the two spike distribution

% We want to run this simulation for all PNs



for p=1%:length(PN_Names)
    
    PN=cell2mat(PN_Names(p));
    cd(['/home/william/nC_projects/',PN,'_linDisSim/simulations/linDisSim/'])
    
    
    
    %find the total number of synapses
    grepCommand=['grep -oP ''\[\d*\].ropen\("/home/william/nC_projects/',PN,'_linDisSim/spikeVectors/spikeVector\K\d*'' ' , PN,'_151125.hoc'];
    [status, totSynapseNums]=system(grepCommand);
    totSynapseNums=str2num(totSynapseNums);
    
    
    % Randomly pull 2 ORNs from the ipsi pool and put a spike in each at a
    % random time in the trial
    for rep=1:25
        tic
        %initilize array to hold the synapse numbers activated in this
        %sim. It will be a 2d array in which one column hold synapse
        %numbers and the other holds a number which identifies the ORN
        %the syn came from
        
        activeSyns=[];
        
        % pick 2 ORNs at random, from the ipsi ORN pool
        
        if strcmp(PN, 'PN1RS') == 1 || strcmp(PN,'PN2RS') == 1 %For Right PNs
            
            skelIDsR=randsample(ORNs_Right,2);
            
            %Search the simulation hoc file and return the synapse numbers
            %associated with each of these ORNs
            counter =1;

            
            for ro=1:length(skelIDsR)
                
                grepCommand=['grep -oP ''', num2str(skelIDsR(ro)),'\[\d*\].ropen\("/home/william/nC_projects/',PN,'_linDisSim/spikeVectors/spikeVector\K\d*'' ' , PN,'.hoc'];
                %         [status, synapseNumsR{ro}]=system(grepCommand);
                %         synapseNumsR{ro}=unique(str2num(synapseNumsR{ro}));
                [status, synsW]=system(grepCommand);
                synsW=str2num(synsW);
                activeSyns=[activeSyns; [synsW,counter*ones(numel(synsW),1)]];
                counter=counter+1;
                synsW=[];
                
            end
            
        else % For L PNs
            
            skelIDsL=randsample(ORNs_Left,2);
            
            %Search the simulation hoc file and return the synapse numbers
            %associated with each of these ORNs
            
            counter=1;
            
            for lo=1:length(skelIDsL)
                
                grepCommand=['grep -oP ''', num2str(skelIDsL(lo)),'\[\d*\].ropen\("/home/william/nC_projects/',PN,'_linDisSim/spikeVectors/spikeVector\K\d*'' ' , PN,'_151125.hoc'];
                %         [status, synapseNumsL{lo}]=system(grepCommand);
                %         synapseNumsL{lo}=unique(str2num(synapseNumsL{lo}));
                [status, synsW]=system(grepCommand);
                synsW=str2num(synsW);
                activeSyns=[activeSyns; [synsW,counter*ones(numel(synsW),1)]];
                counter=counter+1;
                synsW=[];
                
            end
            
        end
        
        
        %Generate random spike times for each ORN, w/ 100ms buffer zone at
        %the end of trials
        
        spikeTimes(p,rep,1)=randsample([1/40:1/40:400],1);
        spikeTimes(p,rep,2)=randsample([1/40:1/40:400],1);
        
        %Save a file for every synapse in the simulation. The files associated
        %with the selected ORNs should contain the above calculated spike times
        %while all other files are blank
        
        
        
        % Save spike vector files for all synapses on this PN with a single
        % spike at the synapses from selected ORNs
        
        for f=1:numel(totSynapseNums)
            
            s=totSynapseNums(f);
            
            if ismember(s,activeSyns(:,1))
                
                
                vector=spikeTimes(p,rep,activeSyns(find(activeSyns(:,1) == s),2));
                save(['~/nC_projects/',PN,'_linDisSim/spikeVectors/spikeVector',num2str(totSynapseNums(f)),'.txt'],'vector','-ascii')
                
                
            else
                
                vector=[];
                save(['~/nC_projects/',PN,'_linDisSim/spikeVectors/spikeVector',num2str(totSynapseNums(f)),'.txt'],'vector','-ascii')
                
            end
        end
        
        %I want to run the simulation
        
        runCmd=['nrniv ',PN, '_151125.hoc'];
        system(runCmd);
        
        
        %I want to import the PNs simulated voltage trace
        
        %find its name
        pnResults=dir('neuron_PN*.dat');
        
        pnVm1=importdata(pnResults.name);
        
        %PN voltage storage
        twoSpikeVms(p,rep,:)=pnVm1;

        toc
    end
    
    % Calculate the mean voltage for all reps
    twoSpikeMeans(p,:)=mean(twoSpikeVms,3);
    
end

%% Find a threshold to separate these distributions

predictors=[oneSpikeMeans';twoSpikeMeans'];
categories=[ones(numel(oneSpikeMeans),1);2*ones(numel(twoSpikeMeans),1)];

cls = fitcdiscr(predictors,categories)

K=cls.Coeffs(1,2).Const;
L=cls.Coeffs(1,2).Linear;

thresh=-K/L

%see how well it did

sum(categories(find(predictors<thresh))==1)/sum(categories==1)

sum(categories(find(predictors<thresh))==1)/sum(categories==2)

%% Now I am going to run a simulation in which either one or two ORNs fires a single spike
%This will be my test data set for the thresh we just found

for p=1 %:numel(PNs)

     
    PN=cell2mat(PN_Names(p));
    cd(['/home/william/nC_projects/',PN,'_linDisSim/simulations/linDisSim/'])
    
    
    
    %find the total number of synapses
    grepCommand=['grep -oP ''\[\d*\].ropen\("/home/william/nC_projects/',PN,'_linDisSim/spikeVectors/spikeVector\K\d*'' ' , PN,'_151125.hoc'];
    [status, totSynapseNums]=system(grepCommand);
    totSynapseNums=str2num(totSynapseNums);
    
    
 for rep=1:50
     
            %initilize array to hold the synapse numbers activated in this
            %sim. It will be a 2d array in which one column hold synapse
            %numbers and the other holds a number which identifies the ORN
            %the syn came from
            
            
            activeSyns=[];
            activeSyns_eq=[];
            
            
            % pick ORNs at random, from the ipsi ORN pool
            
            if strcmp(PN, 'PN1RS') == 1 || strcmp(PN,'PN2RS') == 1 %For Right PNs
                
                ctg(p,rep)=randi(2);
                
                skelIDsR=randsample(ORNs_Right,ctg(p,rep));
                
                
                
                %Search the simulation hoc file and return the synapse numbers
                %associated with each of these ORNs
                counter =1;
                
                for ro=1:length(skelIDsR)
                    
                    grepCommand=['grep -oP ''', num2str(skelIDsR(ro)),'\[\d*\].ropen\("/home/william/nC_projects/',PN,'_linDisSim/spikeVectors/spikeVector\K\d*'' ' , PN,'_151125.hoc'];
                    %         [status, synapseNumsR{ro}]=system(grepCommand);
                    %         synapseNumsR{ro}=unique(str2num(synapseNumsR{ro}));
                    [status, synsW]=system(grepCommand);
                    synsW=str2num(synsW);
                    activeSyns=[activeSyns; [synsW,counter*ones(numel(synsW),1)]];
                    counter=counter+1;
                    synsW=[];
                    
                end
                
            else % For L PNs
                
                ctg(p,rep)=randi(2);
             skelIDsL=randsample(ORNs_Left,ctg(p,rep));
                
                
                %Search the simulation hoc file and return the synapse numbers
                %associated with each of these ORNs
                
                counter=1;
                
                for lo=1:length(skelIDsL)
                    
                    grepCommand=['grep -oP ''', num2str(skelIDsL(lo)),'\[\d*\].ropen\("/home/william/nC_projects/',PN,'_linDisSim/spikeVectors/spikeVector\K\d*'' ' , PN,'_151125.hoc'];
                    %         [status, synapseNumsL{lo}]=system(grepCommand);
                    %         synapseNumsL{lo}=unique(str2num(synapseNumsL{lo}));
                    
                    [status, synsW]=system(grepCommand);
                    synsW=str2num(synsW);
                    activeSyns=[activeSyns; [synsW,counter*ones(numel(synsW),1)]];
                    counter=counter+1;
                    synsW=[];
                    
                end
                
            end
            
         
            
            %Generate random spike times for each ORN, w/ 100ms buffer zone at
            %the end of trials
            if numel(unique(activeSyns(:,2))) == 1
                
                testSTs(p,rep,1)=randsample([1/40:1/40:400],1);
                testSTs(p,rep,2)=NaN;
                
            else
                
                testSTs(p,rep,1)=randsample([1/40:1/40:400],1);
                testSTs(p,rep,2)=randsample([1/40:1/40:400],1);
                
            end
            
            
            %Save a file for every synapse in the simulation. The files associated
            %with the selected ORNs should contain the above generated spike times
            %while all other files are blank
            
            for f=1:numel(totSynapseNums)
             s=totSynapseNums(f);
                    
                    if ismember(s,activeSyns(:,1))
                        

                        vector=testSTs(p,rep,activeSyns(find(activeSyns(:,1) == s),2));
                        save(['~/nC_projects/',PN,'_linDisSim/spikeVectors/spikeVector',num2str(totSynapseNums(f)),'.txt'],'vector','-ascii')
                        
                    else
                        
                        vector=[];
                        save(['~/nC_projects/',PN,'_linDisSim/spikeVectors/spikeVector',num2str(totSynapseNums(f)),'.txt'],'vector','-ascii')
                        
                    end
                end
                
              
                
                
            %I want to run the simulation
            
                runCmd=['nrniv ', PN, '_151125.hoc'];
                system(runCmd);
                
                                    
                %I want to import the PNs simulated voltage trace
                
                
                %find its name
                pnResults=dir('neuron_PN*.dat');
                
                pnVm1=importdata(pnResults.name);
                
                %PN voltage storage
                testVms(p,rep,:)=pnVm1;
                

                
            % now I want to give all ORNs the same number of synapses, I
            % will do this by finding the ORN w/ the least synapses from my
            % selection and only using that number of contacts in all other
            % ORNs
            
            % give ORNs an equal number of synapses
            
            
            % Find all contacts coming from the ipsi ORNs
            
            ipsiConts=[];
            
            if strcmp(PN, 'PN1RS') == 1 || strcmp(PN,'PN2RS') == 1 %For Right PNs
                
                for lo=1:length(ORNs_Right)
                    
                    grepCommand=['grep -oP ''', num2str(ORNs_Right(lo)),'\[\d*\].ropen\("/home/william/nC_projects/',PN,'_linDisSim/spikeVectors/spikeVector\K\d*'' ' , PN,'_151125.hoc'];
                    %         [status, synapseNumsL{lo}]=system(grepCommand);
                    %         synapseNumsL{lo}=unique(str2num(synapseNumsL{lo}));
                    
                    [status, synsW]=system(grepCommand);
                    synsW=str2num(synsW);
                    ipsiConts=[ipsiConts; synsW];
                    counter=counter+1;
                    synsW=[];
                    
                end
                
                numCont=floor(numel(ipsiConts)/numel(ORNs_Right)); % Num Cont each ORN will get
                
            else
                
                for lo=1:length(ORNs_Left)
                    
                    grepCommand=['grep -oP ''', num2str(ORNs_Left(lo)),'\[\d*\].ropen\("/home/william/nC_projects/',PN,'_linDisSim/spikeVectors/spikeVector\K\d*'' ' , PN,'_151125.hoc'];
                    %         [status, synapseNumsL{lo}]=system(grepCommand);
                    %         synapseNumsL{lo}=unique(str2num(synapseNumsL{lo}));
                    
                    [status, synsW]=system(grepCommand);
                    synsW=str2num(synsW);
                    ipsiConts=[ipsiConts; synsW];
                    counter=counter+1;
                    synsW=[];
                    
                end
                
                numCont=floor(numel(ipsiConts)/numel(ORNs_Left)); % Num Contacts each ORN will get
                
            end
            
           % Shuffle the ipsi contacts
           shuffIpsi=randsample(ipsiConts,numel(ipsiConts));
                

            
            for i=1:ctg(p,rep)
 
               activeSyns_eq(i*numCont-(numCont-1):i*numCont,:)=...
                   [shuffIpsi(i*numCont-(numCont-1):i*numCont),i*ones(numCont,1)];
  
            end
            
            % Save spike vector files for all synapses on this PN with
            % spike trains given to synapses in activeSyns_eq according to
            % ORN identity
                
                for f=1:numel(totSynapseNums)
                    
                    s=totSynapseNums(f);
                    
                    if ismember(s,activeSyns_eq(:,1))

                        vector=testSTs(p,rep,activeSyns_eq(find(activeSyns_eq(:,1) == s),2));
                        save(['~/nC_projects/',PN,'_linDisSim/spikeVectors/spikeVector',num2str(totSynapseNums(f)),'.txt'],'vector','-ascii')
                        
spikeTimes
                    else
                        
                        vector=[];
                        save(['~/nC_projects/',PN,'_linDisSim/spikeVectors/spikeVector',num2str(totSynapseNums(f)),'.txt'],'vector','-ascii')
                        
                    end
                end
                
            
                
             %I want to run the simulation
            
                runCmd=['nrniv ', PN, '_151125.hoc'];
                system(runCmd);
                
                                    
                %I want to import the PNs simulated voltage trace
                
                
                %find its name
                pnResults=dir('neuron_PN*.dat');
                
                pnVm1=importdata(pnResults.name);
                
                %PN voltage storage
                testVms_eq(p,rep,:)=pnVm1;
                

 end
        
   % Calculate the mean voltage for all reps
    testMeans(p,1,:)=mean(testVms,3);
    testMeans(p,2,:)=mean(testVms_eq,3);
 
end

%% Use our threshold on this test dataset
%see how well it did

sum(ctg(find(testMeans(1,1,:)<thresh))==1)/sum(ctg==1)

sum(ctg(find(testMeans(1,2,:)<thresh))==1)/sum(ctg==1)


