
%Load the cell array contianing the tracer averaged, bias corrected tbar vol and pn area measurments

load '/Users/williamtobin/Documents/MATLAB/tracingCode2/synapseSizeScripts/aveSizesBC.mat'

%Pull mean pn area and synapse number for each ipsilateral unitary connection
%segmented

ipsiPNMeans=[];
synsPerConn=[];



for o=1:10
   
    ipsiConns=[];
    
    if o<=5
        ipsiConns=aveSizesBC(o,[1,2,5]);
        

    else
        
        ipsiConns=aveSizesBC(o,[3,4]);
        
    end
    
    for i=1:numel(ipsiConns)
        
        ipsiPNMeans=[ipsiPNMeans;mean(ipsiConns{i}(:,2))];
        synsPerConn=[synsPerConn;size(ipsiConns{i},1)];
        
    end
    
   
      
end

%% Plotting

figure('units','normalized','outerposition',[0 0 1 1])
hold on
set(gcf,'color','w')

   
scatter(synsPerConn,ipsiPNMeans,60, 'k')

ylabel('Mean Postsynaptic PN Area (nm^2)')
xlabel('Synapses per Connection')

set(gca,'FontSize',18)

[rho, p]=corr(synsPerConn,ipsiPNMeans);

title(['Pearson''s r : ',num2str(rho),' p val: ',num2str(p)])


saveas(gcf,'meanPNAreaSynNum','epsc')
saveas(gcf,'meanPNAreaSynNum')
