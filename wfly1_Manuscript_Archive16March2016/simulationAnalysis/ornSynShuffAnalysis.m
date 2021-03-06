
PN_Names={'PN1LS','PN2LS', 'PN3LS', 'PN1RS', 'PN2RS'};


for p=1:numel(PN_Names)


%load the minis and store them in sequential order

rawMiniFile=dir(['~/nC_projects/',PN_Names{p},'_allORNs/simulations/minis/neuron*.dat']);

rawMinis=load(['~/nC_projects/',PN_Names{p},'_allORNs/simulations/minis/',rawMiniFile.name]);

for i=1:floor((length(rawMinis))/8000)
    
    minis(i,:)=rawMinis(((i*8000)-7999:i*8000)+3600);
    
end



resultDirs=dir(['~/nC_projects/',PN_Names{p},'_allORNs/simulations/shuffUnitaries/results/']);

counter=1;

%Loop over all repetitions of the simulation
for r=3:length(resultDirs)
    tic
 
    %Load the uni data     
    unitaries=load(['~/nC_projects/',PN_Names{p},'_allORNs/simulations/shuffUnitaries/results/',resultDirs(r).name,'/',rawMiniFile.name]);
   
    %load synapse to ORN mapping for this trial
    load(['~/nC_projects/',PN_Names{p},'_allORNs/simulations/shuffUnitaries/results/',resultDirs(r).name,'/activeSyns.mat']);
    
    %Loop over ORNs
    for o=1:numel(unique(activeSyns(:,2)))
       
      workingUni=unitaries([(o-1)*8000:o*8000]+3600);
      uniAmps{p}(counter,o)=max(workingUni)+60;
      uniArea{p}(counter,o)=sum(workingUni+60);
        
        
      miniNums=activeSyns(activeSyns(:,2)==o,1)+1;
      
        %Loop over minis
        for m=1:numel(miniNums)

            miniAmps{p,counter,o}(m)=max(minis(miniNums(m),:))+60;
            miniArea{p,counter,o}(m)=sum(minis(miniNums(m),:)+60);
           
        end
        
        meanMiniAmps{p}(counter,o)=mean(miniAmps{p,counter,o}(:));
        summEff{p}(counter,o)=uniArea{p}(counter,o)/sum(miniArea{p,counter,o}(:));
        
    end

    counter=counter+1;
    toc
end


for i=1:numel(resultDirs)-2
    
    cvMeanMini{p}(i)=std(meanMiniAmps{p}(i,:))/mean(meanMiniAmps{p}(i,:));
    cvSummEff{p}(i)=std(summEff{p}(i,:))/mean(summEff{p}(i,:));
    
end

end



%Now look at the real data for each PN


%The purpose of this code is to generate a histogram of the mean ipsi mEPSP
%amplitudes for one example PNLS1

%For this code to run you must first run pullmEPSPs.m located in
%currentWfly1ManuscriptFigures/pullmEPSPs

for p=1:5
clear ipsiMiniAmps



    if p<=3
%store the skel IDs for left ORNs
leftORNs=unique(leftMEPSPs_idList{p});

%Loop over left ORNs
%store the mean mEPSP amplitude for each leftORN

for m=1:length(leftORNs)
    
    ipsiMiniAmps(m)=mean(max(leftMEPSPs{p}(leftMEPSPs_idList{p}==leftORNs(m),:),[],2)+60);
    
end
    else
      %store the skel IDs for left ORNs
rightORNs=unique(rightMEPSPs_idList{p});

%Loop over right ORNs
%store the mean mEPSP amplitude for each rightORN

for m=1:length(rightORNs)
    
    ipsiMiniAmps(m)=mean(max(rightMEPSPs{p}(rightMEPSPs_idList{p}==rightORNs(m),:),[],2)+60);
    
end

    end

%plotting
figure()
subplot(2,1,1)
set(gcf, 'Color', 'w')
h1=histogram(ipsiMiniAmps, 5, 'FaceColor','k');
xlim([0 1.2*nanmean(ipsiMiniAmps)])
ax = gca;
ax.FontSize=16;
ylabel('# of connections')
xlabel('mean mEPSP amp')

text(.002, 8, ['CV: ',num2str(std(ipsiMiniAmps)/mean(ipsiMiniAmps))], 'FontSize',16)

subplot(2,1,2)
% histogram(cvMeanMini{p})
histogram(meanMiniAmps{p})
ylabel('Num of Shuffles')
xlim([0 1.2*nanmean(meanMiniAmps{p}(:))])
xlabel('Mean Mini Amps')



figure()
histogram(cvMeanMini{p})
line([std(ipsiMiniAmps)/mean(ipsiMiniAmps),  std(ipsiMiniAmps)/mean(ipsiMiniAmps)],[ 0 ,200])



end

for p=1:5
   
    clear constituentMEPSPs
    clear miniAmps_ind
    clear uAmp
    clear summEff_ind
    
    if p<=5
    
 %Loop over left ORN unitaries and calculate summation efficacy
 
 %the following code snippet was adapted from:
 %tracingCode2/wfly1_Manuscript_Archive16March2016/leftRightMinisAndUnitaries/summationEfficacy.m
 
    for u=1:size(leftUEPSPs{p},1)
        
        constituentMEPSPs=find(leftMEPSPs_idList{p}==leftUEPSPs_idList{p}(u));
        
       miniAmps_ind=max(leftMEPSPs{p}(constituentMEPSPs,:)')-mean(leftMEPSPs{p}(constituentMEPSPs,1:160)');
        
        uAmp=max(leftUEPSPs{p}(u,:)')-mean(leftUEPSPs{p}(u,1:160));
        
        sumEff_ind(u)=uAmp/sum(miniAmps_ind);
      
        
    end
    
    
    else
        
        for u=1:size(rightUEPSPs{p},1)
        
        constituentMEPSPs=find(rightMEPSPs_idList{p}==rightUEPSPs_idList{p}(u));
        
       miniAmps_ind=max(rightMEPSPs{p}(constituentMEPSPs,:)')-mean(rightMEPSPs{p}(constituentMEPSPs,1:160)');
        
        uAmp=max(rightUEPSPs{p}(u,:)')-mean(rightUEPSPs{p}(u,1:160));
        
        sumEff_ind(u)=uAmp/sum(miniAmps_ind);
      
        
        end
    
    end
    
%Plotting

figure()
subplot(2,1,1)
set(gcf, 'Color', 'w')
h1=histogram(sumEff_ind, 5, 'FaceColor','k');
xlim([0 1.2*mean(sumEff_ind)])
ax = gca;
ax.FontSize=16;
ylabel('# of connections')
xlabel('summation efficacy')

text(.005, 8, ['CV: ',num2str(std(sumEff_ind)/mean(sumEff_ind))], 'FontSize',16)


subplot(2,1,2)
histogram(summEff{p})
ylabel('Num of Shuffles')
xlabel('Summ Eff')
xlim([0 1.2*mean(summEff{p}(:))])


figure()
histogram(cvSummEff{p})
line([std(sumEff_ind)/mean(sumEff_ind),  std(sumEff_ind)/mean(sumEff_ind)],[ 0 ,200])



    
end


