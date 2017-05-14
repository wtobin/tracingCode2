%Load the cell array contianing the tracer averaged, bias corrected tbar vol and pn area measurments
load '/Users/williamtobin/Documents/MATLAB/tracingCode2/synapseSizeScripts/aveSizesBC.mat'

%% Determine the mean size of each ORNs ipsi and Contra postsynaptic PN JUST IPSI FOR FINAL TO MATCH SYN NUM HIST
% membrane area

ipsiPnMeans=[];
%contraPNMeans=[];

for o=1:10
    
    ipsiConns=[];
    
    if o<=5
        ipsiConns=aveSizesBC(o,[1,2,5]);
        %contraConns=aveSizesBC(o,[3,4]);
        
    else
        
        ipsiConns=aveSizesBC(o,[3,4]);
        %contraConns=aveSizesBC(o,[1,2,5]);
        
    end
    
    for i=1:numel(ipsiConns)
        
        ipsiPnMeans=[ipsiPnMeans;mean(ipsiConns{i}(:,2))];
        
    end
    
%     for j=1:numel(contraConns)
%         
%         contraPNMeans=[contraPNMeans;mean(contraConns{j}(:,2))];
%         
%     end
%     
    
    
end


%% Plotting

figure()
set(gcf, 'Color', 'w')
set(gcf,'renderer','painters');

h1=histogram(ipsiPnMeans, 'FaceColor','k');
% h1=histogram(pooledNormIpsiOrnToP, 'FaceColor','k');
xlim([0 2*mean(ipsiPnMeans)])
ax = gca;
ax.FontSize=16;
ylabel('Frequency')
xlabel('Mean Postsynaptic PN Membrane Area (nm^2)')
% axis square
text(1.75*10^4, 10, ['CV: ',num2str(std(ipsiPnMeans)/mean(ipsiPnMeans))], 'FontSize',16)
box off 
set(gca,'TickDir','out')
axis square

saveas(gcf,'ipsiMeanPNAreaDist','epsc')
saveas(gcf,'ipsiMeanPNAreaDist')
    