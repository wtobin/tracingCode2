%% A.   stacked bar chart showing number of ORN synapses onto left PNs (left bar, divided into three parts) and right PNs (right bar, divided into two parts)

load('~/Documents/MATLAB/tracingCode2/wfly1_Manuscript/ornToPn.mat');

ornToRPN(1)=sum(ornToPn(:,3));
ornToRPN(2)=sum(ornToPn(:,4));
ornToRPN(3)=0;

ornToLPN(1)=sum(ornToPn(:,5));
ornToLPN(2)=sum(ornToPn(:,1));
ornToLPN(3)=sum(ornToPn(:,2));

bar([ornToRPN; ornToLPN], 'stacked')