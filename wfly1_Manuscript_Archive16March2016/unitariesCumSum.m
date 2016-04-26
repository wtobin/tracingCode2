% import unitaries for a PN

PN_Names={'PN1LS','PN2LS', 'PN3LS', 'PN1RS', 'PN2RS'};

pn=PN_Names{4};

datFile=dir(['~/nC_projects/',pn,'_allORNs/simulations/unitaries/neuron*.dat']);

unitaries=load(['~/nC_projects/',pn,'_allORNs/simulations/unitaries/',datFile.name]);


for i=1:floor(length(unitaries)/8000)
    
    indUnis(i,:)=unitaries([i*8000-7999:i*8000]+3920);
    uniArea(i)=sum(indUnis(i,:)+60);
    uniPeaks(i)=max(indUnis(i,:))+60;
    
end
    
  
sortedUniArea=sort(uniArea, 'descend');
cumSumSortedUniArea=cumsum(sortedUniArea);




sortedUniPeaks=sort(uniPeaks, 'descend');
cumSumSortedUniPeaks=cumsum(sortedUniPeaks);

figure()


scatter([1:52],cumSumSortedUniArea/max(cumSumSortedUniArea))
hold on
scatter([1:52],cumSumSortedUniPeaks/max(cumSumSortedUniPeaks))
grid on




