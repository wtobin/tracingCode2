% the purpose of this code is to generate a connected scatter plot of the
% fraction of ORN iputs to each PN that come from ipsi and contra ORNs

%Load the ornToPN connection matrix
load('~/Documents/MATLAB/tracingCode2/wfly1_Manuscript_Archive16March2016/ornToPn.mat');

%Record the total number of input synapses from ipsi and
%contra ORNs for all PNs


numIpsi([1,2,3],1)=sum(ornsToPn(1:27,[1,2,5]));
numIpsi([1,2,3],2)=1;

numContra([1,2,3],1)=sum(ornsToPn(28:end,[1,2,5]));
numContra([1,2,3],2)=2;


numIpsi([4,5],1)=sum(ornsToPn(28:end,[4,3]));
numIpsi([4,5],2)=1;

numContra([4,5],1)=sum(ornsToPn(1:27,[4,3]));
numContra([4,5],2)=2;


%Plotting

figure()
set(gcf,'Color','w')

for p=1:5
    
    scatter(numIpsi(p,2),numIpsi(p,1), 'Filled', 'k')
    hold on
    scatter(numContra(p,2),numContra(p,1),'Filled', 'k')
   
    line([1 2 ], [numIpsi(p,1), numContra(p,1)],'Color', 'k')
    
    xlim([0.5 2.5])
    ylim([200 1000])
    
end

ax=gca;
ax.XTick=[1,2];
ax.XTickLabel={'Ipsi ORNs','Contra ORNs'}
ax.YTick=[200:200:1000];
ylabel('Synapse Number')

saveas(gcf,'ipsiContraORNSynNum')
saveas(gcf,'ipsiContraORNSynNum', 'epsc')


