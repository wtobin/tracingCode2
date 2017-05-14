%Load bias corrected synaptic element size file

load aveSizesBC.mat

%sort measurments into ipsi/contra and right/left containers

ipsiSyns=[];
contraSyns=[];

for o=1:10
    for p=1:5
        
            if o<=5 && ismember(p,[1,2,5])==1
                
                ipsiSyns=[ipsiSyns;[aveSizesBC{o,p}(:,1),aveSizesBC{o,p}(:,2)]];
                
            elseif o<=5 && ismember(p,[3,4]) == 1
                
                contraSyns=[contraSyns;[aveSizesBC{o,p}(:,1),aveSizesBC{o,p}(:,2)]];
                
            elseif o>=6 && ismember(p,[1,2,5])==1
                
                contraSyns=[contraSyns;[aveSizesBC{o,p}(:,1),aveSizesBC{o,p}(:,2)]];
                
            elseif o>=6 && ismember(p,[3,4])==1
                
                ipsiSyns=[ipsiSyns;[aveSizesBC{o,p}(:,1),aveSizesBC{o,p}(:,2)]];
                
            end
            
      
    end
end


rightSyns=[];
leftSyns=[];

for o=1:10
    for p=1:5
        for u=1:4
        if ismember(p,[1,2,5])==1
            
            leftSyns=[leftSyns;[aveSizesBC{o,p}(:,1),aveSizesBC{o,p}(:,2)]];
            
        elseif ismember(p,[3,4]) == 1
            
           
           rightSyns=[rightSyns;[aveSizesBC{o,p}(:,1),aveSizesBC{o,p}(:,2)]];
            
        end
        end
        
    end
end


%% Plotting


figure()
hold on
set(gcf,'color','w')

scatter(ipsiSyns(:,1),ipsiSyns(:,2), 'k')
hold on
scatter(contraSyns(:,1),contraSyns(:,2), '*r')

xlabel('Tbar Vol (nm^3)')
ylabel('PN Postsynaptic Area (nm^2)')

set(gca,'FontSize',18)

legend({'Ipsi Syns','Contra Syns'})
[rho, p]=corr([ipsiSyns(:,1);contraSyns(:,1)],[ipsiSyns(:,2);contraSyns(:,2)])


figure()
hold on
set(gcf,'color','w')

scatter(leftSyns(:,1),leftSyns(:,2), 'k')
hold on
scatter(rightSyns(:,1),rightSyns(:,2), '*r')

xlabel('Tbar Vol (nm^3)')
ylabel('PN Postsynaptic Area (nm^2)')

set(gca,'FontSize',18)

legend({'Left Syns','Right Syns'})




