%Load data non bias corrected
load('~/Documents/MATLAB/tracingCode2/synapseSizeScripts/elementSizes_comp.mat')

%Load data bias corrected
load('~/Documents/MATLAB/tracingCode2/synapseSizeScripts/biasCorrSizes.mat')



tbarVolsByTracer=[];
pnAreaByTracer=[];

tbarVolsByTracerBC=[];
pnAreaByTracerBC=[];

synapseCounter=1;

%loop over orns
for o=1:10
    
    %loop over PNs
    for p=1:5
        
        %Look at tracer 1s seg simply to find # of syns at this connection
        seg=biasCorrSizes{o,p,1};
        
        %Loop over synapses
        for s=1:size(seg,1)
            
            %Loop over users
            for u=1:4
                
                tbarVolsByTracer(synapseCounter,u)=elementSizes_comp{o,p,u}(s,1);
                pnAreaByTracer(synapseCounter,u)=elementSizes_comp{o,p,u}(s,2);
                
                
                tbarVolsByTracerBC(synapseCounter,u)=biasCorrSizes{o,p,u}(s,1);
                pnAreaByTracerBC(synapseCounter,u)=biasCorrSizes{o,p,u}(s,2);
                
            end
            
            synapseCounter=synapseCounter+1;
            
        end
        
    end
end


figure()
hold on

subplot(2,3,1)
scatter(tbarVolsByTracer(:,1),tbarVolsByTracer(:,2))
refline(1,0)
xlabel('Tracer 1 Segmentation')
ylabel('Tracer 2 Seg')
set(gca,'FontSize',18)
title('Tbar Vol')

subplot(2,3,2)
scatter(tbarVolsByTracer(:,1),tbarVolsByTracer(:,3))
refline(1,0)
xlabel('Tracer 1 Segmentation')
ylabel('Tracer 3 Seg')

set(gca,'FontSize',18)
title('Tbar Vol')

subplot(2,3,3)
scatter(tbarVolsByTracer(:,1),tbarVolsByTracer(:,4))
refline(1,0)
xlabel('Tracer 1 Segmentation')
ylabel('Tracer 4 Seg')
set(gca,'FontSize',18)
title('Tbar Vol')

subplot(2,3,4)
scatter(tbarVolsByTracer(:,2),tbarVolsByTracer(:,3))
refline(1,0)
xlabel('Tracer 2 Segmentation')
ylabel('Tracer 3 Seg')
set(gca,'FontSize',18)
title('Tbar Vol')

subplot(2,3,5)
scatter(tbarVolsByTracer(:,2),tbarVolsByTracer(:,4))
refline(1,0)
xlabel('Tracer 2 Segmentation')
ylabel('Tracer 4 Seg')
set(gca,'FontSize',18)
title('Tbar Vol')

subplot(2,3,6)
scatter(tbarVolsByTracer(:,3),tbarVolsByTracer(:,4))
refline(1,0)
xlabel('Tracer 3 Segmentation')
ylabel('Tracer 4 Seg')
set(gca,'FontSize',18)
title('Tbar Vol')




figure()
hold on

subplot(2,3,1)
scatter(tbarVolsByTracerBC(:,1),tbarVolsByTracerBC(:,2))
refline(1,0)
xlabel('Tracer 1 Segmentation')
ylabel('Tracer 2 Seg')
set(gca,'FontSize',18)
title('Tbar Vol')

subplot(2,3,2)
scatter(tbarVolsByTracerBC(:,1),tbarVolsByTracerBC(:,3))
refline(1,0)
xlabel('Tracer 1 Segmentation')
ylabel('Tracer 3 Seg')

set(gca,'FontSize',18)
title('Tbar Vol')

subplot(2,3,3)
scatter(tbarVolsByTracerBC(:,1),tbarVolsByTracerBC(:,4))
refline(1,0)
xlabel('Tracer 1 Segmentation')
ylabel('Tracer 4 Seg')
set(gca,'FontSize',18)
title('Tbar Vol')

subplot(2,3,4)
scatter(tbarVolsByTracerBC(:,2),tbarVolsByTracerBC(:,3))
refline(1,0)
xlabel('Tracer 2 Segmentation')
ylabel('Tracer 3 Seg')
set(gca,'FontSize',18)
title('Tbar Vol')

subplot(2,3,5)
scatter(tbarVolsByTracerBC(:,2),tbarVolsByTracerBC(:,4))
refline(1,0)
xlabel('Tracer 2 Segmentation')
ylabel('Tracer 4 Seg')
set(gca,'FontSize',18)
title('Tbar Vol')

subplot(2,3,6)
scatter(tbarVolsByTracerBC(:,3),tbarVolsByTracerBC(:,4))
refline(1,0)
xlabel('Tracer 3 Segmentation')
ylabel('Tracer 4 Seg')
set(gca,'FontSize',18)
title('Tbar Vol')





figure()
hold on

subplot(2,3,1)
scatter(tbarVolsByTracer(:,1),tbarVolsByTracer(:,2))
refline(1,0)
xlabel('Tracer 1 Segmentation')
ylabel('Tracer 2 Seg')
set(gca,'FontSize',18)
title('Tbar Vol')

subplot(2,3,2)
scatter(tbarVolsByTracer(:,1),tbarVolsByTracer(:,3))
refline(1,0)
xlabel('Tracer 1 Segmentation')
ylabel('Tracer 3 Seg')

set(gca,'FontSize',18)
title('Tbar Vol')

subplot(2,3,3)
scatter(tbarVolsByTracer(:,1),tbarVolsByTracer(:,4))
refline(1,0)
xlabel('Tracer 1 Segmentation')
ylabel('Tracer 4 Seg')
set(gca,'FontSize',18)
title('Tbar Vol')

subplot(2,3,4)
scatter(tbarVolsByTracer(:,2),tbarVolsByTracer(:,3))
refline(1,0)
xlabel('Tracer 2 Segmentation')
ylabel('Tracer 3 Seg')
set(gca,'FontSize',18)
title('Tbar Vol')

subplot(2,3,5)
scatter(tbarVolsByTracer(:,2),tbarVolsByTracer(:,4))
refline(1,0)
xlabel('Tracer 2 Segmentation')
ylabel('Tracer 4 Seg')
set(gca,'FontSize',18)
title('Tbar Vol')

subplot(2,3,6)
scatter(tbarVolsByTracer(:,3),tbarVolsByTracer(:,4))
refline(1,0)
xlabel('Tracer 3 Segmentation')
ylabel('Tracer 4 Seg')
set(gca,'FontSize',18)
title('Tbar Vol')




figure()
hold on

subplot(2,3,1)
scatter(pnAreaByTracer(:,1),pnAreaByTracer(:,2))
refline(1,0)
xlabel('Tracer 1 Segmentation')
ylabel('Tracer 2 Seg')
set(gca,'FontSize',18)
title('PN Area')

subplot(2,3,2)
scatter(pnAreaByTracer(:,1),pnAreaByTracer(:,3))
refline(1,0)
xlabel('Tracer 1 Segmentation')
ylabel('Tracer 3 Seg')
set(gca,'FontSize',18)
title('PN Area')

subplot(2,3,3)
scatter(pnAreaByTracer(:,1),pnAreaByTracer(:,4))
refline(1,0)
xlabel('Tracer 1 Segmentation')
ylabel('Tracer 4 Seg')
set(gca,'FontSize',18)
title('PN Area')

subplot(2,3,4)
scatter(pnAreaByTracer(:,2),pnAreaByTracer(:,3))
refline(1,0)
xlabel('Tracer 2 Segmentation')
ylabel('Tracer 3 Seg')
set(gca,'FontSize',18)
title('PN Area')

subplot(2,3,5)
scatter(pnAreaByTracer(:,2),pnAreaByTracer(:,4))
refline(1,0)
xlabel('Tracer 2 Segmentation')
ylabel('Tracer 4 Seg')
set(gca,'FontSize',18)
title('PN Area')

subplot(2,3,6)
scatter(pnAreaByTracer(:,3),pnAreaByTracer(:,4))
refline(1,0)
xlabel('Tracer 3 Segmentation')
ylabel('Tracer 4 Seg')
set(gca,'FontSize',18)
title('PN Area')



%Before bias correction
figure()
set(gcf, 'color', 'w')
subplot(1,2,1)


dataForBoxplot=[[tbarVolsByTracer(:,1),zeros(length(tbarVolsByTracer),1)];...
    [tbarVolsByTracer(:,2),ones(length(tbarVolsByTracer),1)];...
    [tbarVolsByTracer(:,3),2*ones(length(tbarVolsByTracer),1)];...
    [tbarVolsByTracer(:,4),3*ones(length(tbarVolsByTracer),1)]];

boxplot(dataForBoxplot(:,1),dataForBoxplot(:,2),'Notch','on')

xlabel('Tracer ID')
ylabel('Tbar Vol (nm^3)')
title('Before Bias Correction')
set(gca,'FontSize',18)

%After bias correction

subplot(1,2,2)
title('Before Bias Correction')
dataForBoxplot=[[tbarVolsByTracerBC(:,1),zeros(length(tbarVolsByTracerBC),1)];...
    [tbarVolsByTracerBC(:,2),ones(length(tbarVolsByTracerBC),1)];...
    [tbarVolsByTracerBC(:,3),2*ones(length(tbarVolsByTracerBC),1)];...
    [tbarVolsByTracerBC(:,4),3*ones(length(tbarVolsByTracerBC),1)]];

boxplot(dataForBoxplot(:,1),dataForBoxplot(:,2),'Notch','on')

xlabel('Tracer ID')
ylabel('Tbar Vol (nm^3)')
title('After')
set(gca,'FontSize',18)





figure()

dataForBoxplot=[[pnAreaByTracer(:,1),zeros(length(pnAreaByTracer),1)];...
    [pnAreaByTracer(:,2),ones(length(pnAreaByTracer),1)];...
    [pnAreaByTracer(:,3),2*ones(length(pnAreaByTracer),1)];...
    [pnAreaByTracer(:,4),3*ones(length(pnAreaByTracer),1)]];

boxplot(dataForBoxplot(:,1),dataForBoxplot(:,2),'Notch','on')

xlabel('Tracer ID')
set(gca,'FontSize',18)


    
