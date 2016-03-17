% code to plot an example unitary and miniEPSP
%Load PN1 uEPSPs and mEPSPs using uEPSP_AmpWorking_wcl.m and
%mEPSP_AmpWorking_wcl.m

% FInd the largest and smallest uEPSP and mEPSP for L PN2
    
pn1UEPSPs=[leftUEPSPs{1}];
pn1MEPSPs=[leftMEPSPs{1}]; 

for t=1:size(pn1UEPSPs,1)
    
    uniAmps(t)=max(pn1UEPSPs(t,:))+60;
    
end


for t=1:size(pn1MEPSPs,1)
    
    miniAmps(t)=max(pn1MEPSPs(t,:))+60;
    
end


[uMax uMaxI]=max(uniAmps)
[uMin uMinI]=min(uniAmps)

[mMax mMaxI]=max(miniAmps)
[mMin mMinI]=min(miniAmps)


figure()
set(gcf, 'Color','w')
plot([0:1/40:125],pn1UEPSPs(uMaxI,1:5001), 'color', [.5 .5 .5])
hold on
plot([0:1/40:125],pn1UEPSPs(uMinI,1:5001), 'color', [.5 .5 .5])

plot([0:1/40:125],pn1MEPSPs(mMaxI,1:5001), 'k')
plot([0:1/40:125],pn1MEPSPs(mMinI,1:5001), 'k')

ylim([-60.1 -50])
ax=gca;
ax.YTick=[-60:10:-50];
xlim([0 120])
ax.XTick=[0:120:120];
ax.FontSize=18;
ylabel('Vm (mV)');
xlabel('Time (ms)');

saveas(gcf,'exampleEPSPs')
saveas(gcf,'exampleEPSPs','epsc')