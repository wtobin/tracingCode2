%Load the cell array contianing the tracer averaged, bias corrected tbar vol and pn area measurments

load '/Users/williamtobin/Documents/MATLAB/tracingCode2/synapseSizeScripts/aveSizesBC.mat'

%sort measurments right/left syns

rightSyns=[];
leftSyns=[];

for o=1:10
    for p=1:5
        if ismember(p,[1,2,5])==1
            
            %Column 3 is number of postsynaptic profiles
            leftSyns=[leftSyns;[aveSizesBC{o,p}(:,3),aveSizesBC{o,p}(:,1)]];
            
        elseif ismember(p,[3,4]) == 1
            
            rightSyns=[rightSyns;[aveSizesBC{o,p}(:,3),aveSizesBC{o,p}(:,1)]];
            
        end
        
        
    end
end



%% Plotting

figure()
hold on
set(gcf,'color','w')

   
scatter(leftSyns(:,1),leftSyns(:,2),60, 'k','jitter','on', 'jitterAmount',0.25)
hold on
scatter(rightSyns(:,1),rightSyns(:,2),60, 'k','filled','jitter','on', 'jitterAmount',0.25)


ylabel('Tbar Vol (nm^3)')
xlabel('# Postsynaptic Profiles')
legend({'Left Synapses','Right Synapses'})

set(gca,'FontSize',18)


[rho, p]=corr([leftSyns(:,1);rightSyns(:,1)],[leftSyns(:,2);rightSyns(:,2)])

title(['Pearson''s r : ',num2str(rho),' p val: ',num2str(p)])


saveas(gcf,'lRTbarVolPostNum','epsc')
saveas(gcf,'lRTbarVolPostNum')

