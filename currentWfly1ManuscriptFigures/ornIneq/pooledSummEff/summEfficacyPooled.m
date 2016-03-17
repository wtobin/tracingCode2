%The purpose of this code is to generate a histogram of ipsi ORN summation
%efficacy for all PNs

%For this code to run you must first run pullmEPSPs.m located in
%currentWfly1ManuscriptFigures/pullmEPSPs AND pulluEPSP.m located in
%currentWfly1ManuscriptFigures/pulluEPSP


 %Loop over ORN unitaries and calculate summation efficacy
 
 %this code snippet was adapted from:
 %tracingCode2/wfly1_Manuscript_Archive16March2016/leftRightMinisAndUnitaries/summationEfficacy.m
 
 
 
%loop over PNs
for p=1:5
    
    counter=1;
    
    %For Left PNs calculate summ eff for left ORN inputs only
    if p<=3
    
    %Loop over left ORN unitaries
    for u=1:size(leftUEPSPs{p},1)
        
        constituentMEPSPs=find(leftMEPSPs_idList{p}==leftUEPSPs_idList{p}(u));
        miniAmps=max(leftMEPSPs{p}(constituentMEPSPs,:)')-mean(leftMEPSPs{p}(constituentMEPSPs,1:160)');
        uAmp=max(leftUEPSPs{p}(u,:)')-mean(leftUEPSPs{p}(u,1:160));
        sumEff{p}(counter)=uAmp/sum(miniAmps);
        counter=counter+1;
        
    end
    
      %For Right PNs calculate summ eff for right ORN inputs only
      
    else
    %Loop over R ORN unitaries
    
    for u=1:size(rightUEPSPs{p},1)
        
        constituentMEPSPs=find(rightMEPSPs_idList{p}==rightUEPSPs_idList{p}(u));
        miniAmps=max(rightMEPSPs{p}(constituentMEPSPs,:)')-mean(rightMEPSPs{p}(constituentMEPSPs,1:160)');
        uAmp=max(rightUEPSPs{p}(u,:)')-mean(rightUEPSPs{p}(u,1:160));
        sumEff{p}(counter)=uAmp/sum(miniAmps);
        counter=counter+1;
        
        
    end
    
    end
    
end

%pool these values
pooledSumEff=[sumEff{1},sumEff{2},sumEff{3},sumEff{4},sumEff{5}];

  
%Plotting

figure()
set(gcf, 'Color', 'w')
h1=histogram(pooledSumEff, 5, 'FaceColor','k');
xlim([0 2*mean(pooledSumEff)])
ax = gca;
ax.FontSize=16;
ylabel('# of connections')
xlabel('pooled summation efficacy')
axis square
text(.005, 55, ['CV: ',num2str(std(pooledSumEff)/mean(pooledSumEff))], 'FontSize',16)

saveas(gcf,'summEfficacyPooled','epsc')
saveas(gcf,'summEfficacyPooled')

