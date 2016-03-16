% This code is written to compare the fraction of ipsilateral and
% contralateral PN input each ORN supplies.


%I will collect values in two vectors. ipsiFract contains the mean
%fractional input each ORN provides to its ipsilateral PN targets. The
%denominator here is total IPSI orn inputs each PN receives. 
%contraFract contains mean fractional input each ORN provides to its
%contralateral PN targets. The denominator being total contra orn synapses each
%PN recieves


ornCounter=1;

for l=1:numel(ORNs_Left)
    
    ipsiFract(ornCounter)=mean(contactNum(l,[1,2,5])./sum(contactNum(1:27,[1,2,5])));
    contraFract(ornCounter)=mean(contactNum(l,[3,4])./sum(contactNum(1:27,[3,4])));
    ornCounter=ornCounter+1
    
end

rightORNInds=numel(ORNs_Left)+1:numel(ORNs_Left)+numel(ORNs_Right);

for r=rightORNInds(1):rightORNInds(end)
    
    ipsiFract(ornCounter)=mean(contactNum(r,[3,4])./sum(contactNum(rightORNInds,[3,4])));
    contraFract(ornCounter)=mean(contactNum(r,[1,2,5])./sum(contactNum(rightORNInds,[1,2,5])));
    ornCounter=ornCounter+1
    
end



% Plotting
figure()
set(gcf, 'Color', 'w')

scatter(ipsiFract(1:25),contraFract(1:25), 'filled')
hold on
% scatter(ipsiFract(26:end),contraFract(26:end), 'r', 'filled')
scatter(contraFract(26:end),ipsiFract(26:end), 'r', 'filled')
xlim([0 .07])
ylim([0 0.07])

xlabel('Ipsi', 'FontSize', 16)
ylabel('Contra', 'FontSize',16)
ax=gca;
ax.FontSize=16;

title('Ipsi and Contra PN Contact Num as Fraction','FontSize', 18)
legend({'Left ORNs','Right ORNs'}, 'FontSize', 16)

%Statistics

[pRho, pP]=corr(ipsiFract', contraFract')

text(.005,.02,{['Pearson''s R val: ', num2str(pRho)]; ['Pearson''s P val: ', num2str(pP)]}, 'FontSize', 16)

[sRho, sP]=corr(ipsiFract', contraFract', 'Type', 'Spearman')

text(.005,.01,{['Spearman''s coef val: ', num2str(sRho)]; ['Spearman''s P val: ', num2str(sP)]}, 'FontSize', 16)
