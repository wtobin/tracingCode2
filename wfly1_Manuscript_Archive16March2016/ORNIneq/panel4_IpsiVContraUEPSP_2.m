% This code is written to compare the mean ipsilateral uEPSP amp and the
% contralateral PN 

%I will collect values in two vectors. ipsiFract contains the mean
%fractional input each ORN provides to its ipsilateral PN targets. The
%denominator here is total IPSI orn inputs each PN receives. 
%contraFract contains mean fractional input each ORN provides to its
%contralateral PN targets. The denominator being total contra orn synapses each
%PN recieves


ornCounter=1;

for l=1:numel(ORNs_Left)
    
    ipsiFract(ornCounter)=mean(uEPSP_Amps(l,[1:3])./sum(uEPSP_Amps(1:25,[1:3])));
    contraFract(ornCounter)=mean(uEPSP_Amps(l,[4,5])./sum(uEPSP_Amps(1:25,[4,5])));
    ornCounter=ornCounter+1
    
end

rightORNInds=numel(ORNs_Left)+1:numel(ORNs_Left)+numel(ORNs_Right);

for r=rightORNInds(1):rightORNInds(end)
    
    ipsiFract(ornCounter)=mean(uEPSP_Amps(r,[4,5])./sum(uEPSP_Amps(rightORNInds,[4,5])));
    contraFract(ornCounter)=mean(uEPSP_Amps(r,[1:3])./sum(uEPSP_Amps(rightORNInds,[1:3])));
    ornCounter=ornCounter+1
    
end



% Plotting
figure()
set(gcf, 'Color', 'w')

scatter(ipsiFract(1:25),contraFract(1:25), 'filled')
hold on
scatter(ipsiFract(26:end),contraFract(26:end), 'r', 'filled')
xlim([0 .07])
ylim([0 0.07])

xlabel('Ipsi', 'FontSize', 16)
ylabel('Contra', 'FontSize',16)
ax=gca;
ax.FontSize=16;

title('Ipsi and Contra PN uEPSP Amp as Fraction','FontSize', 18)
legend({'Left ORNs','Right ORNs'}, 'FontSize', 16)

%Statistics

[pRho, pP]=corr(ipsiFract', contraFract')

text(.005,.02,{['Pearson''s R val: ', num2str(pRho)]; ['Pearson''s P val: ', num2str(pP)]}, 'FontSize', 16)

[sRho, sP]=corr(ipsiFract', contraFract', 'Type', 'Spearman')

text(.005,.01,{['Spearman''s coef val: ', num2str(sRho)]; ['Spearman''s P val: ', num2str(sP)]}, 'FontSize', 16)
