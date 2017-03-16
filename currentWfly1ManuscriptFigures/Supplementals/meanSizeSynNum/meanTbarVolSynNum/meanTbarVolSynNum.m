
%Load the cell array contianing the tracer averaged, bias corrected tbar vol and pn area measurments

load '/Users/williamtobin/Documents/MATLAB/tracingCode2/synapseSizeScripts/aveSizesBC.mat'

%Pull mean tbar vol and synapse number for each ipsilateral unitary connection
%segmented

ipsiTbarMeans=[];
synsPerConn=[];



for o=1:10
   
    ipsiConns=[];
    
    if o<=5
        ipsiConns=aveSizesBC(o,[1,2,5]);
        

    else
        
        ipsiConns=aveSizesBC(o,[3,4]);
        
    end
    
    for i=1:numel(ipsiConns)
        
        ipsiTbarMeans=[ipsiTbarMeans;mean(ipsiConns{i}(:,1))];
        synsPerConn=[synsPerConn;size(ipsiConns{i},1)];
        
    end
    
   
      
end

%% Plotting

figure()
hold on
set(gcf,'color','w')

   
scatter(synsPerConn,ipsiTbarMeans,60, 'k')

ylabel('Mean Tbar Vol (nm^3)')
xlabel('Synapses per Connection')

set(gca,'FontSize',18)

[rho, p]=corr(synsPerConn,ipsiTbarMeans)

title(['Pearson''s r : ',num2str(rho),' p val: ',num2str(p)])


saveas(gcf,'meanTbarVolSynNum','epsc')
saveas(gcf,'meanTbarVolSynNum')
