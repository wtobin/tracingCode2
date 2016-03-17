%The purpose of this code is to generate a two bar bar graph showing the
%mean left and right PN compartmental input resistance

%Load the relevant PN response matrix into the workplace
load('~/nC_projects/inputR_responses.mat')

%Calculate the inputR for each compartment

for p=1:5
    
    for a=1:size(inputR_responses{p},1)
        
        inputR{p}(a)=(mean(inputR_responses{p}(a,12000:13500))+60)/0.01;
        
    end
  
end


% generate some group statistical descriptions
leftInputRs=[inputR{1},inputR{2},inputR{3}]/1000;
rightInputRs=[inputR{4},inputR{5}]/1000;

gpsU = [ones(size(leftInputRs)),2.*ones(size(rightInputRs))];
valsU = [leftInputRs,rightInputRs];
[YUmean,YUsem,YUstd,YUci] = grpstats(valsU,gpsU,{'mean','sem','std','meanci'});


%plotting
figure
set(gcf,'Color', 'w')
bar(YUmean,.4,'FaceColor','k','LineWidth',2)
hold on
he = errorbar(YUmean,YUsem,'k','LineStyle','none'); % error bars are std
he.LineWidth=1;
xlim([0.5 2.5])
 ylim([0 1.8])
ax = gca;
ax.XTick = [1 2];
ax.XTickLabel = {'Left PNs';'RightPNs'};
ax.FontSize=16;
ylabel('Input R (GOhms)')
axis square
saveas(gcf,'leftRightInputR')
saveas(gcf,'leftRightInputR','epsc')


