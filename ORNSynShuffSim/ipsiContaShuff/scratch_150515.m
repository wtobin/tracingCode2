

for j=1:5
    nIpsiContraDists(:,j)=ipsiContraDists(:,j)/max(ipsiContraDists(:,j));
end


titles={'PN3 LS', 'PN2 LS', 'PN1 RS', 'PN2 RS', 'PN1 LS'};

for i=1:length(PNs)
    
    
    subplot(2,3,i)
    
    boxplot(ipsiContraDists(:,i),[zeros(25,1);ones(25,1)], 'notch', 'on')
    set(gca,'XTickLabel',['Left ORNs ';'Right ORNs'])
    ylabel('contact averaged path length')
    title(titles(i))
    set(gcf,'color','w');
    
end

plot(realPathsL)


for p=1:5
    
    collectedPathLengths=[];
     groups=[];

for j=1:50
    
    ind=i(j,p);
    
    if ind<=25
    
    collectedPathLengths=[collectedPathLengths,realPathsToIntegratorL{p}{i(j,p)}];
    groups=[groups, ind*ones(1,length(realPathsToIntegratorL{p}{i(j,p)}))];
    
    
    else 



    collectedPathLengths=[collectedPathLengths,realPathsToIntegratorR{p}{i(j,p)-25}];
    groups=[groups, (ind)*ones(1,length(realPathsToIntegratorR{p}{i(j,p)-25}))];
    
    end
end
        
 subplot(2,3,p)
 hold on
 scatter(collectedPathLengths,groups)
 

end




for p=1:5
    
collectedPathLengths=[];
groups=[];

for j=1:length(realPathsToIntegratorR{p})
    collectedPathLengths=[collectedPathLengths,realPathsToIntegratorR{p}{j}];
    groups=[groups, j*ones(1,length(realPathsToIntegratorR{p}{j}))];
end
        
 subplot(2,3,p)
 hold on
 
 scatter(collectedPathLengths,groups, 'r')
 
end
