%Load the cell array contianing the tracer averaged, bias corrected tbar vol and pn area measurments

load '/Users/williamtobin/Documents/MATLAB/tracingCode2/synapseSizeScripts/aveSizesBC.mat'


%sort measurments right/left syns

rightSyns=[];
leftSyns=[];

for o=1:10
    for p=1:5
       
        if ismember(p,[1,2,5])==1
            
            leftSyns=[leftSyns;[aveSizesBC{o,p}(:,1),aveSizesBC{o,p}(:,2)]];
            
        elseif ismember(p,[3,4]) == 1
            
           
           rightSyns=[rightSyns;[aveSizesBC{o,p}(:,1),aveSizesBC{o,p}(:,2)]];
            
        end
        
        
    end
end



%% Plotting

figure('units','normalized','outerposition',[0 0 1 1])
set(gcf,'Color','w')

scatter(leftSyns(:,1),leftSyns(:,2), 60,'k')
hold on
scatter(rightSyns(:,1),rightSyns(:,2),60, 'k','filled')

xlabel('Tbar Vol (nm^3)')
ylabel('PN Postsynaptic Area (nm^2)')

set(gca,'FontSize',18)
legend({'Left Synapses','Right Synapses'})

[rho, p]=corr([leftSyns(:,1);rightSyns(:,1)],[leftSyns(:,2);rightSyns(:,2)])

title(['Pearson''s r : ',num2str(rho),' p val: ',num2str(p)])


saveas(gcf,'lRTbarVolPnArea','epsc')
saveas(gcf,'lRTbarVolPnArea')