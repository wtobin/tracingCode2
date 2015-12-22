% A script to start analyzing detTask results



%loop over conditions
dFs=[0:.5:2.5];

for c=1:numel(dFs)

%resultDir=['results/real_dF',num2str(dF),'_rep',num2str(i)]
resultDirs=dir(['~/nC_projects/PN1LS_allORNs/simulations/detTask/results/eq_dF',num2str(dFs(c)),'_rep*']);
resultCounter=1;

for r=1:length(resultDirs)
    
   
    %pull each Vm trace into the workspace
    cd(['~/nC_projects/PN1LS_allORNs/simulations/detTask/results/',resultDirs(r).name])
    fileName=dir(['./neuron*.dat']);
    if isempty(fileName)
    else
    
    pnVm_working=importdata(fileName.name);
    
    %Center the Vm trace around 0mv
    pnVm_working=pnVm_working+59.4;
    
    %Find the mean voltage deflection for the 2nd 100 ms of the trial
    aveDef_eq(c,r)=mean(pnVm_working(4001:end));
    resultCounter=resultCounter+1;
    end
end

numTrials_eq(c)=resultCounter-1;

end
    
    
    

%loop over conditions
dFs=[0:.5:2.5];

for c=1:numel(dFs)

%resultDir=['results/real_dF',num2str(dF),'_rep',num2str(i)]
resultDirs=dir(['~/nC_projects/PN1LS_allORNs/simulations/detTask/results/real_dF',num2str(dFs(c)),'_rep*']);
resultCounter=1;

for r=1:length(resultDirs)
    
   
    %pull each Vm trace into the workspace
    cd(['~/nC_projects/PN1LS_allORNs/simulations/detTask/results/',resultDirs(r).name])
    fileName=dir(['./neuron*.dat']);
    if isempty(fileName)
    else
    
    pnVm_working=importdata(fileName.name);
    
    %Center the Vm trace around 0mv
    pnVm_working=pnVm_working+59.4;
    
    %Find the mean voltage deflection for the 2nd 100 ms of the trial
    aveDef{c}(r)=mean(pnVm_working(4001:end));
    resultCounter=resultCounter+1;
    end
end

numTrials(c)=resultCounter-1;

end

for b=1:numel(dFs)
realMeans(b)=mean(aveDef{b});
realSEMs(b)=std(aveDef{b})./sqrt(numTrials(b));
end

eqMeans=mean(aveDef_eq,2);
eqSEMs=std(aveDef_eq')./sqrt(numTrials_eq-1);


figure()
set(gcf, 'Color', 'w')

for p=1:6
    
    subplot(6,1,p)
    h1=histogram(aveDef{p},50);
    hold on
    h2=histogram(aveDef_eq(p,:),50);
    xlim([0 20])
    ylim([ 0 6000])
    text(13,5000,['Mean real: ', num2str(realMeans(p)) , ' SEM real: ',num2str(realSEMs(p))])
    text(13,4000,['Mean eq: ', num2str(eqMeans(p)) , ' SEM eq: ',num2str(eqSEMs(p))])
    title(['dF: ', num2str(dFs(p))])
    
    if p==6
        xlabel('Mean PN Vm')
        ylabel('Freq')
    end
end
    
    
    
    
    
    

