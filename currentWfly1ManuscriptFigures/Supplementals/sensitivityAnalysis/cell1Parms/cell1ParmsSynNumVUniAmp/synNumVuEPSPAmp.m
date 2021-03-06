
% GOAL: For each ORN-PN pair scatterplot num synapses per contact vs uEPSP amp 

%This code relies on the product of
% sensitivityAnalysis/generateUnitaries/pullCell1Parms/pullCell1ParmsUEPSPs.m
% THIS CODE IS A SIMPLE COPY OF THAT IN THE MAIN FIG DIR

% Load annotations json. Generated by Wei's code gen_annotation_map.py
annotations=loadjson('~/tracing/sid_by_annotation.json');

%return all skeleton IDs of DM6 PNs
PNs=sort(annotations.DM6_0x20_PN);

%PnOrder brings the list of PN skeletons into register with PN order in
%UEPSP matricies
PnOrder=[1,2,5,4,3];

% Collect the amplitude of ipsi and contra uEPSPs for R and L ORN-->PN
% pairs

% Loop over PNs
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

% colors=['k','r','b','m','c'];
colors={[0.53, 0.40, 0.67];...
        [0.23, 0.76, 0.85];...
        [0.05, 0.66, 0.40];...
        [0.30, 0.18, 0.55];...
        [0.12, 0.59, 0.64]};

% 
% gscatter(uepspContNum(:,:,2),uepspContNum(:,:,1),[ones(size(uepspContNum(1:3,:,2)));2*ones(size(uepspContNum(4:5,:,1)))],[],[],[], 'off')
for p=1:5
    
    if p<=3
        scatter(uepspContNum(p,1:27,2),uepspContNum(p,1:27,1),[],colors{p})
        hold on
        scatter(uepspContNum(p,28:end,2),uepspContNum(p,28:end,1),[],colors{p},'filled')
    else
        
        scatter(uepspContNum(p,1:26,2),uepspContNum(p,1:26,1),[],colors{p},'filled')
        hold on
        scatter(uepspContNum(p,27:end,2),uepspContNum(p,27:end,1),[],colors{p})
    end
end

labels={'ipsi connections','contra connections'};

ax=gca;
ax.FontSize=16;
set(gca,'Xtick',0:10:60)
ylabel('uEPSP Amplitude (mV)')
xlabel('Synapse Number')
legend(labels,'Location','Southeast')

saveas(gcf,'synNumVuEPSPAmp','epsc')
saveas(gcf,'synNumVuEPSPAmp')

%% Statistics
[lpn1_rho,lpn1_pVal] = corr(uepspContNum(1,:,1)',uepspContNum(1,:,2)');
[lpn2_rho,lpn2_pVal] = corr(uepspContNum(2,:,1)',uepspContNum(2,:,2)');
[lpn3_rho,lpn3_pVal] = corr(uepspContNum(3,:,1)',uepspContNum(3,:,2)');
[rpn1_rho,rpn1_pVal] = corr(uepspContNum(4,:,1)',uepspContNum(4,:,2)');
[rpn2_rho,rpn2_pVal] = corr(uepspContNum(5,:,1)',uepspContNum(5,:,2)');

rhos = [lpn1_rho; lpn2_rho; lpn3_rho; rpn1_rho; rpn2_rho]
pVals = [lpn1_pVal; lpn2_pVal; lpn3_pVal; rpn1_pVal; rpn2_pVal]

% http://www.mathworks.com/matlabcentral/fileexchange/28303-bonferroni-holm-correction-for-multiple-comparisons/content/bonf_holm.m
[cor_p, h]=bonf_holm(pVals,.05)

