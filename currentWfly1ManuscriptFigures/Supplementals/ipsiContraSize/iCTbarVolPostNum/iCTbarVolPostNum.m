
%Load the cell array contianing the tracer averaged, bias corrected tbar vol and pn area measurments
load '/Users/williamtobin/Documents/MATLAB/tracingCode2/synapseSizeScripts/aveSizesBC.mat'

%Load the cell array containing connector IDs for each ORN/PN pair in the
%mat loaded above
load '/Users/williamtobin/Documents/MATLAB/tracingCode2/synapseSizeScripts/segIDs.mat'


%sort measurments ipsi/contra syns
ipsiSyns=[];
contraSyns=[];

connsIncluded={};


for o=1:10
    
    for p=1:5
        
        for s=1:size(aveSizesBC{o,p},1)
            
            %Check to see if this connector was recorded as part of another
            %connection
            if ismember(segIDs{o,p,1}(s),connsIncluded) == 0
                
                if o<=5 && ismember(p,[1,2,5])==1 
                    
                    ipsiSyns=[ipsiSyns;[aveSizesBC{o,p}(s,3),aveSizesBC{o,p}(s,1)]];
                    
                elseif o<=5 && ismember(p,[3,4]) == 1
                    
                    contraSyns=[contraSyns;[aveSizesBC{o,p}(s,3),aveSizesBC{o,p}(s,1)]];
                    
                elseif o>=6 && ismember(p,[1,2,5])==1
                    
                    contraSyns=[contraSyns;[aveSizesBC{o,p}(s,3),aveSizesBC{o,p}(s,1)]];
                    
                elseif o>=6 && ismember(p,[3,4])==1
                    
                    ipsiSyns=[ipsiSyns;[aveSizesBC{o,p}(s,3),aveSizesBC{o,p}(s,1)]];
                    
                end
                
                connsIncluded=[connsIncluded;segIDs{o,p,1}(s)];
               
            else
                
            end
            
        end
        
    end
    
end

%% Plotting

figure('units','normalized','outerposition',[0 0 1 1])
hold on
set(gcf,'color','w')
set(gcf,'renderer','painters');

scatter(ipsiSyns(:,1),ipsiSyns(:,2),60, 'k','jitter','on', 'jitterAmount',0.25)
hold on
scatter(contraSyns(:,1),contraSyns(:,2),60, 'k','filled','jitter','on', 'jitterAmount',0.25)


ylabel('Tbar Vol (nm^3)')
xlabel('# Postsynaptic Profiles')
legend({'Ipsi Synapses','Contra Synapses'})

set(gca,'FontSize',18)
set(gca,'TickDir','out')
%axis square

[rho, p]=corr([ipsiSyns(:,1);contraSyns(:,1)],[ipsiSyns(:,2);contraSyns(:,2)])

title(['Pearson''s r : ',num2str(rho),' p val: ',num2str(p)])


saveas(gcf,'iCTbarVolPostNum','epsc')
saveas(gcf,'iCTbarVolPostNum')
