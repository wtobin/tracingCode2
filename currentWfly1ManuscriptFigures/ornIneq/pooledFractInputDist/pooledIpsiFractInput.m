%The purpose of this code is to generate a histogram of the fractional
%input supplied by each ORN to its ipsi PN targets.

%load orn to PN connectivity matrix

load('~/Documents/MATLAB/tracingCode2/wfly1_Manuscript_Archive16March2016/ornToPn.mat')

ipsiConsL(1:27,1:3)=ornsToPn(1:27,[1,2,5]);
ipsiConsR(1:26,1:2)=ornsToPn(28:end,[3,4]);
normIpsiConsL=bsxfun(@rdivide, ipsiConsL,sum(ipsiConsL));
normIpsiConsR=bsxfun(@rdivide, ipsiConsR,sum(ipsiConsR));



%pool these values and exclude zeros
pooledNormIpsiOrnToP=[normIpsiConsL(:);normIpsiConsR(:)];


%plotting

figure()
set(gcf, 'Color', 'w')
h1=histogram(pooledNormIpsiOrnToP, 'FaceColor','k');
xlim([0 2*mean(pooledNormIpsiOrnToP)])
ax = gca;
ax.FontSize=16;
ylabel('Frequency')
xlabel('Fractional Input')
axis square
text(3, 2.5, ['CV: ',num2str(std(pooledNormIpsiOrnToP)/mean(pooledNormIpsiOrnToP))], 'FontSize',16)
saveas(gcf,'pooledIpsiFractInput','epsc')
saveas(gcf,'pooledIpsiFractInput')