%Code to analyze base12='~/nC_projects/PN1LS_allORNs/simulations/detTask/results_fixedSpike_12Spikes';
% find the names of all reps in the 12 spike REAL case
real12Dirs=dir([base12,'/real_*']);
counter=1;
for r=1:size(real12Dirs,1)
%Load the pnVm
pnvm_working=importdata([base12,'/',real12Dirs(r).name, '/neuron_PN1_LS_sk_419138_0.dat']);
real12Means(counter)=mean(pnvm_working+59.4);
% vms_real12(counter,:)=pnvm_working;
counter=counter+1;
end
% find the names of all reps in the 12 spike REAL case
eq12Dirs=dir([base12,'/eq_*']);
counter=1;
for r=1:size(eq12Dirs,1)
%Load the pnVm
pnvm_working=importdata([base12,'/',eq12Dirs(r).name, '/neuron_PN1_LS_sk_419138_0.dat']);
eq12Means(counter)=mean(pnvm_working+59.4);
% vms_eq12(counter,:)=pnvm_working;
counter=counter+1;
end
base13='~/nC_projects/PN1LS_allORNs/simulations/detTask/results_fixedSpike_13Spikes';
% find the names of all reps in the 13 spike REAL case
real13Dirs=dir([base13,'/real_*']);
counter=1;
for r=1:size(real13Dirs,1)
%Load the pnVm
pnvm_working=importdata([base13,'/',real13Dirs(r).name, '/neuron_PN1_LS_sk_419138_0.dat']);
real13Means(counter)=mean(pnvm_working+59.4);
% vms_real13(counter,:)=pnvm_working;
counter=counter+1;
end
% find the names of all reps in the 13 spike REAL case
eq13Dirs=dir([base13,'/eq_*']);
counter=1;
for r=1:size(eq13Dirs,1)
%Load the pnVm
pnvm_working=importdata([base13,'/',eq13Dirs(r).name, '/neuron_PN1_LS_sk_419138_0.dat']);
eq13Means(counter)=mean(pnvm_working+59.4);
% vms_eq13(counter,:)=pnvm_working;
counter=counter+1;
end
base14='~/nC_projects/PN1LS_allORNs/simulations/detTask/results_fixedSpike_14Spikes';
% find the names of all reps in the 12 spike REAL case
real14Dirs=dir([base14,'/real_*']);
counter=1;
for r=1:size(real14Dirs,1)
%Load the pnVm
pnvm_working=importdata([base14,'/',real14Dirs(r).name, '/neuron_PN1_LS_sk_419138_0.dat']);
real14Means(counter)=mean(pnvm_working+59.4);
% vms_real14(counter,:)=pnvm_working;
counter=counter+1;
end
% find the names of all reps in the 14 spike REAL case
eq14Dirs=dir([base14,'/eq_*']);
counter=1;
for r=1:size(eq14Dirs,1)
%Load the pnVm
pnvm_working=importdata([base14,'/',eq14Dirs(r).name, '/neuron_PN1_LS_sk_419138_0.dat']);
eq14Means(counter)=mean(pnvm_working+59.4);
% vms_eq14(counter,:)=pnvm_working;
counter=counter+1;
end
base15='~/nC_projects/PN1LS_allORNs/simulations/detTask/results_fixedSpike_15Spikes';
% find the names of all reps in the 15 spike REAL case
real15Dirs=dir([base15,'/real_*']);
counter=1;
for r=1:size(real15Dirs,1)
%Load the pnVm
pnvm_working=importdata([base15,'/',real15Dirs(r).name, '/neuron_PN1_LS_sk_419138_0.dat']);
real15Means(counter)=mean(pnvm_working+59.4);
% vms_real15(counter,:)=pnvm_working;
counter=counter+1;
end
% find the names of all reps in the 15 spike REAL case
eq15Dirs=dir([base15,'/eq_*']);
counter=1;
for r=1:size(eq15Dirs,1)
%Load the pnVm
pnvm_working=importdata([base15,'/',eq15Dirs(r).name, '/neuron_PN1_LS_sk_419138_0.dat']);
eq15Means(counter)=mean(pnvm_working+59.4);
% vms_eq15(counter,:)=pnvm_working;
counter=counter+1;
end
histogram(eq12Means)
size(real12Means)
[real12Means(1:5000)';ones(size(real12Means'))]
[real12Means(1:5000)',ones(size(real12Means'))]
[real12Means(1:5000)',ones(size(real12Means(1:50000)'))]
real12Means(1:5000)'
(size(real12Means(1:50000)')
(size(real12Means(1:50000)'))
size(real12Means(1:5000)')
[real12Means(1:5000)',ones(size(real12Means(1:5000)'))]
['real',num2str(counts),'Means']
counts=13:15;
c=13
['real',num2str(c),'Means']
genvarname(['real',num2str(c),'Means'])
ans
real13Means
higher=genvarname(['real',num2str(c),'Means'])
higher
[[real12Means(1:5000)',ones(size(real12Means(1:5000)'))];[real13Means(1:5000)',ones(size(real13Means(1:5000)'))]]
[[real12Means(1:5000)',ones(size(real12Means(1:5000)'))];[real13Means(1:5000)',2*ones(size(real13Means(1:5000)'))]]
vmMeans=[[real12Means(1:5000)',ones(size(real12Means(1:5000)'))];[real13Means(1:5000)',2*ones(size(real13Means(1:5000)'))]];


cls = fitcdiscr(vmMeans(:,1),vmMeans(:,2));

K=cls.Coeffs(1,2).Const;
L=cls.Coeffs(1,2).Linear;

thresh=-K/L;

thresh

histogram(vmMeans(1:5000,:))
histogram(vmMeans(1:5000,1))
hold on
histogram(vmMeans(1:5000,2))
shg
histogram(vmMeans(1:5000,1))
hold on
histogram(vmMeans(5001:end,1))
shg
if c==1
vmMeans=[[real12Means',ones(size(real12Means'))];[real13Means',2*ones(size(real13Means'))]];
elseif c==2
vmMeans=[[real12Means',ones(size(real12Means'))];[real14Means',2*ones(size(real14Means'))]];
elseif c==3
vmMeans=[[real12Means',ones(size(real12Means'))];[real15Means',2*ones(size(real15Means'))]];
end
if c==1
vmMeans=[[real12Means(1:5000)',ones(size(real12Means(1:5000)'))];[real13Means(1:5000)',2*ones(size(real13Means(1:5000)'))]];
elseif c==2
vmMeans=[[real12Means(1:5000)',ones(size(real12Means(1:5000)'))];[real14Means(1:5000)',2*ones(size(real14Means(1:5000)'))]];
elseif c==3
vmMeans=[[real12Means(1:5000)',ones(size(real12Means(1:5000)'))];[real15Means(1:5000)',2*ones(size(real15Means(1:5000)'))]];
end
[real12Means(1:5000)';real13Means(1:5000)']
predictors=[real12Means(1:5000)';real13Means(1:5000)'];
histogram(predictors)
[ones(size(real12Means(1:5000)'));2*ones(size(real13Means(1:5000)'))]

predictors=[real12Means(1:5000)';real13Means(1:5000)'];
categories=[ones(size(real12Means(1:5000)'));2*ones(size(real13Means(1:5000)'))];
testVals=[real12Means(5001:end)';real13Means(5001:end)'];
testCat=[ones(size(real12Means(5001:end)'));2*ones(size(real13Means(5001:end)'))];
fitcdiscr(predictors,categories);
K=cls.Coeffs(1,2).Const;
L=cls.Coeffs(1,2).Linear;
thresh=-K/L;
thresh
predictors<thresh

(sum(predictors<thresh))== 1)+...
sum(vmMeans(:,2)(find(vmMeans(:,1)>thresh))== 2))/numel(vmMeans(:,2))

numel(categories)
sum(categories(find(predictors<thresh))== 1)+...
sum(categories(find(predictors>thresh))== 2))/numel(categories)
sum(categories(find(predictors<thresh))== 1)
sum(categories(find(predictors>thresh))== 2))
(sum(categories(find(predictors<thresh))== 1)+...
sum(categories(find(predictors>thresh))== 2))/numel(categories)
(sum(testCat(find(testVals<thresh))== 1)+...
sum(testCat(find(testVals>thresh))== 2))/numel(testCat)


for c=1:3
    
if c==1
    
predictors=[real12Means(1:5000)';real13Means(1:5000)'];
categories=[ones(size(real12Means(1:5000)'));2*ones(size(real13Means(1:5000)'))];
testVals=[real12Means(5001:end)';real13Means(5001:end)'];
testCat=[ones(size(real12Means(5001:end)'));2*ones(size(real13Means(5001:end)'))];

elseif c==2
    
predictors=[real12Means(1:5000)';real14Means(1:5000)'];
categories=[ones(size(real12Means(1:5000)'));2*ones(size(real14Means(1:5000)'))];
testVals=[real12Means(5001:end)';real14Means(5001:end)'];
testCat=[ones(size(real12Means(5001:end)'));2*ones(size(real14Means(5001:end)'))];

elseif c==3
    
predictors=[real12Means(1:5000)';real15Means(1:5000)'];
categories=[ones(size(real12Means(1:5000)'));2*ones(size(real15Means(1:5000)'))];
testVals=[real12Means(5001:end)';real15Means(5001:end)'];
testCat=[ones(size(real12Means(5001:end)'));2*ones(size(real15Means(5001:end)'))];

end

% Train a discriminant object on of the sets of repetitions and test it
% on the other

cls = fitcdiscr(predictors,categories);
K=cls.Coeffs(1,2).Const;
L=cls.Coeffs(1,2).Linear;
thresh=-K/L;

%see how well it did on the training data
performance(c,1)=(sum(categories(find(predictors<thresh))== 1)+...
sum(categories(find(predictors>thresh))== 2))/numel(categories)

%see how well it did on the test data
performance(c,2)=(sum(testCat(find(testVals<thresh))== 1)+...
sum(testCat(find(testVals>thresh))== 2))/numel(testCat)

end




for c=1:3
if c==1
predictors=[real12Means(1:5000)';real13Means(1:5000)'];
categories=[ones(size(real12Means(1:5000)'));2*ones(size(real13Means(1:5000)'))];
testVals=[real12Means(5001:end)';real13Means(5001:end)'];
testCat=[ones(size(real12Means(5001:end)'));2*ones(size(real13Means(5001:end)'))];
elseif c==2
predictors=[real12Means(1:5000)';real14Means(1:5000)'];
categories=[ones(size(real12Means(1:5000)'));2*ones(size(real14Means(1:5000)'))];
testVals=[real12Means(5001:end)';real14Means(5001:end)'];
testCat=[ones(size(real12Means(5001:end)'));2*ones(size(real14Means(5001:end)'))];
elseif c==3
predictors=[real12Means(1:5000)';real15Means(1:5000)'];
categories=[ones(size(real12Means(1:5000)'));2*ones(size(real15Means(1:5000)'))];
testVals=[real12Means(5001:end)';real15Means(5001:end)'];
testCat=[ones(size(real12Means(5001:end)'));2*ones(size(real15Means(5001:end)'))];
end
% Train a discriminant object on of the sets of repetitions and test it
% on the other
cls = fitcdiscr(predictors,categories);
K=cls.Coeffs(1,2).Const;
L=cls.Coeffs(1,2).Linear;
thresh=-K/L;
%see how well it did on the training data
performance_real(c,1)=(sum(categories(find(predictors<thresh))== 1)+...
sum(categories(find(predictors>thresh))== 2))/numel(categories)
%see how well it did on the test data
performance_real(c,2)=(sum(testCat(find(testVals<thresh))== 1)+...
sum(testCat(find(testVals>thresh))== 2))/numel(testCat)
end
for c=1:3
if c==1
predictors=[eq12Means(1:5000)';eq13Means(1:5000)'];
categories=[ones(size(eq12Means(1:5000)'));2*ones(size(eq13Means(1:5000)'))];
testVals=[eq12Means(5001:end)';eq13Means(5001:end)'];
testCat=[ones(size(eq12Means(5001:end)'));2*ones(size(eq13Means(5001:end)'))];
elseif c==2
predictors=[eq12Means(1:5000)';eq14Means(1:5000)'];
categories=[ones(size(eq12Means(1:5000)'));2*ones(size(eq14Means(1:5000)'))];
testVals=[eq12Means(5001:end)';eq14Means(5001:end)'];
testCat=[ones(size(eq12Means(5001:end)'));2*ones(size(eq14Means(5001:end)'))];
elseif c==3
predictors=[eq12Means(1:5000)';eq15Means(1:5000)'];
categories=[ones(size(eq12Means(1:5000)'));2*ones(size(eq15Means(1:5000)'))];
testVals=[eq12Means(5001:end)';eq15Means(5001:end)'];
testCat=[ones(size(eq12Means(5001:end)'));2*ones(size(eq15Means(5001:end)'))];
end
% Train a discriminant object on of the sets of repetitions and test it
% on the other
cls = fitcdiscr(predictors,categories);
K=cls.Coeffs(1,2).Const;
L=cls.Coeffs(1,2).Linear;
thresh=-K/L;
%see how well it did on the training data
performance_eq(c,1)=(sum(categories(find(predictors<thresh))== 1)+...
sum(categories(find(predictors>thresh))== 2))/numel(categories)
%see how well it did on the test data
performance_eq(c,2)=(sum(testCat(find(testVals<thresh))== 1)+...
sum(testCat(find(testVals>thresh))== 2))/numel(testCat)
end
plot(performance_real(:,2))
hold on
plot(performance_eq(:,2))
shg
set(gcf,'Color','w')
xTick([1:1:3])
tic([1:1:3])
f1=figure()
set(gcf, 'Color', 'w');
plot(performance_real)
hold on
plot(performance_eq)
close all
f1=figure()
set(gcf, 'Color', 'w');
plot(performance_real(:,2))
hold on
plot(performance_eq(:,2))
set(gca, 'XTick',[1:1:3])
f1=figure()
set(gcf, 'Color', 'w');
plot(performance_real(:,2))
hold on
plot(performance_eq(:,2))
set(gca, 'XTick',[1:1:3])
xlabel('Spike Count Difference')
ylabel('Performance')
leg={'real contact num', 'equalized'};
legend(leg, 'Position','NorthWest')
legend(leg, 'Location','NorthWest')
%-- 01/18/2016 04:39:13 PM --%