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



PN_Names={'PN1LS','PN2LS', 'PN3LS', 'PN1RS', 'PN2RS'};

%% Now I am going to run a simulation in which either the ipsi ORN poulation
%is firing at 3Hz or 3Hz+ some ammount.

for p=1 %:numel(PNs)
    
    
    PN=cell2mat(PN_Names(p));
    
    %path to the dir containing the hoc files to be run
    path1=['/home/william/nC_projects/',PN,'_linDisSim/simulations/linDisSim'];
    cd(path1)
    
    %path to the dir containing the spikeVectors that specify the model
    %activity
    path2=['/home/william/nC_projects/',PN,'_linDisSim/spikeVectors'];
    
    
    %find the total number of synapses
    grepCommand=['grep -oP ''\[\d*\].ropen\("/home/william/nC_projects/',PN,'_linDisSim/spikeVectors/spikeVector\K\d*'' ' , PN,'_151125.hoc'];
    [status, totSynapseNums]=system(grepCommand);
    totSynapseNums=str2num(totSynapseNums);
    
    
    dFCount=1;
    
    for dF = (.5:.5:5)
        
        
        
    for t=1:2
        
        for rep=1:50
            
            %initilize array to hold the synapse numbers activated in this
            %sim. It will be a 2d array in which one column hold synapse
            %numbers and the other holds a number which identifies the ORN
            %the syn came from
            
            
            activeSyns=[];
            
            
            
            % Find synapse ids for all ipsi ORN synapses
            
            if strcmp(PN, 'PN1RS') == 1 || strcmp(PN,'PN2RS') == 1 %For Right PNs
                
                activeSyns=pullContactNums(ORNs_Right,path1,path2);
                
                
            else % For L PNs
                
                activeSyns=pullContactNums(ORNs_Left,path1,path2);
                
            end
            
            % Decide whether it will be a spontaneous or driven trial
            ctg(p,dFCount,t,rep)=randi(2);
            
            
            %Clear the spike trains/times variables
            clear spikeTrain
            clear spikeTimes
            
            
            if ctg(p,dFCount,t,rep) == 1
                
                %generate a spike train at the spon rate for all neurons
                %that will be activated
                
                for o=1:numel(unique(activeSyns(:,2)))
                    
                    spikeTrain(o,:)=makeSpikes(.001,2.25,.40);
                    spikeTimes{o}=find(spikeTrain(o,:)==1);
                    
                end
                
            else
                
                %generate a spike train at the driven rate for all neurons
                %that will be activated
                
                for o=1:numel(unique(activeSyns(:,2)))
                    
                    spikeTrain(o,:)=makeSpikes(.001,2.5,.40);
                    spikeTimes{o}=find(spikeTrain(o,:)==1);
                    
                end
                
            end
            
            
            %Save a file for every synapse in the simulation. The files associated
            %with the selected ORNs should contain the above generated spike times
            %while all other files are blank
            
            
            saveSpikeVectors(totSynapseNums,activeSyns,spikeTimes,path2)
            
            
            %I want to run the simulation
            
            runCmd=['nrniv ', PN, '_151125.hoc'];
            system(runCmd);
            
            
            %I want to import the PNs simulated voltage trace
            
            
            %find its name
            pnResults=dir('neuron_PN*.dat');
            
            pnVm1=importdata(pnResults.name);
            
            %PN voltage storage
            pnVms(p,dFCount,t,rep,:)=pnVm1;
            
            
            
        end
        
        % Calculate the mean voltage for all reps
        vmMeans(p,dFCount,t,:)=mean(squeeze(pnVms(p,dFCount,t,:,:))');
        
    end
    
    
    
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
    
    end

    
end


%% Save some stuff

save('disrimSim_realCon_Cat','ctg')
save('disrimSim_realCon_pnVms','pnVms')
save('disrimSim_realCon_meanVms','vmMeans')