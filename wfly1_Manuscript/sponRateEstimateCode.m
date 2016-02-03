% open Qs data files sequentially

dates={'05-Jul-2011','08-Jul-2011','11-Aug-2011','11-Jul-2011','12-Jul-2011','12-Oct-2011','15-Jul-2011'}

for d=1:numel(dates)

pathBase=['/home/simulation/Desktop/dualCurrents/',cell2mat(dates(d)),'/'];
trials=dir([pathBase,'Raw_WCwaveform_*']);

%Pick 3 trials at random
workingTrials=[9:11];

for t=1:length(workingTrials)
    load([pathBase,trials(workingTrials(t)).name]);

    plot(current1(20000:22500)-mean(current1(20000:22500)))
    hold on
    plot(current2(20000:22500)-mean(current2(20000:22500)),'m')
    numEPSP=input('How many EPSPs are visible here?');
    %ORN firing rate estimate (EPSC#/time window)/26.5 ave ORN #
    rates(d,t)=(numEPSP/.25)/26.5;
    close gcf
    
end

end

