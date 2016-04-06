%The purpose of this code is to generate a histogram of the fractional
%input each ORN provides one example PN (PNLS1).


%load orn to PN connectivity matrix
load('~/Dropbox/htem_team/code/wtobin/tracingCode2/wfly1_Manuscript_Archive16March2016/ornToPn.mat')

ipsiConsL(1:27,1:3)=ornsToPn(1:27,[1,2,5]);
ipsiConsR(1:26,1:2)=ornsToPn(28:end,[3,4]);
% normIpsiConsL=bsxfun(@rdivide, ipsiConsL,sum(ipsiConsL));
% normIpsiConsR=bsxfun(@rdivide, ipsiConsR,sum(ipsiConsR));

nBins = 10;

%plotting
figure()
set(gcf, 'Color', 'w')
h1=histogram(ipsiConsL(:,1), nBins, 'FaceColor','k');
xlim([0 2*mean(ipsiConsL(:,1))])
ax = gca;
ax.FontSize=16;
ylabel('Frequency')
xlabel('Synapses Per Connection')
% axis square
text(3, 5, ['CV: ',num2str(std(ipsiConsL(:,1))/mean(ipsiConsL(:,1)))], 'FontSize',16)
saveas(gcf,'exampleSynsPerConn','epsc')
saveas(gcf,'exampleSynsPerConn')