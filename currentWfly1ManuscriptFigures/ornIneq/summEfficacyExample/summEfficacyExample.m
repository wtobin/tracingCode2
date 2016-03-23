%The purpose of this code is to generate a histogram of ipsi ORN summation
%efficacy for PN1LS

%For this code to run you must first run pullmEPSPs.m located in
%currentWfly1ManuscriptFigures/pullmEPSPs AND pulluEPSP.m located in
%currentWfly1ManuscriptFigures/pulluEPSP



 %Loop over left ORN unitaries and calculate summation efficacy
 
 %the following code snippet was adapted from:
 %tracingCode2/wfly1_Manuscript_Archive16March2016/leftRightMinisAndUnitaries/summationEfficacy.m
 
    for u=1:size(leftUEPSPs{1},1)
        
        constituentMEPSPs=find(leftMEPSPs_idList{1}==leftUEPSPs_idList{1}(u));
        
        miniAmps=max(leftMEPSPs{1}(constituentMEPSPs,:)')-mean(leftMEPSPs{1}(constituentMEPSPs,1:160)');
        
        uAmp=max(leftUEPSPs{1}(u,:)')-mean(leftUEPSPs{1}(u,1:160));
        
        sumEff(u)=uAmp/sum(miniAmps);
      
        
    end
    
    
%Plotting

nBins = 10; % 160323WCL: was 5

figure()
set(gcf, 'Color', 'w')
h1=histogram(sumEff, nBins, 'FaceColor','k');
xlim([0 2*mean(sumEff)])
ax = gca;
ax.FontSize=16;
ylabel('# of connections')
xlabel('summation efficacy')
% axis square
text(.005, 4, ['CV: ',num2str(std(sumEff)/mean(sumEff))], 'FontSize',16)

saveas(gcf,'summEfficacyExample','epsc')
saveas(gcf,'summEfficacyExample')