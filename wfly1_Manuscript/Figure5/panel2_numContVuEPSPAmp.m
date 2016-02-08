% This code relies on the products of uEPSP_AmpWorking which should be found in Fig 2 dir


% GOAL: For each PN scatterplot num contacts vs uEPSP amp for each ORN input

PnOrder=[1,2,5,4,3];

% Collect the amplitude of ipsi and contra uEPSPs for R and L ORN-->PN
% pairs

% Loop over ORNs
for p=1:5
    counter=1;
    
    for l=1:size(leftUEPSPs{p},1)
        uepspContNum(p,counter,1)=max(leftUEPSPs{p}(l,:))+60;
        uepspContNum(p,counter,2)=getSynapseNum(leftUEPSPs_idList{p}(l), PNs(PnOrder(p)));
        counter=counter+1;
    end
    
    for r=1:size(rightUEPSPs{p},1)
        uepspContNum(p,counter,1)=max(rightUEPSPs{p}(r,:))+60;
        uepspContNum(p,counter,2)=getSynapseNum(rightUEPSPs_idList{p}(r), PNs(PnOrder(p)));
        counter=counter+1;
    end
    
    
end


%% Plotting

figure
set(gcf,'Color','w')

gscatter(uepspContNum(:,:,2),uepspContNum(:,:,1),[ones(size(uepspContNum(1:3,:,2)));2*ones(size(uepspContNum(4:5,:,1)))],[],[],[], 'off')


labels={'Left PNs','Right PNs'};

ax=gca;
ax.FontSize=16;
ylabel('uEPSP Amplitude (mV)')
xlabel('Synapse Number')
legend(labels,'Location','NorthWest')
axis square
saveas(gcf,'contNumVuEPSPAmp','epsc')
