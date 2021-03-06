
% GOAL: For each ORN-PN pair scatterplot num synapses per contact vs uEPSP amp 

%For this code to run you must first run pulluEPSP.m located in
%currentWfly1ManuscriptFigures/pulluEPSP


% Load annotations json. Generated by Wei's code gen_annotation_map.py
annotations=loadjson('~/tracing/sid_by_annotation.json');

%return all skeleton IDs of DM6 PNs
PNs=sort(annotations.DM6_0x20_PN);

%PnOrder brings the list of PN skeletons into register with PN order in
%UEPSP matricies
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

figure()
set(gcf,'Color','w')

colors=['k','r','b','m','c'];
% 
% gscatter(uepspContNum(:,:,2),uepspContNum(:,:,1),[ones(size(uepspContNum(1:3,:,2)));2*ones(size(uepspContNum(4:5,:,1)))],[],[],[], 'off')
for p=1:5
    
    if p<=3
        scatter(uepspContNum(p,1:27,2),uepspContNum(p,1:27,1),[],colors(p))
        hold on
        scatter(uepspContNum(p,28:end,2),uepspContNum(p,28:end,1),'^',colors(p))
    else
        
        scatter(uepspContNum(p,1:26,2),uepspContNum(p,1:26,1),'^',colors(p))
        hold on
        scatter(uepspContNum(p,27:end,2),uepspContNum(p,27:end,1),[],colors(p))
    end
end

labels={'Ipsi ORNs','Contra ORNs'};

ax=gca;
ax.FontSize=16;
ylabel('uEPSP Amplitude (mV)')
xlabel('Synapse Number')
legend(labels,'Location','NorthWest')
saveas(gcf,'contNumVuEPSPAmp_triangle','epsc')
saveas(gcf,'contNumVuEPSPAmp_triangle')