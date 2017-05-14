%Load the cell array contianing the tracer averaged, bias corrected tbar vol and pn area measurments
load '/Users/williamtobin/Documents/MATLAB/tracingCode2/synapseSizeScripts/aveSizesBC.mat'

%% Determine the number of synapses each ORN makes onto each Ipsi PN, JUST IPSI FOR FINAL TO MATCH SYN NUM HIST
% membrane area

ipsiConSynNums=[];
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
        
        ipsiConSynNums=[ipsiConSynNums;size(ipsiConns{i},1)];
        
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

h1=histogram(ipsiConSynNums, 'FaceColor','k');
% h1=histogram(pooledNormIpsiOrnToP, 'FaceColor','k');
xlim([0 2*mean(ipsiConSynNums)])
ax = gca;
ax.FontSize=16;
ylabel('# of Connections')
xlabel('Synapses per Connection')
% axis square
text(35, 2.5, ['CV: ',num2str(std(ipsiConSynNums)/mean(ipsiConSynNums))], 'FontSize',16)
box off 
set(gca,'TickDir','out')
axis square

saveas(gcf,'ipsiConnSynNums','epsc')
saveas(gcf,'ipsiConnSynNums')
    