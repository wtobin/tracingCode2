
%loop over PNs
for p=1:5
    counter=1;
    
    %Loop over left ORN unitaries
    for u=1:size(leftUEPSPs{p},1)
        
        constituentMEPSPs=find(leftMEPSPs_idList{p}==leftUEPSPs_idList{p}(u));
        miniAmps=max(leftMEPSPs{p}(constituentMEPSPs,:)')-mean(leftMEPSPs{p}(constituentMEPSPs,1:160)');
        uAmp=max(leftUEPSPs{p}(u,:)')-mean(leftUEPSPs{p}(u,1:160));
        sumEff{p}(counter)=uAmp/sum(miniAmps);
        counter=counter+1;
        
    end
    
    %Loop over R ORN unitaries
    
    for u=1:size(rightUEPSPs{p},1)
        
        constituentMEPSPs=find(rightMEPSPs_idList{p}==rightUEPSPs_idList{p}(u));
        miniAmps=max(rightMEPSPs{p}(constituentMEPSPs,:)')-mean(rightMEPSPs{p}(constituentMEPSPs,1:160)');
        uAmp=max(rightUEPSPs{p}(u,:)')-mean(rightUEPSPs{p}(u,1:160));
        sumEff{p}(counter)=uAmp/sum(miniAmps);
        counter=counter+1;
        
        
    end
    
    
    
end

lSumEff=[sumEff{1},sumEff{2},sumEff{3}];
rSumEff=[sumEff{4},sumEff{5}];

gpsU = [ones(size(lSumEff)),2.*ones(size(rSumEff))];
valsU = [lSumEff,rSumEff];
[YUmean,YUsem,YUstd,YUci] = grpstats(valsU,gpsU,{'mean','sem','std','meanci'});


%% Simple bar plot Left-Right ORNs unitary amplitude
%Ipsi and contra broken out

figure
set(gcf,'Color', 'w')
bar(YUmean,.4,'FaceColor','k','LineWidth',2)
hold on
he = errorbar(YUmean,YUsem,'k','LineStyle','none'); % error bars are std
he.LineWidth=1;
xlim([0.5 2.5])
% ylim([0 80])
ax = gca;
ax.XTick = [1 2];
ax.XTickLabel = {'Left';'Right'};
ax.FontSize=16;
ylabel('uEPSP/Sum of mEPSPs')
axis square
saveas(gcf,'summationEfficacy','epsc')

