% Load the bias corrected synaptic element size data
load('aveSizesBC.mat')

ipsiSyns=[];
contraSyns=[];

for o=1:10
    for p=1:5
        
        if o<=5 && ismember(p,[1,2,5])==1
            
            ipsiSyns=[ipsiSyns;[aveSizesBC{o,p}(:,4),aveSizesBC{o,p}(:,1)]];
            
        elseif o<=5 && ismember(p,[3,4]) == 1
            
            contraSyns=[contraSyns;[aveSizesBC{o,p}(:,4),aveSizesBC{o,p}(:,1)]];
            
        elseif o>=6 && ismember(p,[1,2,5])==1
            
            contraSyns=[contraSyns;[aveSizesBC{o,p}(:,4),aveSizesBC{o,p}(:,1)]];
            
        elseif o>=6 && ismember(p,[3,4])==1
            
            ipsiSyns=[ipsiSyns;[aveSizesBC{o,p}(:,4),aveSizesBC{o,p}(:,1)]];
            
        end
        
    end
end


rightSyns=[];
leftSyns=[];

for o=1:10
    for p=1:5
        if ismember(p,[1,2,5])==1
            
            leftSyns=[leftSyns;[aveSizesBC{o,p}(:,4),aveSizesBC{o,p}(:,1)]];
            
        elseif ismember(p,[3,4]) == 1
            
            rightSyns=[rightSyns;[aveSizesBC{o,p}(:,4),aveSizesBC{o,p}(:,1)]];
            
        end
        
        
    end
end


%%Calc ave for each post 
% volMeans=[];
% 
% for n=1:11
%     pool=aveSizesBC(aveSizesBC(:,2)==n,1);
%     
%    volMeans(n)=mean(pool);
%     
% end
% 

%% Some plotting

figure()
hold on
set(gcf,'color','w')

   
scatter(ipsiSyns(:,1),ipsiSyns(:,2), 'k','jitter','on', 'jitterAmount',0.25)
hold on
scatter(contraSyns(:,1),contraSyns(:,2), '*r','jitter','on', 'jitterAmount',0.25)




% %%Calc ave for each post 
% volMeans=[];
% for n=1:11
%     pool=aveSizesBC(aveSizesBC(:,2)==n,1);
%     
%    volMeans(n)=mean(pool);
%    line([volMeans(n) volMeans(n)], [n-.5 n+.5],'color','r')
%     
% end

ylabel('Tbar Vol (nm^3)')
xlabel('Num Postsynaptic Profiles')
set(gca,'FontSize',18)
legend({'Ipsi Syns','Contra Syns'})


figure()
hold on
set(gcf,'color','w')

   
scatter(leftSyns(:,1),leftSyns(:,2), 'k','jitter','on', 'jitterAmount',0.25)
hold on
scatter(rightSyns(:,1),rightSyns(:,2), '*r','jitter','on', 'jitterAmount',0.25)




% %%Calc ave for each post 
% volMeans=[];
% for n=1:11
%     pool=aveSizesBC(aveSizesBC(:,2)==n,1);
%     
%    volMeans(n)=mean(pool);
%    line([volMeans(n) volMeans(n)], [n-.5 n+.5],'color','r')
%     
% end

ylabel('Tbar Vol (nm^3)')
xlabel('Num Postsynaptic Profiles')
set(gca,'FontSize',18)
legend({'Left Syns','Right Syns'})





