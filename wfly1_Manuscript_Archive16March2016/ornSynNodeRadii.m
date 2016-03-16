cd ('~/nC_projects/PN1LS_localMini/')

%Grep command to pull all segement numbers
segGrepCmd=['grep -o -P ''name\=\"s\K\d*'' allORNsTo',PN,'_151125.neuroml'];
[status segments]=system(segGrepCmd)
segments=str2num(segments);

% Pull a diameter for each segment, when this is defined for both proximal
% and distal portions of the segment just pull the distal diam
segGrepCmd=['grep -o -P -z ''diameter\=\"\K\d*.\d*(?=\"\/\>\n\<\/segment\>)'' allORNsTo',PN,'_151125.neuroml'];
[status diameters]=system(segGrepCmd)
diameters=str2num(diameters);

% Find the segments associated with each synapse on this dendritic arbor

%Grep command to pull all ORN Ids from saved network file
networkFiles=dir('savedNetworks/*nml1');

ornIDCmd=['grep -o -P ''name\=\"\K\d*'' savedNetworks/',networkFiles.name];
[status ornIDs]=system(ornIDCmd)
ornIDs=str2num(ornIDs);

% Now pull the number of synapses associated with each ORN
ornSynCmd=['grep -o -P ''sites size\=\"\K\d*'' savedNetworks/',networkFiles.name];
[status ornSyns]=system(ornSynCmd)
ornSyns=str2num(ornSyns);

% Now pull the number of segment nums associated with each ORNs synapses
synSegCmd=['grep -o -P ''segment_id\=\"\K\d*'' savedNetworks/',networkFiles.name];
[status synSegs]=system(synSegCmd)
synSegs=str2num(synSegs);




%Create a list of ORN IDs in the sequence they are found in the network
%file with each orn id is listed once for each synapse it contributes

netFileORNIDList=[]
for t=1:numel(ornIDs)
    
    idReps(1:ornSyns(t),1)=ornIDs(t);
    netFileORNIDList=[netFileORNIDList;idReps];
    clear idReps
end
    

%create a list of node diameters at each ORN syn 

for d= 1:size(synSegs)
    ornSynDiams(d,1)=mean(diameters(find(segments==synSegs(d))));
 
end

%Combine the above created lists so that each diameter is matched to the
% orn ID that supplied the synapse

ornSynDiams=[ornSynDiams, netFileORNIDList];


% Now pull the order in which ORNs were activated in the simulation from
% the hoc file

ornSeqInSimCmd=['grep -o -P ''n\_\K\d*(?=\s\=\s\d*)'' simulations/localMini/',PN,'_151125.hoc' ];
[status ornSeq]=system(ornSeqInSimCmd);
ornSeq=str2num(ornSeq);



synCounter=1;

for o=1:length(ornSeq)
    
    
    %Find the portion of the ornDiams list that corrsponds to this ORN
    workingOrnDiams=ornSynDiams(find(ornSynDiams(:,2)==ornSeq(o)),1)
    
    
    
    for s=1:length(workingOrnDiams)
        
        
    
    lmAmpDiam(synCounter,1)=max(localMinis{2}(synCounter,:))+59.4;
    
    %Find the segment number associated with he sth synapse of the oth ORN
    
    
    lmAmpDiam(synCounter,2)=workingOrnDiams(s);
    
    synCounter=synCounter+1;
    
    end
end

%% Plotting

figure()
set(gcf,'Color','w')
scatter(lmAmpDiam(:,1),lmAmpDiam(:,2))
xlabel('Mini Amp @ site of Synapse (mV)','FontSize',16)
ylabel('Seg Diam @ Synapse (um)','FontSize',16)

%% regress mEPSP amp at the soma against radii

leftORNDiams=[];

for o=1:length(ORNs_Left)

leftORNDiams_w = ornSynDiams(find(ornSynDiams(:,2)==ORNs_Left(o)));

mEPSPs_w=leftMEPSPs{2}(leftMEPSPs_idList{2}==o,:);
   
somaAmps=max(mEPSPs_w')+59.4;

leftORNDiams=[leftORNDiams;[leftORNDiams_w,somaAmps']];



    
end

