%% A.   stacked bar chart showing number of ORN synapses onto left PNs (left bar, divided into three parts) and right PNs (right bar, divided into two parts)

% load('~/Dropbox/htem_team/code/wtobin/tracingCode2/wfly1_Manuscript/ornToPn.mat');
load('~/Documents/MATLAB/tracingCode2/wfly1_Manuscript_Archive16March2016/ornToPn.mat');


% ornToRPN(1)=sum(ornToPn(:,3));
% ornToRPN(2)=sum(ornToPn(:,4));
% ornToRPN(3)=0;
% 
% ornToLPN(1)=sum(ornToPn(:,5));
% ornToLPN(2)=sum(ornToPn(:,1));
% ornToLPN(3)=sum(ornToPn(:,2));

% order leftPNs1-3: 1,2,5 and right PNs1-2: 4,3  % 151230 WCL corresponded to catmaid2
ornToRPN(1)=sum(ornsToPn(:,4));
ornToRPN(2)=sum(ornsToPn(:,3));
ornToRPN(3)=0;

ornToLPN(1)=sum(ornsToPn(:,1));
ornToLPN(2)=sum(ornsToPn(:,2));
ornToLPN(3)=sum(ornsToPn(:,5));

figure()
bar([ornToLPN; ornToRPN],.7, 'stacked')
set(gcf, 'Color', 'w')
colormap('winter')
ax=gca;
xlim([0 3]);
ax.XTick=[1:2];
ax.XTickLabel={'Left PNs', 'Right PNs'};
ax.FontSize=14;
ylabel('ORN-->PN Contact Num', 'FontSize', 16);

axis square

saveas(gcf,'ornToPNSynNums')
saveas(gcf,'ornToPNSynNums','epsc')


